-- language servers config
return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      -- grabs json schemas from SchemaStore
      { 'b0o/schemastore.nvim' },
      {
        'mason-org/mason-lspconfig.nvim',
        opts = {
          ensure_installed = {},
          automatic_enable = true,
        },
        dependencies = {
          {
            'mason-org/mason.nvim',
            opts = {
              ui = {
                border = 'rounded',
              },
            },
          },
        },
      },
    },
    config = function()
      local servers = {
        -- cspell_ls = {},
        -- codebook = {},
        rust_analyzer = { settings = { ['rust-analyzer'] = { cargo = { allFeatures = true } } } },
        gleam = {
          -- uncomment to use debug LSP
          -- cmd = { '/home/samu/repos/forks/gleam/target/debug/gleam', 'lsp' },
          -- cmd = { '/Users/samu/repos/forks/gleam/target/debug/gleam', 'lsp' },
        },
        tsgo = {},
        -- ts_ls = {
        --   root_dir = require('lspconfig').util.root_pattern { 'tsconfig.json', 'jsconfig.json', 'package.json' },
        --   eoot_markers = { 'tsconfig.json', 'jsconfig.json', 'package.json' },
        --   workspace_required = true,
        --   single_file_support = false,
        --   settings = {},
        -- },
        -- denols = {
        --   root_dir = require('lspconfig').util.root_pattern { 'deno.json', 'deno.jsonc' },
        --   root_markers = { 'deno.json', 'deno.jsonc' },
        --   workspace_required = true,
        --   single_file_support = false,
        --   settings = {},
        -- },
        -- tailwindcss = {},
        lua_ls = { settings = { Lua = { completion = { callSnippet = 'Replace' } } } },
        sourcekit = { capabilities = { workspace = { didChangeWatchedFiles = { dynamicRegistration = true } } } },
        kotlin_lsp = {},
        jsonls = { settings = { json = { schemas = require('schemastore').json.schemas(), validate = { enable = true } } } },
        taplo = {},
        clangd = {},
        -- fortls = {},
        -- pyright = {},
        -- ty = {},
        -- ruff_lsp = {},
        -- pest_ls = {},
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
