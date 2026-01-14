return {
  'folke/which-key.nvim',
  opts = {
    delay = 0,
    preset = 'helix',
    icons = {
      mappings = false,
    },
    filter = function(mapping)
      return mapping.desc and mapping.desc ~= ""
    end,
    plugins = {
      presets = {
        windows = false,
        nav = false
      }
    }
  }
}
