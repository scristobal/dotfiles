return {
  'navarasu/onedark.nvim',
  -- 'NLKNguyen/papercolor-theme',
  -- 'folke/tokyonight.nvim',
  -- 'bluz71/vim-nightfly-colors',
  -- 'rose-pine/neovim',
  -- 'AlexvZyl/nordic.nvim',
  -- 'Tsuzat/NeoSolarized.nvim',
  -- 'RRethy/base16-nvim',
  -- 'EdenEast/nightfox.nvim',
  -- 'nyoom-engineering/oxocarbon.nvim',

  lazy = false,
  priority = 1000,

  config = function()
    vim.cmd.colorscheme 'onedark'
    -- vim.cmd.colorscheme 'PaperColor'
    -- vim.cmd.colorscheme 'tokyonight'
    -- vim.cmd.colorscheme 'nightfly'
    -- vim.cmd.colorscheme 'rose-pine'
    -- vim.cmd.colorscheme 'nordic'
    -- vim.cmd.colorscheme 'NeoSolarized'
    -- vim.cmd.colorscheme 'base16-default-dark'
    -- vim.cmd.colorscheme 'carbonfox'
    -- vim.cmd.colorscheme 'oxocarbon'
  end,
}
