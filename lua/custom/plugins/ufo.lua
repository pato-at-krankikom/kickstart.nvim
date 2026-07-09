-- Modern folding using LSP + treesitter (with an indent fallback).
-- NOTE: the treesitter FileType autocmd in init.lua that set foldexpr/
-- foldmethod=expr is commented out so ufo can own folding.
-- https://github.com/kevinhwang91/nvim-ufo
return {
  'kevinhwang91/nvim-ufo',
  dependencies = { 'kevinhwang91/promise-async' },
  event = { 'BufReadPost', 'BufNewFile' },
  init = function()
    -- ufo needs high foldlevel so nothing is folded on open
    vim.o.foldcolumn = '1'
    vim.o.foldlevel = 99
    vim.o.foldlevelstart = 99
    vim.o.foldenable = true
  end,
  opts = {
    provider_selector = function()
      -- prefer LSP, fall back to treesitter, then indent
      return { 'treesitter', 'indent' }
    end,
  },
  keys = {
    { 'zR', function() require('ufo').openAllFolds() end, desc = 'Open all folds' },
    { 'zM', function() require('ufo').closeAllFolds() end, desc = 'Close all folds' },
    { 'zK', function()
      local winid = require('ufo').peekFoldedLinesUnderCursor()
      if not winid then vim.lsp.buf.hover() end
    end, desc = 'Peek fold / hover' },
  },
}
