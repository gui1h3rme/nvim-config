return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  lazy = false,
  opts = {
    ensure_installed = {
      'ruby',
      'vim',
      'python',
      'lua',
      'javascript',
      'html',
      'typescript',
      'svelte',
      'css',
      'scss',
      'pug',
      'vue'
    },
    highlight = {
      enable = true
    },
    indent = {
      enable = true
    },
    autotag = {
      enable = true,
    },
    rainbow = {
      enable = true,
    },
  }
}
