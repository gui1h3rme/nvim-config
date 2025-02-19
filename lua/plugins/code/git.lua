return {
  'f-person/git-blame.nvim',
  {
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = "+" },
        change = { text = "~" },
        delete = { text = "-" },
        changedelete = { text = "x" },
        untracked = { text = "!" },
      },
    },
    event = 'VimEnter'
  },
  'tpope/vim-fugitive',
}
