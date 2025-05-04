-- [[Formatting]]
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
    opts = {
      default_format_opts = {
        lsp_format = 'first',
      },
      formatters_by_ft = {
        lua = { 'stylua' },
        rust = { 'rust-analyser' },
        typescript = { 'prettier' },
        c = { 'clang-format' },
        findent = { 'fortran' },
        -- python = { "isort", "black" },
        -- javascript = { "prettier" },
      },
    },
  },
}
