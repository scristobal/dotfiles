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

vim.g.have_nerd_font = true

require 'plugins'
require 'options'
require 'fixes'

vim.schedule(function()
  require 'keymaps'
end)

