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
  },
}
