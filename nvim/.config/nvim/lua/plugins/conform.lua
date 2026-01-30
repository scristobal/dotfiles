-- formatting
return {
  {
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
      {
        '<leader>f',
        function()
          require('conform').format { async = true }
        end,
        mode = 'n',
        desc = 'Format buffer',
      },
    },
    ---@module "conform"
    ---@type conform.setupOpts
    opts = {
      default_format_opts = {
        -- lsp_format = 'first',
      },
      formatters_by_ft = {
        lua = { 'stylua' },
        rust = { 'rust-analyser' },
        -- typescript = { 'prettier' },
        c = { 'clang-format' },
        fortran = { 'findent' },
        toml = { 'taplo'}
        -- python = { "isort", "black" },
        -- javascript = { "prettier" },
      },
    },
  },
}
