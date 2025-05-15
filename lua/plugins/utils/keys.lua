return {
  'folke/which-key.nvim',
  event = 'VeryLazy',
  opts = {
    preset = 'modern'
  },
  keys = {
    { '<Space>?', ':WhichKey<CR>', desc = 'Show Keymaps Available' }
  }
}
