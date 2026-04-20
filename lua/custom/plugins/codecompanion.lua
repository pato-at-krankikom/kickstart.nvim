return {
  'olimorris/codecompanion.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
  },
  cmd = { 'CodeCompanion', 'CodeCompanionChat', 'CodeCompanionActions' },
  opts = {
    adapters = {
      ollama = function()
        return require('codecompanion.adapters').extend('ollama', {
          schema = {
            model = {
              default = 'qwen2.5-coder:14b',
            },
          },
        })
      end,
    },
    strategies = {
      chat = { adapter = 'ollama' },
      inline = { adapter = 'ollama' },
    },
  },
  keys = {
    { '<leader>ac', '<cmd>CodeCompanionChat Toggle<cr>', desc = 'AI Chat' },
    { '<leader>ai', '<cmd>CodeCompanionActions<cr>', desc = 'AI Actions' },
    { '<leader>ai', '<cmd>CodeCompanionActions<cr>', mode = 'v', desc = 'AI Actions' },
  },
}
