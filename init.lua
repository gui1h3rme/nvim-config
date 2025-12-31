vim.g.fugitive_no_maps = 1

require('config.keymaps')
require('config.plugins')

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
vim.o.foldexpr = 'v:lua.vim.treesitter.foldexpr()'

vim.opt.listchars = { eol = '↵', trail = '∙' }
vim.opt.list = true
vim.o.conceallevel = 2
vim.o.cmdheight = 0

vim.g.mapleader = ' '
vim.g.maplocaleader = ' '

vim.opt.backspace = '2'
vim.opt.showcmd = true
vim.opt.laststatus = 2
vim.opt.autowrite = true
vim.opt.cursorline = true
vim.opt.autoread = true

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.shiftround = true
vim.opt.expandtab = true

vim.wo.number = true

vim.diagnostic.config({
  virtual_lines = {
    current_line = true
  },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "",
      [vim.diagnostic.severity.WARN] = "",
      [vim.diagnostic.severity.INFO] = "󰙎",
      [vim.diagnostic.severity.HINT] = "",
    }
  }
})

os.execute('rm ~/.local/state/nvim/lsp.log')
