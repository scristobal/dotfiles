-- workaround for telescope rounded borders after update to 0.11
-- https://github.com/nvim-telescope/telescope.nvim/issues/3436
-- vim.api.nvim_create_autocmd('User', {
--   pattern = 'TelescopeFindPre',
--   callback = function()
--     vim.opt_local.winborder = 'none'
--     vim.api.nvim_create_autocmd('WinLeave', {
--       once = true,
--       callback = function()
--         vim.opt_local.winborder = 'rounded'
--       end,
--     })
--   end,
-- })

-- Gleam LSP comes with the binary, hence Mason is not required
vim.lsp.config['gleam'] = {
  cmd = { 'gleam', 'lsp' },
  filetypes = { 'gleam' },
  root_markers = { 'gleam.toml' },
  settings = {},
}
vim.lsp.enable 'gleam'
