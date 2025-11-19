-- AI-powered code completion
return {
  {
    'milanglacier/minuet-ai.nvim',
    enabled = true,
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-lualine/lualine.nvim',
    },
    config = function()
      require('minuet').setup {
        virtualtext = {
          auto_trigger_ft = {},
          show_on_completion_menu = true,
          keymap = {
            -- Cycle to prev completion item, or manually invoke completion
            prev = '<A-[>',
            -- Cycle to next completion item, or manually invoke completion
            next = '<A-]>',
            -- accept completion (whole)
            accept = '<A-a>',
            -- dismiss completion (all)
            dismiss = '<A-e>',
          },
        },
        provider = 'claude',
        provider_options = {
          claude = {
            api_key = function()
              if not _G.claude_token then
                local token_path = vim.fn.expand('~/.claude/token')
                local file = io.open(token_path, 'r')
                if file then
                  local token = file:read('*all')
                  file:close()
                  _G.claude_token = token:gsub('%s+', '') -- trim whitespace and cache
                else
                  vim.notify('Claude token file not found: ' .. token_path, vim.log.levels.ERROR)
                end
              end
              return _G.claude_token
            end,
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
    end,
  },
}
