return {
  'kdheepak/lazygit.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' },
  cmd = { 'LazyGit', 'LazyGitConfig', 'LazyGitCurrentFile', 'LazyGitFilter', 'LazyGitFilterCurrentFile' },
  init = function()
    vim.g.lazygit_use_neovim_remote = 1 -- use nvr to avoid frozen screen on commit edit
  end,
  keys = {
    {
      '<leader>hg',
      function()
        vim.cmd 'LazyGit'
        vim.cmd 'startinsert'
      end,
      desc = 'LazyGit',
    },
  },
}
