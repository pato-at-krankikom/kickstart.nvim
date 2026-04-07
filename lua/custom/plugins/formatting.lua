return {
  'stevearc/conform.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  config = function()
    local conform = require 'conform'

    conform.setup {
      formatters_by_ft = {
        -- Python: use Black
        python = { 'black' },

        -- PHP: choose ONE of these blocks:

        -- Option 1: php-cs-fixer
        php = { 'php_cs_fixer' },

        -- Option 2 (alternative): use Prettier for PHP instead
        -- php = { "prettier" },

        -- Blade
        blade = { 'blade-formatter' },

        -- Web stack: JS/TS/HTML/CSS
        javascript = { 'prettier' },
        typescript = { 'prettier' },
        javascriptreact = { 'prettier' },
        typescriptreact = { 'prettier' },
        vue = { 'prettier' },
        svelte = { 'prettier' },
        css = { 'prettier' },
        scss = { 'prettier' },
        html = { 'prettier' },
        json = { 'prettier' },
        yaml = { 'prettier' },
        markdown = { 'prettier' },
      },

      format_on_save = {
        lsp_fallback = true,
        async = false,
        timeout_ms = 3000,
      },
    }

    -- Manual format keymap: <leader>mp (m for “make pretty” or similar)
    vim.keymap.set(
      { 'n', 'v' },
      '<leader>mp',
      function()
        conform.format {
          lsp_fallback = true,
          async = false,
          timeout_ms = 3000,
        }
      end,
      { desc = 'Format file or range' }
    )
  end,
}
