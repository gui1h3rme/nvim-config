local logo = [[

____ 
||G ||
||__||
|/__\|


]]

return {
  'nvimdev/dashboard-nvim',
  event = 'VimEnter',
  dependencies = {
    'nvim-tree/nvim-web-devicons'
  },
  opts = {
    config = {
      header = vim.split(string.rep('\n', 2) .. logo, '\n'),
      mru = { enable = false },
      projects = { enale = true, limit = 20 }
    }
  }
}

