-- LSP debugging hooks. Not loaded by default — enable by adding
--   require 'custom.debug-uri'
-- to init.lua (right after `require 'custom.filament-colors'`) when
-- you need to diagnose LSP start/URI/RPC problems. Remove the require
-- line again once you're done.
--
-- What it does:
--   1. Wraps vim.uri_to_fname / vim.uri_to_bufnr to catch "unknown scheme"
--      style errors from local URI conversions, with a full stack trace.
--   2. Wraps vim.lsp.rpc.start so every out-of-process LSP's rpc.request
--      is intercepted — any RPC error response is logged with cmd, method,
--      and (truncated) params.
--   3. Wraps vim.lsp.start to log every LSP being started (name, cmd,
--      root_dir, workspace_folders, filetypes), and wraps config.on_error
--      to surface post-init errors.
--   4. LspAttach autocmd wraps each client:request so response errors
--      after attach are also surfaced with client name + method + params.
--
-- Notes:
--   - Servers whose `cmd` is a Lua function (e.g. some lspconfig-wrapped
--     servers like tailwindcss) bypass vim.lsp.rpc.start, so (2) won't
--     see them. The LspAttach wrapper in (4) still covers them once
--     they've finished initialize. If initialize itself fails for a
--     function-cmd server, you'll typically narrow it down by elimination
--     from the `LSP start:` logs in (3).

local orig_to_fname = vim.uri_to_fname
vim.uri_to_fname = function(uri)
  local ok, res = pcall(orig_to_fname, uri)
  if not ok then
    vim.notify(
      ('uri_to_fname failed for %q\nerror: %s\n%s'):format(tostring(uri), tostring(res), debug.traceback()),
      vim.log.levels.WARN
    )
    return ''
  end
  return res
end

local orig_to_bufnr = vim.uri_to_bufnr
vim.uri_to_bufnr = function(uri)
  local ok, res = pcall(orig_to_bufnr, uri)
  if not ok then
    vim.notify(
      ('uri_to_bufnr failed for %q\nerror: %s\n%s'):format(tostring(uri), tostring(res), debug.traceback()),
      vim.log.levels.WARN
    )
    return -1
  end
  return res
end

-- Wrap vim.lsp.rpc.start so we can tag every rpc object with the
-- server cmd and intercept RPC error responses (including initialize).
local orig_rpc_start = vim.lsp.rpc.start
vim.lsp.rpc.start = function(cmd, dispatchers, extra_spawn_params)
  local rpc = orig_rpc_start(cmd, dispatchers, extra_spawn_params)
  if not rpc then return rpc end
  local orig_request = rpc.request
  rpc.request = function(method, params, callback, notify_reply_callback)
    local wrapped = function(err, result)
      if err then
        vim.schedule(function()
          vim.notify(
            ('LSP rpc error\n  cmd: %s\n  method: %s\n  err: %s\n  params (truncated): %s'):format(
              vim.inspect(cmd),
              tostring(method),
              vim.inspect(err),
              vim.inspect(params):sub(1, 500)
            ),
            vim.log.levels.WARN
          )
        end)
      end
      if callback then return callback(err, result) end
    end
    return orig_request(method, params, wrapped, notify_reply_callback)
  end
  return rpc
end

-- Wrap vim.lsp.start so we can see every LSP being started with
-- its cmd, root_dir, workspace_folders and filetypes. When a server
-- rejects its `initialize` handshake it fails before LspAttach fires,
-- so this is the earliest reliable hook.
local orig_start = vim.lsp.start
vim.lsp.start = function(config, opts)
  vim.schedule(function()
    vim.notify(
      ('LSP start: %s\n  cmd: %s\n  root_dir: %s\n  workspace_folders: %s\n  filetypes: %s'):format(
        tostring(config and config.name),
        vim.inspect(config and config.cmd),
        tostring(config and config.root_dir),
        vim.inspect(config and config.workspace_folders),
        vim.inspect(config and config.filetypes)
      ),
      vim.log.levels.INFO
    )
  end)

  -- Wrap on_error so we also catch initialize-time failures routed there.
  local user_on_error = config and config.on_error
  if config then
    config.on_error = function(code, err)
      vim.schedule(function()
        vim.notify(
          ('LSP on_error: %s\n  code: %s\n  err: %s'):format(
            tostring(config.name),
            tostring(code),
            vim.inspect(err)
          ),
          vim.log.levels.WARN
        )
      end)
      if user_on_error then return user_on_error(code, err) end
    end
  end

  return orig_start(config, opts)
end

-- Intercept LSP response errors post-attach so we can see which client
-- + method returns an error (and the params we sent it).
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if not client or client._debug_wrapped then return end
    client._debug_wrapped = true

    local orig_request = client.request
    client.request = function(self, method, params, handler, bufnr)
      local wrapped = function(err, result, ctx, config)
        if err then
          vim.schedule(function()
            vim.notify(
              ('LSP error\n  client: %s\n  method: %s\n  err: %s\n  params: %s'):format(
                self.name,
                method,
                vim.inspect(err),
                vim.inspect(params)
              ),
              vim.log.levels.WARN
            )
          end)
        end
        if handler then return handler(err, result, ctx, config) end
      end
      return orig_request(self, method, params, wrapped, bufnr)
    end
  end,
})
