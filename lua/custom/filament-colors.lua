-- Filament semantic color highlighter
-- Maps to Filament\Support\Colors\ColorManager defaults:
--   danger  => Color::Red    (#ef4444)
--   info    => Color::Blue   (#3b82f6)
--   success => Color::Green  (#22c55e)
--   warning => Color::Amber  (#f59e0b)
--   gray    => Color::Gray   (#6b7280)
--   primary => Color::Amber  (panel override → #f59e0b)

local filament_colors = {
  danger  = { fg = '#ffffff', bg = '#ef4444' },
  info    = { fg = '#ffffff', bg = '#3b82f6' },
  success = { fg = '#ffffff', bg = '#22c55e' },
  warning = { fg = '#000000', bg = '#f59e0b' },
  gray    = { fg = '#ffffff', bg = '#6b7280' },
  primary = { fg = '#000000', bg = '#f59e0b' },
}

local ns = vim.api.nvim_create_namespace 'filament_colors'

for name, hl in pairs(filament_colors) do
  vim.api.nvim_set_hl(0, 'FilamentColor_' .. name, hl)
end

local function highlight_buffer(bufnr)
  vim.api.nvim_buf_clear_namespace(bufnr, ns, 0, -1)
  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)

  for color_name in pairs(filament_colors) do
    local hl_name = 'FilamentColor_' .. color_name
    for lnum, line in ipairs(lines) do
      for _, quote in ipairs { "'", '"' } do
        local pattern = quote .. color_name .. quote
        local s = 1
        while true do
          local start_col, end_col = line:find(pattern, s, true)
          if not start_col then
            break
          end
          vim.api.nvim_buf_set_extmark(bufnr, ns, lnum - 1, start_col - 1, {
            end_col = end_col,
            hl_group = hl_name,
          })
          s = end_col + 1
        end
      end
    end
  end
end

vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave', 'TextChanged' }, {
  pattern = { '*.php', '*.blade.php' },
  callback = function(args)
    highlight_buffer(args.buf)
  end,
})
