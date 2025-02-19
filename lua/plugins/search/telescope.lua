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
    { '<C-p>'     , require('telescope.builtin').find_files, desc = "Search files" },
    { '<Leader>fr', require('telescope.builtin').resume,     desc = "Search resume" },
    { '<C-[>'     , '<CMD>Telescope projects<CR>',           desc = "Search projects" }
  },
  config = function()
    require('telescope').load_extension('live_grep_args')
    require('telescope').load_extension('projects')
  end,
}
