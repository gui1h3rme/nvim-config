require('core.keymaps')
require('core.plugins')
require('core.plugins.setup')

if vim.g.neovide then
  vim.o.guifont = "CommitMono Nerd Font:h12"
end

-- fold settings
vim.o.foldenable = true
-- fold collapse all on start
vim.o.foldlevelstart = 99
--  folds are defined by a user-defined expression (tree-sitter)
vim.o.foldmethod = 'expr'
-- let tree-sitter define folds
vim.o.foldexpr = 'nvim_treesitter#foldexpr()'
