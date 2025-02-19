return{
  'folke/noice.nvim',
  event = 'VeryLazy',
  opts = {
    views = {
      notify = {
        replace = true,
      },
    },
    lsp = {
      progress = {
        enabled = true,
        format = "lsp_progress",
        format_done = "lsp_progress_done",
        view = "notify",
      },
    },
    presets = {
      bottom_search = true, -- use a classic bottom cmdline for search
      long_message_to_split = true, -- long messages will be sent to a split
      inc_rename = false, -- enables an input dialog for inc-rename.nvim
      lsp_doc_border = false, -- add a border to hover docs and signature help
    },
  },
  dependencies = {
    'MunifTanjim/nui.nvim',
    {
      'rcarriga/nvim-notify',
      opts = {
        render = "minimal",
        stages = "slide",
        top_down = false
      }
    }
  },
}
