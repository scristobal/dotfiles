-- code outline
return {
  'hedyhli/outline.nvim',
  lazy = true,
  cmd = { 'Outline', 'OutlineOpen' },
  keys = {
    { '<leader>o', '<cmd>Outline<CR>', desc = 'Toggle outline' },
  },
  opts = {
    outline_window = {
      position = 'left',
      width = 20,
      relative_width = true,
      auto_jump = true,
    },
    outline_items = {
      show_symbol_details = false,
    },
    symbol_folding = {
      autofold_depth = 2,
      auto_unfold = {
        hovered = true,
        only = true,
      },
    },
    preview_window = {
      auto_preview = false,
    },
  },
}

