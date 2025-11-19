-- show available key combinations
return {
  'folke/which-key.nvim',
  event = 'VimEnter',
  ---@class wk.Opts
  opts = {
    -- change to "helix" when either `https://github.com/folke/which-key.nvim/pull/964` or `https://github.com/folke/which-key.nvim/pull/974` is merged
    preset = 'helix',
    delay = 0,
    icons = {
      mappings = true,
    },
  },
}

