return {
  {
    'stevearc/quicker.nvim',
    event = 'FileType qf',
    opts = {},
    keys = {
      { '<leader>xq', function() require('quicker').toggle() end, desc = 'Toggle quickfix list' },
      { '<leader>xl', function() require('quicker').toggle { loclist = true } end, desc = 'Toggle location list' },
    },
  },
}
