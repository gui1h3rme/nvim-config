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
      'graphql'
    }
  },
  dependencies = {
    { 'mason-org/mason.nvim', opts = {} },
    { 'neovim/nvim-lspconfig' },
    { 'SmiteshP/nvim-navic' }
  },
}
