return {
  'folke/noice.nvim',
  opts = {
    lsp = {
      progress = {
        enabled = false
      },
      override = {
        ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
        ['vim.lsp.util.stylize_markdown'] = true,
        ['cmp.entry.get_documentation'] = true,
      },
    },
    cmdline = {
      enabled = true,
      opts = {
        position = {
          row = '95%'
        }
      },
    },
    presets = {
      lsp_doc_border = true
    }
  },
  dependencies = {
    'MunifTanjim/nui.nvim',
    { 'rcarriga/nvim-notify', 
      opts = {
        render = 'compact'
      }
    }
  }
}
