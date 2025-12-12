local dap_status = {
  function()
    local status = require('dap').status()
    if status:match('Stopped at') then
      return "Stopped"
    elseif status:match('stopped') then
      return "Paused"
    elseif status == "Running" or status:match('Running') then
      return "Running"
    elseif status ~= "" then
      return status
    end

    return ""
  end,
  function()
    if package.loaded['dap'] == nil then
      return false
    end

    return require('dap').session() ~= nil
  end,
  color = { fg = require('nightfox.palette.nightfox').palette.orange.base },
  icon = ""
}

local macro_status = {
  function ()
    return "[" .. vim.fn.reg_recording() .. "]"
  end,
  cond = function ()
    return vim.fn.reg_recording() ~= ""
  end,
  color = { fg = require('nightfox.palette.nightfox').palette.red.base },
  icon = '@'
}

return {
  'nvim-lualine/lualine.nvim',
  config = function()

    require('lualine').setup {
      options = {
        icons_enabled = true,
        theme = 'auto',
        component_separators = { left = '|', right = '|' },
        section_separators = { left = '', right = '' },
        disabled_filetypes = {
          statusline = { 'dap-repl', 'dap-view' },
          winbar = { 'packer', 'oil', 'toggleterm' }
        },
        ignore_focus = { 'dap-repl', 'dap-view', 'toggleterm' }
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
          macro_status,
          dap_status
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
