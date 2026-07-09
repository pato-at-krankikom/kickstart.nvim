-- Snacks explorer: file tree with automatic, read-only preview
-- https://github.com/folke/snacks.nvim
return {
  {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      explorer = { enabled = true },
      picker = {
        sources = {
          explorer = {
            -- open the tree as a left sidebar, like neo-tree
            layout = { preset = 'sidebar', preview = true },
            auto_close = false,
          },
        },
      },
    },
    keys = {
      {
        '<leader>e',
        function()
          require('snacks').explorer()
        end,
        desc = 'Explorer (snacks)',
      },
      {
        '<leader>E',
        function()
          require('snacks').explorer.reveal()
        end,
        desc = 'Reveal current file in explorer',
      },
    },
  },
}
