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

vim.keymap.set('n', 'ZW', ':w!<CR>')
-- Switch buffers
vim.keymap.set('n', '<Space><Left>', '<C-w>h')
vim.keymap.set('n', '<Space><Down>', '<C-w>j')
vim.keymap.set('n', '<Space><Up>', '<C-w>k')
vim.keymap.set('n', '<Space><Right>', '<C-w>l')

-- Move current buffer
vim.keymap.set('n', '<Space><C-Left>', '<C-w>H')
vim.keymap.set('n', '<Space><C-Down>', '<C-w>J')
vim.keymap.set('n', '<Space><C-Up>', '<C-w>K')
vim.keymap.set('n', '<Space><C-Right>', '<C-w>L')

-- Resize current buffer
vim.keymap.set('n', '<S-Up>', '<C-w>-')
vim.keymap.set('n', '<S-Down>', '<C-w>+')
vim.keymap.set('n', '<S-Left>', '<C-w>>')
vim.keymap.set('n', '<S-Right>', '<C-w><')

-- Split current buffer 
vim.keymap.set('n', '<C-Space-Up>', '<C-w>s')
vim.keymap.set('n', '<C-Space-Down>', '<C-w>s')
vim.keymap.set('n', '<C-Space-Left>', '<C-w>v')
vim.keymap.set('n', '<C-Space-Right>', '<C-w>v')

-- Quit current buffer
vim.keymap.set('n', '<Space><ESC>', '<C-w>q')

-- Close Telescope popover
vim.keymap.set('n', '<Esc>', '<Nop>')

-- Copy relative path
vim.keymap.set('n', '<Space>pr', ':lua vim.fn.setreg(\'+\', vim.fn.expand(\'%.\'))<CR>')
vim.keymap.set('n', '<Space>pa', ':lua vim.fn.setreg(\'+\', vim.fn.expand(\'%:p\'))<CR>')

-- Replace selected text
vim.keymap.set('v', '<Space>f', 'y:/<C-r>0/', { desc = 'Search/Visual' })

-- Neorg
vim.keymap.set('n', '<Space>w', ':Telescope neorg switch_workspace<CR>')
vim.keymap.set('n', '<Space>r', ':Neorg return<CR><CR>')
