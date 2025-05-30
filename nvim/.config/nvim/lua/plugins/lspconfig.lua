-- [[Language Servers]]
return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'mason-org/mason.nvim', version = '1.11.0', opts = { ui = { border = 'rounded' } } },
      { 'mason-org/mason-lspconfig.nvim', version = '1.32.0' },
      -- grabs json schemas from SchemaStore
      { 'b0o/schemastore.nvim' },
      'saghen/blink.cmp',
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
        end,
      })

      local capabilities = require('blink.cmp').get_lsp_capabilities()

      local servers = {
        clangd = {},
        pyright = {},
        rust_analyzer = {
          cargo = {
            allFeatures = true,
            loadOutDirsFromCheck = true,
            runBuildScripts = true,
          },
          -- add clippy lints for Rust
          checkOnSave = {
            allFeatures = true,
            command = 'clippy',
            extraArgs = {
              '--',
              '--no-deps',
              '--workspace',
              '--all-targets',
              '--all-features',
              '-Dclippy::correctness',
              '-Dclippy::complexity',
              '-Wclippy::perf',
              '-Wclippy::pedantic',
            },
          },
          procMacro = {
            enable = true,
          },
        },
        zls = {},
        gleam = {
          -- uncomment to use debug LSP
          -- cmd = { '/home/samu/repos/forks/gleam/target/debug/gleam', 'lsp' },
          -- cmd = { '/Users/samu/repos/forks/gleam/target/debug/gleam', 'lsp' },
        },
        ts_ls = {
          root_dir = require('lspconfig').util.root_pattern { 'tsconfig.json', 'jsconfig.json', 'package.json' },
          eoot_markers = { 'tsconfig.json', 'jsconfig.json', 'package.json' },
          workspace_required = true,
          single_file_support = false,
          settings = {},
        },
        -- denols = {
        --   root_dir = require('lspconfig').util.root_pattern { 'deno.json', 'deno.jsonc' },
        --   root_markers = { 'deno.json', 'deno.jsonc' },
        --   workspace_required = true,
        --   single_file_support = false,
        --   settings = {},
        -- },
        jsonls = {
          settings = {
            json = {
              schemas = require('schemastore').json.schemas(),
              validate = { enable = true },
            },
          },
        },
        tailwindcss = {},
        lua_ls = {
          settings = { Lua = { completion = { callSnippet = 'Replace' } } },
        },
        fortls = {},
        -- ruff_lsp = {},
        -- gopls = {},
      }

      ---@diagnostic disable-next-line: missing-fields
      require('mason-lspconfig').setup {
        ensure_installed = {},
        automatic_installation = false,
        handlers = {
          -- this is called when `server_name` has been installed or it is ready
          function(server_name)
            local server = servers[server_name] or {}
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(servers)
          end,
        },
      }

      -- gleam LSP is not managed by mason, nor mason-lspconfig, so it needs to be setup manually
      require('lspconfig')['gleam'].setup(servers['gleam'])

      vim.cmd [[nnoremap <buffer><silent> <C-space> :lua vim.lsp.diagnostic.show_line_diagnostics({ border = "single" })<CR>]]
      vim.cmd [[nnoremap <buffer><silent> ]g :lua vim.lsp.diagnostic.goto_next({ popup_opts = { border = "single" }})<CR>]]
      vim.cmd [[nnoremap <buffer><silent> [g :lua vim.lsp.diagnostic.goto_prev({ popup_opts = { border = "single" }})<CR>]]
    end,
  },
}
