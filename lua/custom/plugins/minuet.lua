return {
  'milanglacier/minuet-ai.nvim',
  event = { 'BufReadPost', 'BufNewFile' },
  dependencies = { 'nvim-lua/plenary.nvim' },
  keys = {
    { '<leader>ta', '<cmd>Minuet virtualtext toggle<cr>', desc = '[T]oggle [A]I ghost text' },
  },
  config = function()
    require('minuet').setup {
      provider = 'openai_fim_compatible',
      n_completions = 1,
      context_window = 8192,
      throttle = 1500,
      debounce = 400,
      provider_options = {
        openai_fim_compatible = {
          api_key = 'TERM',
          name = 'Ollama',
          end_point = 'http://localhost:11434/v1/completions',
          model = 'qwen2.5-coder:3b',
          optional = {
            max_tokens = 128,
            top_p = 0.9,
            stop = { '\n\n' },
          },
        },
      },
      virtualtext = {
        auto_trigger_ft = { '*' },
        show_on_completion_menu = false,
        keymap = {
          accept = '<A-y>',
          accept_line = '<A-l>',
          accept_n_lines = '<A-z>',
          prev = '<A-[>',
          next = '<A-]>',
          dismiss = '<A-e>',
        },
      },
    }
  end,
}
