-- assorted plugins that require (almost) no configuration
return {
  -- use heuristics to config current buffer, also uses Modelines or EditorConfig if available
  'tpope/vim-sleuth',

  -- use `gc` while in visual mode <C-v> to toggle code comment
  { 'numToStr/Comment.nvim', opts = {} },

  -- show available key combinations
  {
    'folke/which-key.nvim',
    event = 'VimEnter',
    ---@class wk.Opts
    opts = {
      -- change to "helix" when either `https://github.com/folke/which-key.nvim/pull/964` or `https://github.com/folke/which-key.nvim/pull/974` is merged
      preset = "classic",
      delay = 0,
      icons = {
        mappings = true,
      },
    },
  },

  -- add matching brakets, etc.
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    opts = {},
  },

  -- docs on a separate pannel
  -- {
  --   'amrbashir/nvim-docs-view',
  --   lazy = true,
  --   cmd = 'DocsViewToggle',
  --   opts = {
  --     position = 'right',
  --     width = 60,
  --   },
  -- },

  -- code outline
  {
    "hedyhli/outline.nvim",
    lazy = true,
    cmd = { "Outline", "OutlineOpen" },
    keys = {
      { "<leader>o", "<cmd>Outline<CR>", desc = "Toggle outline" },
    },
    opts = {
      outline_window = {
        position = "left",
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
    }
  },

  -- custom tabs
  -- {
  --   'nanozuki/tabby.nvim',
  --   config = function()
  --     vim.o.showtabline = 2
  --   end,
  -- },

  -- Zellij integration
  -- {
  --   'https://github.com/fresh2dev/zellij.vim',
  --   -- Pin version to avoid breaking changes.
  --   -- tag = '0.3.*',
  --   lazy = false,
  --   init = function()
  --     -- Options:
  --     -- vim.g.zelli_navigator_move_focus_or_tab = 1
  --     -- vim.g.zellij_navigator_no_default_mappings = 1
  --   end,
  -- },

  -- extra Rust stuff
  --  {
  --    'mrcjkb/rustaceanvim',
  --    version = '^6',
  --  },
}
