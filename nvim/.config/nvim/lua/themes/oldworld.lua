return {
  'dgox16/oldworld.nvim',

  lazy = false,
  priority = 1000,

  config = function()
    require('oldworld').setup {
      variant = 'oled',
      integrations = {
        neo_tree = true,
      },
    }

    vim.cmd.colorscheme 'oldworld'
  end,
}
