-- Treesitter textobjects (select + move). Uses the `main` branch to match
-- your `main`-branch nvim-treesitter, which needs the new setup/keymap API.
-- https://github.com/nvim-treesitter/nvim-treesitter-textobjects
return {
  'nvim-treesitter/nvim-treesitter-textobjects',
  branch = 'main',
  event = { 'BufReadPost', 'BufNewFile' },
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  config = function()
    require('nvim-treesitter-textobjects').setup {
      select = { lookahead = true },
      move = { set_jumps = true },
    }

    local select = require 'nvim-treesitter-textobjects.select'
    -- selection textobjects: af/if function, ac/ic class, aa/ia parameter
    local selects = {
      ['af'] = '@function.outer',
      ['if'] = '@function.inner',
      ['ac'] = '@class.outer',
      ['ic'] = '@class.inner',
      ['aa'] = '@parameter.outer',
      ['ia'] = '@parameter.inner',
    }
    for key, obj in pairs(selects) do
      vim.keymap.set({ 'x', 'o' }, key, function()
        select.select_textobject(obj, 'textobjects')
      end, { desc = 'Select ' .. obj })
    end

    local move = require 'nvim-treesitter-textobjects.move'
    -- movement: ]f/[f function start, ]F/[F function end, ]a/[a parameter
    -- (avoids ]c/[c which diff/change-navigation uses)
    vim.keymap.set({ 'n', 'x', 'o' }, ']f', function() move.goto_next_start('@function.outer', 'textobjects') end, { desc = 'Next function start' })
    vim.keymap.set({ 'n', 'x', 'o' }, '[f', function() move.goto_previous_start('@function.outer', 'textobjects') end, { desc = 'Prev function start' })
    vim.keymap.set({ 'n', 'x', 'o' }, ']F', function() move.goto_next_end('@function.outer', 'textobjects') end, { desc = 'Next function end' })
    vim.keymap.set({ 'n', 'x', 'o' }, '[F', function() move.goto_previous_end('@function.outer', 'textobjects') end, { desc = 'Prev function end' })
    vim.keymap.set({ 'n', 'x', 'o' }, ']a', function() move.goto_next_start('@parameter.inner', 'textobjects') end, { desc = 'Next parameter' })
    vim.keymap.set({ 'n', 'x', 'o' }, '[a', function() move.goto_previous_start('@parameter.inner', 'textobjects') end, { desc = 'Prev parameter' })
  end,
}
