
local logo = [[

____ 
||G ||
||__||
|/__\|


]]
require('dashboard').setup {
  config = {
    header = vim.split(string.rep('\n', 2) .. logo, '\n'),
    mru = { enable = false },
    projects = { enale = true, limit = 20 }
  }
}

