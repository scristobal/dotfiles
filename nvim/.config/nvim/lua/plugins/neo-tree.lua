-- [[File navigation]]
return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons',
    'MunifTanjim/nui.nvim',
  },
  cmd = 'Neotree',
  keys = {
    { '\\', ':Neotree toggle position=float<CR>', desc = 'NeoTree toggle', silent = true },
  },
  opts = {
    popup_border_style = '',
    filesystem = {
      filtered_items = {
        visible = true,
      },
      window = {
        mappings = {},
      },
    },
  },
  config = function()
    vim.api.nvim_create_augroup('neotree', {})
    vim.api.nvim_create_autocmd('VimEnter', {
      desc = 'Open Neotree automatically',
      group = 'neotree',
      callback = function()
        if vim.fn.argc() == 0 and not vim.fn.exists 's:std_in' then
          vim.cmd 'Neotree position=float'
        end
      end,
    })
  end,
}
