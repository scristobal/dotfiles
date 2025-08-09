-- enable 24-bit colour
vim.opt.termguicolors = true

-- relative line numbers
vim.opt.number = true
vim.opt.relativenumber = true
vim.wo.number = true

-- Enable mouse mode
vim.opt.mouse = 'a'

-- Don't show the mode, it's already in the status line
vim.opt.showmode = false

vim.schedule(function()
  --  See `:help 'clipboard'`
  vim.opt.clipboard = 'unnamedplus'
end)

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live
vim.opt.inccommand = 'split'

-- highlight curren line number
vim.opt.cursorline = true
vim.opt.cursorlineopt = 'number'

-- Allow the cursor to be at the very bottom/top of the viewport
vim.opt.scrolloff = 0

-- dialog for commands that would otherwise fail, eg. :q with modified buffers
vim.opt.confirm = false

-- make all floating windows rounded
vim.o.winborder = 'rounded'

-- more :h vim.opt and :h option-list
