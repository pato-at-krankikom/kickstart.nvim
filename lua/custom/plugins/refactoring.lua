-- Refactoring operations (extract function/variable, inline var, etc.)
-- https://github.com/ThePrimeagen/refactoring.nvim
return {
  'ThePrimeagen/refactoring.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
  },
  opts = {},
  keys = {
    { '<leader>re', function() require('refactoring').refactor 'Extract Function' end, mode = 'x', desc = 'Extract function' },
    { '<leader>rf', function() require('refactoring').refactor 'Extract Function To File' end, mode = 'x', desc = 'Extract function to file' },
    { '<leader>rv', function() require('refactoring').refactor 'Extract Variable' end, mode = 'x', desc = 'Extract variable' },
    { '<leader>ri', function() require('refactoring').refactor 'Inline Variable' end, mode = { 'n', 'x' }, desc = 'Inline variable' },
    { '<leader>rb', function() require('refactoring').refactor 'Extract Block' end, mode = 'n', desc = 'Extract block' },
    { '<leader>rr', function() require('refactoring').select_refactor() end, mode = { 'n', 'x' }, desc = 'Select refactor' },
  },
}
