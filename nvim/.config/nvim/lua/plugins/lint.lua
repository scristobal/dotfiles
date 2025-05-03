-- [[Linting]]
return {
  {
    'mfussenegger/nvim-lint',
    dependencies = {
      { 'williamboman/mason.nvim', opts = { ui = { border = 'rounded' } } },
      -- 'rshkarin/mason-nvim-lint',
    },
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      local lint = require 'lint'

      lint.linters_by_ft = {
        -- configured as part of rust lsp
        --  rust = { 'clippy' },
        markdown = { 'markdownlint' },
        fortran = { 'fortitude' },
      }

      local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
      vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
        group = lint_augroup,
        callback = function()
          -- only run the linter in modifiable buffers, eg. no popups
          if vim.opt_local.modifiable:get() then
            lint.try_lint()
          end
        end,
      })

      -- installs linters automatically
      ---@diagnostic disable-next-line: missing-fields
      -- require('mason-nvim-lint').setup({
      --   automatic_installation = true,
      --   -- fortitude is not in the mason registry, must be installed manually https://fortitude.readthedocs.io/en/stable/installation/
      --   ignore_install = { 'fortitude' },
      -- })
    end,
  },
}
