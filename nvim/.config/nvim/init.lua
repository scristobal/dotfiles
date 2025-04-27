-- leader needs to be defined before plugins are loaded
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- bootstrap lazy
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end
vim.opt.rtp:prepend(lazypath)

local lazy_config = require 'configs.lazy'
local lazy = require 'lazy'
lazy.setup('plugins', lazy_config)

require 'options'
require 'diagnostics'
require 'autocmds'

vim.schedule(function()
  require 'keymaps'
end)
