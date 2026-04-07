return {
  "adalessa/laravel.nvim",
  dependencies = {
    "MunifTanjim/nui.nvim",
    "nvim-lua/plenary.nvim",
    "nvim-neotest/nvim-nio",
  },
  ft = { "php", "blade" },
  event = { "BufEnter composer.json" },
  keys = {
    { "<leader>la", function() Laravel.pickers.artisan() end,  desc = "Artisan command picker" },
    { "<leader>lr", function() Laravel.pickers.routes() end,   desc = "Routes picker" },
    { "<leader>lm", function() Laravel.pickers.make() end,     desc = "Make picker (controllers, models, ...)" },
    { "<leader>lv", function() Laravel.commands.run("view:finder") end, desc = "View finder" },
  },
  opts = {
    features = {
      pickers = {
        provider = "telescope",
      },
    },
  },
}
