return {
  'bluz71/vim-moonfly-colors',
  name = 'moonfly',

  lazy = false,
  priority = 1000,
  event = 'VimEnter',

  config = function()
    vim.cmd.colorscheme 'moonfly'
  end,
}
