require("neorg").setup {
  load = {
    ["core.defaults"] = {},
    ["core.concealer"] = {},
    ["core.dirman"] = {
      config = {
        workspaces = {
          notes = "~/notes",
        },
        default_workspace = "notes",
      },
    },
    ["core.completion"] = {
        config = {
            engine = "nvim-cmp",
        }
    },
    ["core.integrations.nvim-cmp"] = {},
    ["core.integrations.telescope"] = {
      config = {
        insert_file_link = {
          -- Whether to show the title preview in telescope. Affects performance with a large
          -- number of files.
          show_title_preview = true,
        },
      }
    },
    ["external.templates"] = {
      config = {
        templates_dir = "~/notes/templates"
      }
    },
  },
}
