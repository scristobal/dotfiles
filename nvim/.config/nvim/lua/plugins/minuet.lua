return {
  {
    'milanglacier/minuet-ai.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-lualine/lualine.nvim',
    },
    config = function()
      require('minuet').setup {
        virtualtext = {
          auto_trigger_ft = {},
          -- Disable default keymaps (they work in Insert mode)
          keymap = {},
          show_on_completion_menu = true,
        },
        provider = 'claude',
        provider_options = {
          claude = {
            -- max_tokens = 256,
            model = 'claude-haiku-4-5',
            -- system = "see [Prompt] section for the default value",
            -- few_shots = "see [Prompt] section for the default value",
            -- chat_input = "See [Prompt Section for default value]",
            stream = true,
            -- end_point = 'https://api.anthropic.com/v1/messages',
            optional = {
              -- pass any additional parameters you want to send to claude request,
              -- e.g.
              -- stop_sequences = nil,
            },
          },
        }

        -- lsp = {
        --   -- disabled: https://github.com/milanglacier/minuet-ai.nvim?tab=readme-ov-file#built-in-completion-minicompletion-and-lsp-setup
        --   enabled_ft = { 'rust', 'toml', 'lua', 'cpp' },
        --   -- Enables automatic completion triggering using `vim.lsp.completion.enable`
        --   enabled_auto_trigger_ft = { 'rust', 'cpp', 'lua' },
        -- }

      }

      -- Set up Normal mode keymaps for Minuet virtualtext
      local vt = require('minuet.virtualtext')

      -- Trigger completion from Normal mode (enters Insert mode then triggers)
      vim.keymap.set('n', '<A-[>', function()
        vim.cmd('startinsert')
        -- Schedule the trigger to run after entering insert mode
        vim.schedule(function()
          vt.action.prev()
        end)
      end, { desc = '[minuet] Trigger completion (prev)' })

      vim.keymap.set('n', '<A-]>', function()
        vim.cmd('startinsert')
        -- Schedule the trigger to run after entering insert mode
        vim.schedule(function()
          vt.action.next()
        end)
      end, { desc = '[minuet] Trigger completion (next)' })

      -- Accept/dismiss also need Insert mode to work with virtualtext
      vim.keymap.set('n', '<A-A>', function()
        if vt.action.is_visible() then
          vt.action.accept()
        end
      end, { desc = '[minuet] Accept whole completion' })

      vim.keymap.set('n', '<A-a>', function()
        if vt.action.is_visible() then
          vt.action.accept_line()
        end
      end, { desc = '[minuet] Accept one line' })

      vim.keymap.set('n', '<A-z>', function()
        if vt.action.is_visible() then
          vt.action.accept_n_lines()
        end
      end, { desc = '[minuet] Accept n lines' })

      vim.keymap.set('n', '<A-e>', function()
        if vt.action.is_visible() then
          vt.action.dismiss()
        end
      end, { desc = '[minuet] Dismiss completion' })
    end,
  },
}
