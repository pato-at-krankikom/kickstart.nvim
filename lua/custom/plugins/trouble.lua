-- Pretty, navigable panel for diagnostics, LSP references and quickfix.
-- Complements quicker.nvim (raw quickfix) with a richer LSP/diagnostics view.
-- https://github.com/folke/trouble.nvim
return {
  'folke/trouble.nvim',
  cmd = 'Trouble',
  opts = {},
  keys = {
    { '<leader>xx', '<cmd>Trouble diagnostics toggle<cr>', desc = 'Diagnostics (Trouble)' },
    { '<leader>xX', '<cmd>Trouble diagnostics toggle filter.buf=0<cr>', desc = 'Buffer diagnostics (Trouble)' },
    { '<leader>xs', '<cmd>Trouble symbols toggle focus=false<cr>', desc = 'Symbols (Trouble)' },
    { '<leader>xr', '<cmd>Trouble lsp toggle focus=false win.position=right<cr>', desc = 'LSP references/defs (Trouble)' },
    { '<leader>xl', '<cmd>Trouble loclist toggle<cr>', desc = 'Location list (Trouble)' },
    { '<leader>xq', '<cmd>Trouble qflist toggle<cr>', desc = 'Quickfix list (Trouble)' },
  },
}
