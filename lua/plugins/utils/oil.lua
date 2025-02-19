return {
  'stevearc/oil.nvim',
  dependencies = {
    'nvim-tree/nvim-web-devicons'
  },
  opts = {},
  keys = {
    { 
      '-',
      function() 
        require('oil').open()
      end,
      desc = 'Open parent directory'
    },
  },
}
