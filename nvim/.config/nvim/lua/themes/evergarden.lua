return {
  'everviolet/nvim',
  name = 'evergarden',
  priority = 1000,
  lazy = false,
  event = 'VimEnter',
  config = function()
    require('evergarden').setup {
      theme = {
        variant = 'winter', -- 'winter'|'fall'|'spring'|'summer'
        -- accent = 'green',
      },
      -- editor = {
      --   transparent_background = true,
      --   sign = { color = 'none' },
      --   float = {
      --     color = 'mantle',
      --     invert_border = true,
      --   },
      --   completion = {
      --     color = 'surface0',
      --     invert_border = true,
      --   },
      -- },
    }
    vim.cmd.colorscheme 'evergarden'
  end,
}
