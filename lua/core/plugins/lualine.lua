local gitblame = require('gitblame')
vim.g.gitblame_display_virtual_text = 0

require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'gruvbox',
    disabled_filetypes = {
      winbar = { 'packer', 'NvimTree' }
    },
    globalstatus = true
  },
  sections = {
    lualine_a = { 'mode', 'branch' },
    lualine_b = {
      { 'filename', path = 1 }
    },
    lualine_c = { 'diff' },
    lualine_x = {
      {
        gitblame.get_current_blame_text,
        cond = gitblame.is_blame_text_available,
        on_click = function() vim.cmd('GitBlameOpenCommitURL') end
      }, 'location' },
    lualine_y = { 'encoding', 'fileformat', { 'filetype', icon = nil } },
    lualine_z = { "require'lsp-status'.status()" },
  },
  winbar = {
    lualine_c = { },
    lualine_a = {
      { 'filetype', icon_only = true, colored = false, separator = '' },
    },
    lualine_b = {
      { 'filename', path = 0, file_status = false },
    },
    lualine_x = {
      { 'navic' }
    }
  },
  inactive_winbar = {
    lualine_a = {},
    lualibe_b = {},
    lualine_c = {
      { 'filetype', icon_only = true, colored = false, separator = '' },
      { 'filename', path = 0, file_status = false },
    }
  },
  extensions = { 'nvim-tree', 'fugitive', 'toggleterm', 'mason', 'lazy' }
}

-- Disable the default cmdline
vim.o.cmdheight = 0
