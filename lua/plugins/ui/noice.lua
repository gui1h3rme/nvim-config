local row = math.floor(
  vim.api.nvim_win_get_height(0) / 2
)
return{
  'folke/noice.nvim',
  event = 'VeryLazy',
  opts = {
    views = {
      notify = {
        replace = true,
      },
      cmdline_popup = {
        position = {
          row = row,
          col = "50%",
        },
        size = {
          min_width = 60,
          width = "auto",
          height = "auto",
        },
      },
      cmdline_popupmenu = {
        position = {
          row = row + 3,
          col = "50%",
        },
        size = {
          width = 60,
          height = 10,
        },
        border = {
          style = "rounded",
          padding = { 0, 1 },
        },
        win_options = {
          winhighlight = { Normal = "Normal", FloatBorder = "DiagnosticInfo" },
        },
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
      lsp_doc_border = true, -- add a border to hover docs and signature help
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
