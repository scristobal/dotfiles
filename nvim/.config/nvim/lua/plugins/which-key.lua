-- show available key combinations
return {
  'folke/which-key.nvim',
  event = "VeryLazy",
  ---@class wk.Opts
  opts = {
    preset = 'modern', -- classin, modern, helix
    delay = 0,
    icons = {
      mappings = true,
    },
  },
}

