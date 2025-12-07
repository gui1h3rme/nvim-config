return {
  'folke/which-key.nvim',
  opts = {
    delay = 0,
    preset = 'helix',
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
