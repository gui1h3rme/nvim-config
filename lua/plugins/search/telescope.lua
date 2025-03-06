return {
  'nvim-telescope/telescope.nvim',
  event = "VimEnter",
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope-live-grep-args.nvim',
    {
      'ahmedkhalf/project.nvim',
      config = function ()
        require('project_nvim').setup({})
      end
    }
  },
  keys = {
    { '<Leader>ff'     , '<CMD>Telescope find_files<CR>'    , desc = "Search files" },
    { '<Leader>fg'     , '<CMD>Telescope live_grep_args<CR>', desc = "Search files" },
    { '<Leader>fr'     , '<CMD>Telescope resume<CR>'        , desc = "Search resume" },
    { '<Leader>fp'     , '<CMD>Telescope projects<CR>'      , desc = "Search projects" }
  },
  config = function()
    require('telescope').load_extension('live_grep_args')
    require('telescope').load_extension('projects')
  end,
}
