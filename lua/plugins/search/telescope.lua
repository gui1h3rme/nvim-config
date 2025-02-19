return {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.x',
  event = "VimEnter",
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope-live-grep-args.nvim',
    'ahmedkhalf/project.nvim',
  },
  keys = {
    { '<C-p>'     , require('telescope.builtin').find_files,                       desc = "Search files" },
    { '<Leader>fr', require('telescope.builtin').resume,                           desc = "Resume Telescope" },
    { '<C-[>'     , '<CMD>Telescope projects<CR>',                                         desc = "Search projects" }
  },
  config = function()
    require('telescope').load_extension('live_grep_args')
    require('telescope').load_extension('projects')
  end,
}
