-- Statusline with icons and LSP integration
return {
  {
    'nvim-lualine/lualine.nvim',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
      'milanglacier/minuet-ai.nvim',
    },
    config = function()
      require('lualine').setup({
        options = {
          component_separators = { left = '', right = '' },
          section_separators = { left = '', right = '' },
        },
        sections = {
          lualine_b = {
            {
              'branch',
              icon = '',
            },
          },
          lualine_c = {
            {
              'filename',
              file_status = true,  -- Displays file status (readonly status, modified status)
              newfile_status = true, -- Display new file status (new file means no write after created)
              -- 0: Just the filename
              -- 1: Relative path
              -- 2: Absolute path
              -- 3: Absolute path, with tilde as the home directory
              -- 4: Filename and parent dir, with tilde as the home directory
              path = 1,
            },
          },

          lualine_x = {
            {
              'fileformat',
              symbols = {
                unix = '', -- f303
                dos = '', -- e70f
                mac = '', -- e711
              },
            },
            'encoding',
            {
              'filetype',
              colored = false, -- Displays filetype icon in color if set to true
              icon_only = false, -- Display only an icon for filetype
              -- icon = { align = 'right' }, -- Display filetype icon on the right hand side
              -- icon =    {'X', align='right'}
              -- Icon string ^ in table is ignored in filetype component
            },
          },
          lualine_y = {
            {
              require 'minuet.lualine',
              display_name = 'model',
              display_on_idle = true,
            },
            {
              'lsp_status',
              icon = '', -- f233
              symbols = {
                -- Standard unicode symbols to cycle through for LSP progress:
                spinner = { '⠋', '⠙', '⠹', '⠸', '⠼', '⠴', '⠦', '⠧', '⠇', '⠏' },
                -- Standard unicode symbol for when LSP is done:
                done = '✓',
                -- Delimiter inserted between LSP names:
                separator = ' ',
              },
              -- List of LSP names to ignore (e.g., `null-ls`):
              ignore_lsp = {},
            },
          },
          lualine_z = { 'progress', 'location' },
        },
      })
    end,
  },
}
