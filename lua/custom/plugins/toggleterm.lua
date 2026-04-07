return {
  'akinsho/toggleterm.nvim',
  version = '*',
  config = function()
    local toggleterm = require 'toggleterm'

    toggleterm.setup {
      size = 15,
      hide_numbers = true,
      shade_terminals = true,
      shading_factor = 2,
      start_in_insert = true,
      insert_mappings = true,
      persist_size = true,
      direction = 'horizontal', -- default
      close_on_exit = true,
      float_opts = {
        border = 'curved',
        winblend = 3,
        highlights = {
          border = 'Normal',
          background = 'Normal',
        },
      },
    }

    -- Load Terminal class
    local Terminal = require('toggleterm.terminal').Terminal

    -- Create functions to lazy-load terminals
    local function toggle_horizontal()
      local horiz = Terminal:new { direction = 'horizontal' }
      horiz:toggle()
    end

    local function toggle_vertical()
      local vert = Terminal:new { direction = 'vertical' }
      vert:toggle()
    end

    local function toggle_float()
      local float = Terminal:new { direction = 'float' }
      float:toggle()
    end

    -- Keymaps (leader + t + h/v/f)
    vim.keymap.set('n', '<leader>th', toggle_horizontal, { silent = true, noremap = true })
    vim.keymap.set('n', '<leader>tv', toggle_vertical, { silent = true, noremap = true })
    vim.keymap.set('n', '<leader>tf', toggle_float, { silent = true, noremap = true })
  end,
}
