return {
  'rebelot/kanagawa.nvim',

  lazy = false,
  priority = 1000,

  -- event = 'VimEnter',

  config = function()
    require('kanagawa').setup {
      theme = 'dragon',
      background = {
        dark = 'dragon',
      },
      colors = {
        theme = {
          all = {
            ui = {
              bg_gutter = 'none',
            },
          },
        },
      },
      overrides = function(colors)
        local theme = colors.theme

        return {
          NormalFloat = { bg = 'none' },
          FloatBorder = { bg = 'none' },
          FloatTitle = { bg = 'none' },

          -- Save an hlgroup with dark background and dimmed foreground
          -- so that you can use it where your still want darker windows.
          -- E.g.: autocmd TermOpen * setlocal winhighlight=Normal:NormalDark
          NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },

          -- Popular plugins that open floats will link to NormalFloat by default;
          -- set their background accordingly if you wish to keep them dark and borderless
          -- LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
          -- MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },


          -- Try to fix Blink.cmp manually, https://github.com/rebelot/kanagawa.nvim/issues/283
          -- https://github.com/rebelot/kanagawa.nvim/blob/debe91547d7fb1eef34ce26a5106f277fbfdd109/lua/kanagawa/highlights/plugins.lua#L188-L204
          -- BlinkCmpMenu = { bg = colors.palette.dragonBlack3 },
          -- BlinkCmpLabelDetail = { bg = colors.palette.dragonBlack3 },
          -- BlinkCmpMenuSelection = { bg = colors.palette.waveBlue1 },

          -- Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 }, -- add `blend = vim.o.pumblend` to enable transparency,,
          -- PmenuSel = { fg = 'NONE', bg = theme.ui.bg_p2 },
          -- PmenuSbar = { bg = theme.ui.bg_m1 },
          -- PmenuThumb = { bg = '#C0A36E' },
          -- BlinkCmpMenuBorder = { fg = '', bg = '' },
          --
          --
          -- NormalFloat = { bg = 'none' },
          -- FloatBorder = { bg = 'none' },
          -- FloatTitle = { bg = 'none' },
          -- -- LineNr = { fg = "#C0A36E", bg = "NONE" },
          -- CursorLineNr = { fg = colors.palette.sakuraPink, bg = 'NONE' },
        }
      end,
    }

    vim.cmd.colorscheme 'kanagawa'
  end,
}
