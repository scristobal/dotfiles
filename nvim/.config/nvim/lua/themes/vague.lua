return {
  'vague2k/vague.nvim',
  lazy = false,
  priority = 1000,
  config = function()
    require('vague').setup({
      transparent = true,
      bold = false,
      italic = false,
    })
    vim.cmd.colorscheme 'vague'
  end,
}
