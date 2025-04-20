return {
  {
    -- collection of various small independent plugins/modules, https://github.com/echasnovski/mini.nvim
    'echasnovski/mini.nvim',
    config = function()
      -- Better Around/Inside textobjects
      --
      -- Examples:
      --  - va)  - [V]isually select [A]round [)]paren
      --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
      --  - ci'  - [C]hange [I]nside [']quote
      require('mini.ai').setup { n_lines = 500 }

      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      --
      -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
      -- - sd'   - [S]urround [D]elete [']quotes
      -- - sr)'  - [S]urround [R]eplace [)] [']
      require('mini.surround').setup()

      -- local statusline = require 'mini.statusline'
      -- set use_icons to true if you have a Nerd Font
      -- statusline.setup { use_icons = true }

      -- cursor location to LINE:COLUMN
      -- --- @diagnostic disable-next-line: duplicate-set-field
      -- statusline.section_location = function()
      --   return '%2l:%-2v'
      -- end
      --
      --   require('mini.files').setup {
      --     windows = {
      --       preview = true,
      --       width_preview = 120,
      --       width_focus = 50,
      --       width_nofocus = 15,
      --     },
      --   }
      --
      --   local toggle_files = function()
      --     if not MiniFiles.get_explorer_state() then
      --       MiniFiles.open()
      --     else
      --       MiniFiles.close()
      --     end
      --   end
      --
      --   vim.keymap.set('n', '<C-\\>', toggle_files, { desc = 'Open file tree' })
    end,
  },
}
