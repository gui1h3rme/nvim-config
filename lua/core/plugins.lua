-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system({ 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { 'Failed to clone lazy.nvim:\n', 'ErrorMsg' },
      { out, 'WarningMsg' },
      { '\nPress any key to exit...' },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

local plugins = {
  'edeneast/nightfox.nvim',
  'nvim-tree/nvim-tree.lua',
  'nvim-tree/nvim-web-devicons',
  'nvim-lualine/lualine.nvim',
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.x',
    dependencies = { 'nvim-lua/plenary.nvim', 'nvim-telescope/telescope-live-grep-args.nvim' }
  },
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate'
  },
  'williamboman/mason.nvim',
  'williamboman/mason-lspconfig.nvim',
  'neovim/nvim-lspconfig',
  'lewis6991/gitsigns.nvim',
  'tpope/vim-fugitive',
  'akinsho/toggleterm.nvim',
  'pogyomo/submode.nvim',
  'pogyomo/winresize.nvim',
  'echasnovski/mini.surround',
  {
    'nvimdev/dashboard-nvim',
    event = 'VimEnter',
    dependencies = {
      'nvim-tree/nvim-web-devicons'
    }
  },
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
      'hrsh7th/cmp-vsnip',
      'hrsh7th/vim-vsnip'
    }
  },
  {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    event = 'InsertEnter',
  },
  'zbirenbaum/copilot-cmp'
}
local opts = {}



-- Setup lazy.nvim
require('lazy').setup(plugins, opts)
