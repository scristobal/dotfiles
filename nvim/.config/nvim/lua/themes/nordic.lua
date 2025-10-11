return {
  'AlexvZyl/nordic.nvim',
  lazy = false,
  priority = 1000,
  config = function()
    require('nordic').load({
       after_palette = function(palette)
        local U = require("nordic.utils")
        palette.bg_visual = U.blend(palette.orange.base, palette.bg, 0.15)
    end,
      bright_border = false,
    })
  end,
}
