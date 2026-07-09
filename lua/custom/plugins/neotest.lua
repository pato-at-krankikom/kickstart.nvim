-- Test runner: run/debug tests inline with a summary tree and output panel.
-- Adapters: pytest (Python) and Pest (Laravel/PHP).
-- https://github.com/nvim-neotest/neotest
return {
  'nvim-neotest/neotest',
  dependencies = {
    'nvim-neotest/nvim-nio',
    'nvim-lua/plenary.nvim',
    'antoinemadec/FixCursorHold.nvim',
    'nvim-treesitter/nvim-treesitter',
    -- adapters
    'nvim-neotest/neotest-python',
    'V13Axel/neotest-pest',
  },
  config = function()
    require('neotest').setup {
      adapters = {
        require 'neotest-python' {
          runner = 'pytest',
          dap = { justMyCode = false }, -- debug with your existing nvim-dap-python
        },
        require 'neotest-pest',
      },
    }
  end,
  keys = {
    { '<leader>tt', function() require('neotest').run.run() end, desc = 'Test: run nearest' },
    { '<leader>tf', function() require('neotest').run.run(vim.fn.expand '%') end, desc = 'Test: run file' },
    { '<leader>tl', function() require('neotest').run.run_last() end, desc = 'Test: run last' },
    { '<leader>td', function() require('neotest').run.run { strategy = 'dap' } end, desc = 'Test: debug nearest' },
    { '<leader>ts', function() require('neotest').summary.toggle() end, desc = 'Test: toggle summary' },
    { '<leader>to', function() require('neotest').output.open { enter = true } end, desc = 'Test: show output' },
    { '<leader>tp', function() require('neotest').output_panel.toggle() end, desc = 'Test: toggle output panel' },
    { '<leader>tw', function() require('neotest').watch.toggle(vim.fn.expand '%') end, desc = 'Test: toggle watch' },
  },
}
