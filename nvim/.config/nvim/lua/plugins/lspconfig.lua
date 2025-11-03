-- [[Language Servers]]
return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      -- grabs json schemas from SchemaStore
      { 'b0o/schemastore.nvim' },
    },
    config = function()
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('custom-lsp-attach', { clear = true }),
        callback = function(event)
          vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { desc = 'Rename', buffer = event.buf })
          -- vim.keymap.set({ 'n', 'x' }, '<leader>ca', vim.lsp.buf.code_action, { desc = 'Code action', buffer = event.buf })
          vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { desc = 'Go to declaration' })

          -- this is shift-k by default
          -- map('<leader>h', vim.lsp.buf.hover, 'Show [H]over info')

          -- highlight references of the word under the cursor and clean up See `:help CursorHold`
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
            local highlight_augroup = vim.api.nvim_create_augroup('custom-lsp-highlight', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd('LspDetach', {
              group = vim.api.nvim_create_augroup('custom-lsp-detach', { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds { group = 'custom-lsp-highlight', buffer = event2.buf }
              end,
            })
          end
          -- end of highlight references

          -- toggle inlay hints if supported
          local toggle_hints = function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
          end
          if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
            vim.keymap.set('n', '<leader>th', toggle_hints, { desc = 'Toggle inlay hints', buffer = event.buf })
          end
          -- end of toggle inlay hints

          -- other useful keymaps
          vim.keymap.set('n', '<C-space>', function()
            vim.diagnostic.open_float()
          end, { buffer = true, silent = true, desc = 'Show line diagnostics' })

          vim.keymap.set('n', ']g', function()
            vim.diagnostic.jump { count = 1, float = true }
          end, { buffer = true, silent = true, desc = 'Jump to next diagnostic' })

          vim.keymap.set('n', '[g', function()
            vim.diagnostic.jump { count = -1, float = true }
          end, { buffer = true, silent = true, desc = 'Jump to previous diagnostic' })
        end,
      })

      -- this could be moved to /lsp folder, worth it?
      local servers = {
        cspell_ls = {},
        clangd = {},
        fortls = {},
        rust_analyzer = {
          settings = {
            ['rust-analyzer'] = {
              cargo = {
                loadOutDirsFromCheck = true,
                runBuildScripts = true,
              },
              allFeatures = true,
               check = {
                 command = 'clippy',
                 extraArgs = {
                   '--no-deps',
                   '--all-features',
                   '--',
                   --   '-Dclippy::correctness',
                   --   '-Dclippy::complexity',
                   --   '-Wclippy::perf',
                   --   '-Wclippy::pedantic',
                 },
               },
              procMacro = {
                enable = true,
              },
            },
          },
        },
        gleam = {
          -- uncomment to use debug LSP
          -- cmd = { '/home/samu/repos/forks/gleam/target/debug/gleam', 'lsp' },
          -- cmd = { '/Users/samu/repos/forks/gleam/target/debug/gleam', 'lsp' },
        },
        ts_ls = {
          -- root_dir = require('lspconfig').util.root_pattern { 'tsconfig.json', 'jsconfig.json', 'package.json' },
          -- eoot_markers = { 'tsconfig.json', 'jsconfig.json', 'package.json' },
          -- workspace_required = true,
          -- single_file_support = false,
          -- settings = {},
        },
        -- denols = {
        --   root_dir = require('lspconfig').util.root_pattern { 'deno.json', 'deno.jsonc' },
        --   root_markers = { 'deno.json', 'deno.jsonc' },
        --   workspace_required = true,
        --   single_file_support = false,
        --   settings = {},
        -- },
        -- tailwindcss = {},
        lua_ls = {
          settings = { Lua = { completion = { callSnippet = 'Replace' } } },
        },
        jsonls = {
          settings = {
            json = {
              schemas = require('schemastore').json.schemas(),
              validate = { enable = true },
            },
          },
        },
        taplo = {},
        pest_ls = {},
        -- ruff_lsp = {},
        -- pyright = {},
        -- gopls = {},
        -- zls = {},
      }

      for server_name, server_config in pairs(servers) do
        vim.lsp.config(server_name, server_config)
        vim.lsp.enable(server_name)
      end
    end,
  },
}
