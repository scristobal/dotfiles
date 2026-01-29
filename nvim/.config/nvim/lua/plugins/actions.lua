-- code actions with a diff
return {
  'rachartier/tiny-code-action.nvim',
  dependencies = {
    { 'nvim-lua/plenary.nvim' },
    {
      'folke/snacks.nvim',
      opts = {
        terminal = {},
      },
    },
  },
  event = 'LspAttach',
  opts = {
    backend = 'vim',
    picker = 'snacks',
  },
  keys = {
    {
      '<leader>ca',
      function()
        require('tiny-code-action').code_action {}
      end,
      mode = { 'n', 'x' },
      desc = 'Code action',
      noremap = true,
      silent = true,
    },
  },
}
