-- Copy the current buffer's path to the system clipboard.
--   :CopyPath      -> path relative to the current working directory
--   :CopyPathFull  -> absolute path
-- Lowercase abbreviations (:copypath / :copypathfull) are mapped to these,
-- since Neovim user commands must start with an uppercase letter.

local function copy(modifier, label)
  local name = vim.api.nvim_buf_get_name(0)
  if name == '' then
    vim.notify('No file in current buffer', vim.log.levels.WARN)
    return
  end
  local path = vim.fn.fnamemodify(name, modifier)
  vim.fn.setreg('+', path) -- system clipboard
  vim.fn.setreg('"', path) -- unnamed register
  vim.notify(label .. ': ' .. path, vim.log.levels.INFO)
end

local function copy_relative()
  copy(':.', 'Copied relative path')
end

local function copy_full()
  copy(':p', 'Copied full path')
end

vim.api.nvim_create_user_command('CopyPath', copy_relative, { desc = 'Copy buffer path relative to cwd' })
vim.api.nvim_create_user_command('CopyPathFull', copy_full, { desc = 'Copy buffer absolute path' })

vim.keymap.set('n', '<leader>yp', copy_relative, { desc = '[Y]ank relative [p]ath' })
vim.keymap.set('n', '<leader>yP', copy_full, { desc = '[Y]ank full [P]ath' })

-- Allow lowercase typing: :copypath / :copypathfull expand to the commands.
vim.cmd [[
  cnoreabbrev <expr> copypath     (getcmdtype() == ':' && getcmdline() ==# 'copypath')     ? 'CopyPath'     : 'copypath'
  cnoreabbrev <expr> copypathfull (getcmdtype() == ':' && getcmdline() ==# 'copypathfull') ? 'CopyPathFull' : 'copypathfull'
]]
