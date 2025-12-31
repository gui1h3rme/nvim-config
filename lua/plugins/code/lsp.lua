return {
  'mason-org/mason-lspconfig.nvim',
  opts = {
    ensure_installed = {
      'lua_ls',
      'solargraph',
      'svelte',
      'html',
      'ts_ls',
      'vuels',
      'pylsp',
      'graphql',
    },
  },
  dependencies = {
    {
      'mason-org/mason.nvim',
      lazy = true,
      opts = {

        registries = {
          'github:mason-org/mason-registry',
          'github:Crashdummyy/mason-registry'
        }
      }
    },
    { 'neovim/nvim-lspconfig' },
    { 'SmiteshP/nvim-navic' },
    { 'seblyng/roslyn.nvim' }
  },
}
