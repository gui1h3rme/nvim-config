return {
  {
    'ibhagwan/fzf-lua',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
      fzf_opts = { ['--layout'] = 'reverse-list' }
    }
  },
  {
    'ahmedkhalf/project.nvim',
    config = function()
      require('project_nvim').setup({})
    end
  },
  {
    'jakobwesthoff/project-fzf.nvim',
    dependencies = {
      'ahmedkhalf/project.nvim', -- Must be configured separately
      'ibhagwan/fzf-lua',
    },
    opts = {}, -- Will call require('project-fzf').setup(opts)
  }
}

