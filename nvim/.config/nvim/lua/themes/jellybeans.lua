return {
  'wtfox/jellybeans.nvim',
  lazy = false,
  priority = 1000,
  config = function()
    vim.cmd.colorscheme 'jellybeans-mono'
  end,
}
