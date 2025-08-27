-- sample config for nvim-dap,
-- copy, edit and place inside the project under `.nvim/nvim-dap.lua`
-- then run `require('nvim-dap-projects').search_project_config()` or
-- check key bindings at config/dap.nvim, eg. `<leader>ld`

local dap = require 'dap'

dap.adapters.lldb = {
  type = 'server',
  port = '${port}',
  executable = {
    command = vim.fn.expand '~/.local/share/nvim/mason/bin/codelldb',
    args = { '--port', '${port}' },
  },
}

dap.configurations.rust = {
  {
    name = 'rust-app',
    type = 'lldb',
    request = 'launch',
    program = function()
      return vim.fn.getcwd() .. '/target/debug/rust-app'
    end,
    args = { '' },
    cwd = '${workspaceFolder}',
    env = {
      RUST_LOG = 'debug',
    },
    stopOnEntry = false,
  },
}
