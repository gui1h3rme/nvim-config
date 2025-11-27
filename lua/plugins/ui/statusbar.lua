return {
  'nvim-lualine/lualine.nvim',
  dependencies = {
    "chrisgrieser/nvim-recorder",
    dependencies = "rcarriga/nvim-notify",
    keys = {
      -- these must match the keys in the mapping config below
      { "q", desc = " Start Recording" },
      { "Q", desc = " Play Recording" },
    }
  },
  config = function()
    require("recorder").setup({
      mapping = {
        startStopRecording = "q",
        playMacro = "Q",
      },
    })

    require('lualine').setup {
      options = {
        icons_enabled = true,
        theme = 'auto',
        component_separators = { left = '|', right = '|' },
        section_separators = { left = '', right = '' },
        disabled_filetypes = {
          winbar = { 'packer', 'oil', 'toggleterm' }
        },
      },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = {
          'branch',
          {
            'diff',
            symbols = {
              added = ' ',
              modified = ' ',
              removed = ' '
            }
          }
        },
        lualine_c = {
          { 'filename', path = 1 },
          require('recorder').recordingStatus,
          require('recorder').displaySlots
        },
        lualine_x = { 'navic', 'diagnostics', 'location' },
        lualine_y = { 'encoding', 'fileformat', { 'filetype', icon = nil } },
        lualine_z = { 'lsp_status' },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = { 'branch' },
        lualine_c = { { 'filename', path = 1 } },
        lualine_x = { 'location' },
        lualine_y = { 'encoding', 'fileformat', { 'filetype', icon = nil } },
        lualine_z = { 'lsp_status' },
      },
      extensions = { 'oil', 'fugitive', 'toggleterm', 'mason', 'lazy', 'fzf' }
    }
  end
}
