return {
  "elitracy/blackbag.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("blackbag").setup()
    vim.cmd.colorscheme 'blackbag'
  end
}
