require('project_nvim').setup()

vim.keymap.set('n', '<Esc>', '<Nop>')
vim.keymap.set('n', '<C-[>', require('telescope').extensions.projects.projects)
