return {
  'echasnovski/mini.diff',
  version = false,
  event = { 'BufReadPre', 'BufNewFile' },
  keys = {
    { '<leader>go', function() require('mini.diff').toggle_overlay() end, desc = '[G]it diff [o]verlay toggle' },
  },
  config = function()
    require('mini.diff').setup {
      view = {
        style = 'sign',
        signs = { add = '+', change = '~', delete = '-' },
      },
    }
  end,
}
