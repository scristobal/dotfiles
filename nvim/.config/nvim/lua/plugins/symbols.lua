-- simple code outline
return {
  'oskarrrrrrr/symbols.nvim',
  config = function()
    local r = require 'symbols.recipes'
    local symbols = require 'symbols'

    symbols.setup(r.DefaultFilters, r.AsciiSymbols, {
      sidebar = {
        cursor_follow = true,
        -- custom settings here
        -- e.g. hide_cursor = false
      },
    })
    vim.keymap.set('n', ',s', '<cmd>SymbolsToggle<CR>')
  end,
}

