local telescope = require('telescope')

telescope.setup {}

telescope.load_extension('live_grep_args')
telescope.load_extension('projects')

local builtin = require('telescope.builtin')

vim.keymap.set('n', '<c-p>', builtin.find_files, {})
vim.keymap.set('n', '<Space><Space>', builtin.oldfiles, {})
vim.keymap.set('n', '<Space>fg', ':lua require(\'telescope\').extensions.live_grep_args.live_grep_args()<CR>', {})
vim.keymap.set('n', '<Space>fh', builtin.help_tags, {})
vim.keymap.set('n', '<Space>fr', builtin.resume, {})
