-- Sticky context: keep the current function/class/method header pinned
-- at the top of the window while scrolling.
-- https://github.com/nvim-treesitter/nvim-treesitter-context
return {
  'nvim-treesitter/nvim-treesitter-context',
  event = { 'BufReadPost', 'BufNewFile' },
  opts = {
    max_lines = 4, -- how many context lines to show at most
    multiline_threshold = 1, -- collapse multiline context to a single line
    trim_scope = 'outer',
  },
  keys = {
    { '<leader>tc', '<cmd>TSContextToggle<cr>', desc = '[T]oggle treesitter [c]ontext' },
    {
      '[x',
      function()
        require('treesitter-context').go_to_context(vim.v.count1)
      end,
      desc = 'Jump to context (upwards)',
    },
  },
}
