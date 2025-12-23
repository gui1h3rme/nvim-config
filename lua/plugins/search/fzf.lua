return {
  {
    'ibhagwan/fzf-lua',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
      fzf_opts = { ['--layout'] = 'reverse-list' },
      file_ignore_patterns = {
        "node_modules/",
        "dist/",
        ".next/",
        ".git/",
        ".gitlab/",
        "build/",
        "target/",
        "package-lock.json",
        "pnpm-lock.yaml",
        "yarn.lock",
      }

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
