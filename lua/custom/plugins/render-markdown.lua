return {
  'MeanderingProgrammer/render-markdown.nvim',
  dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.nvim' },
  ---@module 'render-markdown'
  ---@type render.md.UserConfig
  opts = {},
  keys = {
    { '<leader>tm', '<cmd>RenderMarkdown buf_toggle<cr>', desc = '[T]oggle [M]arkdown rendering' },
  },
}
