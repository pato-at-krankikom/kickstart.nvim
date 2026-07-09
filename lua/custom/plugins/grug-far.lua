-- Project-wide find & replace with live preview (ripgrep-backed).
-- https://github.com/MagicDuck/grug-far.nvim
return {
  'MagicDuck/grug-far.nvim',
  cmd = 'GrugFar',
  opts = {},
  keys = {
    {
      '<leader>sR',
      function()
        require('grug-far').open()
      end,
      mode = { 'n' },
      desc = '[S]earch and [R]eplace (project)',
    },
    {
      '<leader>sR',
      function()
        require('grug-far').open { prefills = { search = vim.fn.expand '<cword>' } }
      end,
      mode = { 'v' },
      desc = '[S]earch and [R]eplace selection',
    },
  },
}
