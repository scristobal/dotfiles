vim.diagnostic.config {
  severity_sort = true,
  float = { border = 'rounded', source = 'if_many' },
  underline = { severity = vim.diagnostic.severity.ERROR },
  -- signs = {
  --   text = {
  --     [vim.diagnostic.severity.ERROR] = '󰅚 ',
  --     [vim.diagnostic.severity.WARN] = '󰀪 ',
  --     [vim.diagnostic.severity.INFO] = '󰋽 ',
  --     [vim.diagnostic.severity.HINT] = '󰌶 ',
  --   },
  -- },
  virtual_text = false,
  -- virtual_text = {
  --   source = 'if_many',
  --   spacing = 2,
  -- },
  virtual_lines = false,
}

vim.keymap.set('n', '<leader>td', function()
  local virtual_lines = vim.diagnostic.config().virtual_lines
  vim.diagnostic.config { virtual_lines = not virtual_lines }

  --   local virtual_text = vim.diagnostic.config().virtual_text
  --   vim.diagnostic.config { virtual_text = not virtual_text }
end, { desc = 'Toggle diagnostics' })
