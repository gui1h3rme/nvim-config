return {
  'lukas-reineke/indent-blankline.nvim',
  main = 'ibl',
  opts = {
    indent = {
      highlight = highlight
    },
    exclude = {
      filetypes = { 'dashboard', 'norg' }
    }
  },
  lazy = false
}
