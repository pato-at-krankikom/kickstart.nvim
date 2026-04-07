return {
  'akinsho/bufferline.nvim',
  version = '*',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = {
    options = {
      diagnostics = 'nvim_lsp', -- show LSP diagnostics in tabs
      offsets = {
        {
          filetype = 'neo-tree',
          text = 'File Explorer',
          highlight = 'Directory',
          separator = true,
        },
      },
    },
  },
  keys = {
    { '<Tab>', '<cmd>BufferLineCycleNext<CR>', desc = 'Next buffer tab' },
    { '<S-Tab>', '<cmd>BufferLineCyclePrev<CR>', desc = 'Prev buffer tab' },
    { '<leader>x', '<cmd>bdelete<CR>', desc = 'Close buffer tab' },
  },
}
