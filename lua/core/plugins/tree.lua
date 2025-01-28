vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require('nvim-tree').setup {
  update_focused_file = {
    enable = true
  }
}

vim.keymap.set('n', '<c-n>', ':NvimTreeFindFileToggle<CR>')
