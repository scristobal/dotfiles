-- configures Lua LSP nvim config, runtime and plugins used for completion, annotations and signatures of APIs
return {
  {
    'folke/lazydev.nvim',
    ft = 'lua',
    dependencies = {
      { 'Bilal2453/luvit-meta', lazy = true },
    },
    opts = {
      library = {
        -- Load luvit types when the `vim.uv` word is found
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
        { path = 'snacks.nvim',        words = { 'Snacks' } },
        { path = 'lazy.nvim',          words = { 'LazyVim' } },
        { path = 'which-key.nvim',     words = { 'wk' } },
        { path = 'gitsigns.nvim',      words = { 'gitsigns' } },
        { path = 'conform.nvim',       words = { 'conform' } },
        { path = 'nvim-dap',           words = { 'dap' } },
        { path = 'nvim-lint',          words = { 'lint' } },
        { path = 'blink.cmp',          words = { 'blink' } },
      },
    },
  },
}
