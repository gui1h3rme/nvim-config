local gitblame = require('gitblame')

gitblame.setup {
  message_template = "<summary> • <author> • <date>",
  display_virtual_text = false,
  use_blame_commit_file_urls = true,
  max_commit_summary_length = 25,
  date_format = '%x'
}

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
        on_click = function() vim.cmd('GitBlameOpenFileURL') end
      }, 'location' },
    lualine_y = { 'encoding', 'fileformat', { 'filetype', icon = nil } },
    lualine_z = { 'lsp_progress' },
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
vim.o.cmdheight = 1
