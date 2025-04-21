-- Gleam LSP comes with the binary, hence Mason is not required.
--
-- vim.lsp.config['gleam'] = {
--   cmd = { 'gleam', 'lsp' },
--   filetypes = { 'gleam' },
--   root_markers = { 'gleam.toml' },
--   settings = {},
-- }
--
vim.lsp.enable 'gleam'
