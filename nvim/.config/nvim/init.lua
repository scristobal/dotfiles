vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Options
vim.o.showmode = false
vim.o.winborder = 'rounded'
vim.g.have_nerd_font = true
vim.o.number = true
vim.o.relativenumber = true
vim.o.mouse = 'a'
vim.schedule(function() vim.o.clipboard = 'unnamedplus' end)
vim.o.breakindent = true
vim.o.undofile = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.signcolumn = 'yes'
vim.o.updatetime = 250
vim.o.timeoutlen = 300
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
vim.o.inccommand = 'split'
vim.o.cursorline = true
vim.opt.cursorlineopt = 'number'
vim.o.scrolloff = 10
vim.opt.shortmess:append('I')
vim.cmd('syntax off')

-- Keymaps
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus left' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus right' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus down' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus up' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Diagnostic quickfix list' })

vim.keymap.set('n', '<leader>rc', function()
  local text = vim.fn.expand('%') .. ':' .. vim.fn.line('.')
  vim.fn.setreg('+', text)
  print('Copied: ' .. text)
end, { desc = 'Copy file:line' })

-- Highlight yanked text
vim.api.nvim_create_autocmd('TextYankPost', {
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function() vim.hl.on_yank() end,
})

-- Diagnostics
vim.diagnostic.config {
  severity_sort = true,
  float = { border = 'rounded', source = 'if_many' },
  underline = { severity = vim.diagnostic.severity.ERROR },
  virtual_text = false,
  virtual_lines = false,
  jump = { on_jump = vim.diagnostic.open_float },
}

vim.keymap.set('n', '<leader>td', function()
  vim.diagnostic.config { virtual_lines = not vim.diagnostic.config().virtual_lines }
end, { desc = 'Toggle diagnostic lines' })

-- LSP attach
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)

    -- Attach navic for breadcrumbs in statusline
    if client and client.server_capabilities.documentSymbolProvider then
      require('nvim-navic').attach(client, ev.buf)
    end

    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { desc = 'Rename', buffer = ev.buf })
    vim.keymap.set({ 'n', 'x' }, '<leader>ca', function()
      require('tiny-code-action').code_action {}
    end, { desc = 'Code action', buffer = ev.buf })

    -- Highlight references under cursor
    if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight, ev.buf) then
      local hl_group = vim.api.nvim_create_augroup('lsp-highlight', { clear = false })
      vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
        buffer = ev.buf, group = hl_group, callback = vim.lsp.buf.document_highlight,
      })
      vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
        buffer = ev.buf, group = hl_group, callback = vim.lsp.buf.clear_references,
      })
      vim.api.nvim_create_autocmd('LspDetach', {
        group = vim.api.nvim_create_augroup('lsp-detach', { clear = true }),
        callback = function(ev2)
          vim.lsp.buf.clear_references()
          vim.api.nvim_clear_autocmds { group = 'lsp-highlight', buffer = ev2.buf }
        end,
      })
    end

    -- Toggle inlay hints
    if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint, ev.buf) then
      vim.keymap.set('n', '<leader>th', function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = ev.buf })
      end, { desc = 'Toggle inlay hints', buffer = ev.buf })
    end

    vim.keymap.set('n', '<C-space>', function() vim.diagnostic.open_float() end,
      { buffer = ev.buf, silent = true, desc = 'Show line diagnostics' })
    vim.keymap.set('n', ']g', function() vim.diagnostic.jump { count = 1, float = true } end,
      { buffer = ev.buf, silent = true, desc = 'Next diagnostic' })
    vim.keymap.set('n', '[g', function() vim.diagnostic.jump { count = -1, float = true } end,
      { buffer = ev.buf, silent = true, desc = 'Prev diagnostic' })
  end,
})

-- LSP progress notifications
---@type table<number, {token:lsp.ProgressToken, msg:string, done:boolean}[]>
local progress = vim.defaulttable()
vim.api.nvim_create_autocmd('LspProgress', {
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    local value = ev.data.params.value
    if not client or type(value) ~= 'table' then return end
    local p = progress[client.id]
    for i = 1, #p + 1 do
      if i == #p + 1 or p[i].token == ev.data.params.token then
        p[i] = {
          token = ev.data.params.token,
          msg = ('[%3d%%] %s%s'):format(
            value.kind == 'end' and 100 or value.percentage or 100,
            value.title or '',
            value.message and (' **%s**'):format(value.message) or ''
          ),
          done = value.kind == 'end',
        }
        break
      end
    end
    local msg = {}
    progress[client.id] = vim.tbl_filter(function(v) return table.insert(msg, v.msg) or not v.done end, p)
    local spinner = { '◜', '◠', '◝', '◞', '◡', '◟' }
    vim.notify(table.concat(msg, '\n'), 'info', {
      id = 'lsp_progress',
      title = client.name,
      opts = function(notif)
        notif.icon = #progress[client.id] == 0 and ' '
          or spinner[math.floor(vim.uv.hrtime() / (1e6 * 100)) % #spinner + 1]
      end,
    })
  end,
})

-- *** Plugins *** --

vim.pack.add({
  { src = 'https://github.com/nvim-treesitter/nvim-treesitter', branch = 'main' },
  'https://github.com/neovim/nvim-lspconfig',
  'https://github.com/mason-org/mason.nvim',
  'https://github.com/mason-org/mason-lspconfig.nvim',
  { src = 'https://github.com/saghen/blink.cmp', version = vim.version.range('1.0') },
  'https://github.com/L3MON4D3/LuaSnip',
  'https://github.com/stevearc/conform.nvim',
  'https://github.com/mfussenegger/nvim-lint',
  'https://github.com/folke/snacks.nvim',
  'https://github.com/folke/which-key.nvim',
  'https://github.com/lewis6991/gitsigns.nvim',
  'https://github.com/nvim-mini/mini.nvim',
  'https://github.com/folke/lazydev.nvim',
  'https://github.com/b0o/schemastore.nvim',
  'https://github.com/nvim-lualine/lualine.nvim',
  'https://github.com/nvim-tree/nvim-web-devicons',
  'https://github.com/SmiteshP/nvim-navic',
  'https://github.com/windwp/nvim-autopairs',
  'https://github.com/NMAC427/guess-indent.nvim',
  'https://github.com/diogo464/hotreload.nvim',
  'https://github.com/rachartier/tiny-code-action.nvim',
  'https://github.com/nvim-lua/plenary.nvim',
  'https://github.com/oskarrrrrrr/symbols.nvim',
  'https://github.com/alexpasmantier/krust.nvim',
  'https://github.com/esmuellert/codediff.nvim',
  'https://github.com/scristobal/code-review.nvim',
  'https://github.com/mfussenegger/nvim-dap',
  'https://github.com/rcarriga/nvim-dap-ui',
  'https://github.com/nvim-neotest/nvim-nio',
  'https://github.com/jay-babu/mason-nvim-dap.nvim',
  'https://github.com/ldelossa/nvim-dap-projects',
  'https://github.com/vague2k/vague.nvim',
})

vim.keymap.set('n', '<leader>pu', '<cmd>lua vim.pack.update()<CR>', { desc = 'Update plugins' })

-- Treesitter
vim.api.nvim_create_autocmd('FileType', {
  callback = function()
    pcall(vim.treesitter.start)
    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end,
})

local ts_parsers = {
  'rust', 'c', 'cpp', 'lua', 'python', 'typescript',
  'gleam', 'kotlin', 'json', 'toml', 'markdown',
}
vim.schedule(function() require('nvim-treesitter').install(ts_parsers) end)

-- LuaSnip
local ls = require 'luasnip'
vim.keymap.set('i', '<C-K>', function() ls.expand {} end, { silent = true })
vim.keymap.set({ 'i', 's' }, '<C-L>', function() ls.jump(1) end, { silent = true })
vim.keymap.set({ 'i', 's' }, '<C-J>', function() ls.jump(-1) end, { silent = true })
vim.keymap.set({ 'i', 's' }, '<C-E>', function()
  if ls.choice_active() then ls.change_choice(1) end
end, { silent = true })

-- Completion
require('blink.cmp').setup {
  keymap = { preset = 'default' },
  appearance = { nerd_font_variant = 'mono' },
  completion = {
    documentation = { auto_show = true, auto_show_delay_ms = 100 },
    ghost_text = { enabled = true },
    trigger = { prefetch_on_insert = false },
  },
  sources = {
    default = { 'lsp', 'path', 'snippets', 'lazydev', 'buffer' },
    providers = {
      lazydev = { module = 'lazydev.integrations.blink', score_offset = 100 },
    },
  },
  snippets = { preset = 'luasnip' },
  fuzzy = { implementation = 'prefer_rust' },
  signature = { enabled = true },
}

-- Mason + LSP
require('mason').setup()
require('mason-lspconfig').setup { automatic_enable = true }

vim.lsp.config('*', {
  capabilities = require('blink.cmp').get_lsp_capabilities(),
})

vim.lsp.config('rust_analyzer', {
  settings = { ['rust-analyzer'] = { cargo = { allFeatures = true } } },
})

vim.lsp.config('lua_ls', {
  settings = { Lua = { completion = { callSnippet = 'Replace' } } },
})

vim.lsp.config('sourcekit', {
  capabilities = { workspace = { didChangeWatchedFiles = { dynamicRegistration = true } } },
})

vim.lsp.config('jsonls', {
  settings = { json = { schemas = require('schemastore').json.schemas(), validate = { enable = true } } },
})

vim.lsp.enable({
  'rust_analyzer', 'gleam', 'tsgo', 'lua_ls', 'sourcekit',
  'kotlin_lsp', 'jsonls', 'taplo', 'clangd',
})

-- Lazydev
require('lazydev').setup {
  library = {
    { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
    { path = 'snacks.nvim', words = { 'Snacks' } },
    { path = 'which-key.nvim', words = { 'wk' } },
    { path = 'gitsigns.nvim', words = { 'gitsigns' } },
    { path = 'conform.nvim', words = { 'conform' } },
    { path = 'blink.cmp', words = { 'blink' } },
    { path = 'nvim-dap', words = { 'dap' } },
    { path = 'nvim-lint', words = { 'lint' } },
  },
}

-- Formatting
require('conform').setup {
  formatters_by_ft = {
    lua = { 'stylua' },
    rust = { lsp_format = 'first' },
    c = { 'clang-format' },
    toml = { 'taplo' },
  },
}

vim.keymap.set('n', '<leader>f', function()
  require('conform').format { async = true }
end, { desc = 'Format buffer' })

-- Linting
local lint = require 'lint'
lint.linters_by_ft = {
  markdown = { 'markdownlint' },
  fortran = { 'fortitude' },
}

vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
  group = vim.api.nvim_create_augroup('lint', { clear = true }),
  callback = function()
    if vim.opt_local.modifiable:get() then lint.try_lint() end
  end,
})

-- Snacks
require('snacks').setup {
  bigfile = { enabled = true },
  explorer = { enabled = true, replace_netrw = true },
  input = { enabled = true },
  picker = {
    hidden = true,
    enabled = true,
    icons = { files = { enabled = false } },
    sources = {
      explorer = { layout = { auto_hide = { 'input' } }, ignored = true },
      files = { hidden = true },
      smart = { hidden = true },
    },
  },
  notifier = { enabled = true, margin = { top = 2, right = 1, bottom = 2 }, top_down = false },
  quickfile = { enabled = true },
  scope = { enabled = true },
  scroll = { enabled = true },
  statuscolumn = { enabled = true },
  words = { enabled = true },
}

vim.keymap.set('n', '<leader><space>', function() Snacks.picker.smart() end, { desc = 'Smart Find' })
vim.keymap.set('n', '<leader>,', function() Snacks.picker.buffers() end, { desc = 'Buffers' })
vim.keymap.set('n', '<leader>/', function() Snacks.picker.grep() end, { desc = 'Grep' })
vim.keymap.set('n', '<leader>:', function() Snacks.picker.command_history() end, { desc = 'Command History' })
vim.keymap.set('n', '<leader>e', function() Snacks.explorer() end, { desc = 'File Explorer' })
vim.keymap.set('n', '<leader>n', function() Snacks.picker.notifications() end, { desc = 'Notifications' })
vim.keymap.set('n', '<leader>ff', function() Snacks.picker.files() end, { desc = 'Find Files' })
vim.keymap.set('n', '<leader>fb', function() Snacks.picker.buffers() end, { desc = 'Buffers' })
vim.keymap.set('n', '<leader>fc', function() Snacks.picker.files { cwd = vim.fn.stdpath 'config' } end, { desc = 'Config Files' })
vim.keymap.set('n', '<leader>fg', function() Snacks.picker.git_files() end, { desc = 'Git Files' })
vim.keymap.set('n', '<leader>fp', function() Snacks.picker.projects() end, { desc = 'Projects' })
vim.keymap.set('n', '<leader>fr', function() Snacks.picker.recent() end, { desc = 'Recent' })
vim.keymap.set('n', '<leader>gb', function() Snacks.picker.git_branches() end, { desc = 'Git Branches' })
vim.keymap.set('n', '<leader>gd', function() Snacks.picker.git_diff() end, { desc = 'Git Diff' })
vim.keymap.set('n', '<leader>gf', function() Snacks.picker.git_log_file() end, { desc = 'Git Log File' })
vim.keymap.set('n', '<leader>gl', function() Snacks.picker.git_log() end, { desc = 'Git Log' })
vim.keymap.set('n', '<leader>gL', function() Snacks.picker.git_log_line() end, { desc = 'Git Log Line' })
vim.keymap.set('n', '<leader>gs', function() Snacks.picker.git_status() end, { desc = 'Git Status' })
vim.keymap.set('n', '<leader>gS', function() Snacks.picker.git_stash() end, { desc = 'Git Stash' })
vim.keymap.set('n', '<leader>s"', function() Snacks.picker.registers() end, { desc = 'Registers' })
vim.keymap.set('n', '<leader>s/', function() Snacks.picker.search_history() end, { desc = 'Search History' })
vim.keymap.set('n', '<leader>sa', function() Snacks.picker.autocmds() end, { desc = 'Autocmds' })
vim.keymap.set('n', '<leader>sb', function() Snacks.picker.lines() end, { desc = 'Buffer Lines' })
vim.keymap.set('n', '<leader>sB', function() Snacks.picker.grep_buffers() end, { desc = 'Grep Open Buffers' })
vim.keymap.set('n', '<leader>sc', function() Snacks.picker.command_history() end, { desc = 'Command History' })
vim.keymap.set('n', '<leader>sC', function() Snacks.picker.commands() end, { desc = 'Commands' })
vim.keymap.set('n', '<leader>sd', function() Snacks.picker.diagnostics() end, { desc = 'Diagnostics' })
vim.keymap.set('n', '<leader>sD', function() Snacks.picker.diagnostics_buffer() end, { desc = 'Buffer Diagnostics' })
vim.keymap.set('n', '<leader>sg', function() Snacks.picker.grep() end, { desc = 'Grep' })
vim.keymap.set({ 'n', 'x' }, '<leader>sw', function() Snacks.picker.grep_word() end, { desc = 'Grep Word' })
vim.keymap.set('n', '<leader>sh', function() Snacks.picker.help() end, { desc = 'Help' })
vim.keymap.set('n', '<leader>sH', function() Snacks.picker.highlights() end, { desc = 'Highlights' })
vim.keymap.set('n', '<leader>si', function() Snacks.picker.icons() end, { desc = 'Icons' })
vim.keymap.set('n', '<leader>sj', function() Snacks.picker.jumps() end, { desc = 'Jumps' })
vim.keymap.set('n', '<leader>sk', function() Snacks.picker.keymaps() end, { desc = 'Keymaps' })
vim.keymap.set('n', '<leader>sl', function() Snacks.picker.loclist() end, { desc = 'Location List' })
vim.keymap.set('n', '<leader>sm', function() Snacks.picker.marks() end, { desc = 'Marks' })
vim.keymap.set('n', '<leader>sM', function() Snacks.picker.man() end, { desc = 'Man Pages' })
vim.keymap.set('n', '<leader>sp', function() Snacks.picker.lazy() end, { desc = 'Plugin Spec' })
vim.keymap.set('n', '<leader>sq', function() Snacks.picker.qflist() end, { desc = 'Quickfix List' })
vim.keymap.set('n', '<leader>sR', function() Snacks.picker.resume() end, { desc = 'Resume' })
vim.keymap.set('n', '<leader>ss', function() Snacks.picker.lsp_symbols() end, { desc = 'LSP Symbols' })
vim.keymap.set('n', '<leader>sS', function() Snacks.picker.lsp_workspace_symbols() end, { desc = 'LSP Workspace Symbols' })
vim.keymap.set('n', '<leader>st', function() Snacks.picker.treesitter() end, { desc = 'Treesitter' })
vim.keymap.set('n', '<leader>su', function() Snacks.picker.undo() end, { desc = 'Undo History' })
vim.keymap.set('n', '<leader>uC', function() Snacks.picker.colorschemes() end, { desc = 'Colorschemes' })
vim.keymap.set('n', 'gd', function() Snacks.picker.lsp_definitions() end, { desc = 'Goto Definition' })
vim.keymap.set('n', 'gD', function() Snacks.picker.lsp_declarations() end, { desc = 'Goto Declaration' })
vim.keymap.set('n', 'gr', function() Snacks.picker.lsp_references() end, { nowait = true, desc = 'References' })
vim.keymap.set('n', 'gI', function() Snacks.picker.lsp_implementations() end, { desc = 'Goto Implementation' })
vim.keymap.set('n', 'gy', function() Snacks.picker.lsp_type_definitions() end, { desc = 'Goto Type Definition' })

-- Which-key
require('which-key').setup { preset = 'modern', delay = 0, icons = { mappings = true } }

-- Gitsigns
require('gitsigns').setup {
  signs = {
    add = { text = '+' }, change = { text = '~' }, delete = { text = '_' },
    topdelete = { text = '‾' }, changedelete = { text = '~' },
  },
  on_attach = function(bufnr)
    local gs = require 'gitsigns'
    vim.keymap.set('n', ']c', function()
      if vim.wo.diff then vim.cmd.normal { ']c', bang = true } else gs.nav_hunk 'next' end
    end, { desc = 'Next git change', buffer = bufnr })
    vim.keymap.set('n', '[c', function()
      if vim.wo.diff then vim.cmd.normal { '[c', bang = true } else gs.nav_hunk 'prev' end
    end, { desc = 'Prev git change', buffer = bufnr })
    vim.keymap.set('v', '<leader>hs', function() gs.stage_hunk { vim.fn.line '.', vim.fn.line 'v' } end, { desc = 'Stage hunk', buffer = bufnr })
    vim.keymap.set('v', '<leader>hr', function() gs.reset_hunk { vim.fn.line '.', vim.fn.line 'v' } end, { desc = 'Reset hunk', buffer = bufnr })
    vim.keymap.set('n', '<leader>hs', gs.stage_hunk, { desc = 'Stage hunk', buffer = bufnr })
    vim.keymap.set('n', '<leader>hr', gs.reset_hunk, { desc = 'Reset hunk', buffer = bufnr })
    vim.keymap.set('n', '<leader>hS', gs.stage_buffer, { desc = 'Stage buffer', buffer = bufnr })
    vim.keymap.set('n', '<leader>hu', gs.stage_hunk, { desc = 'Undo stage hunk', buffer = bufnr })
    vim.keymap.set('n', '<leader>hR', gs.reset_buffer, { desc = 'Reset buffer', buffer = bufnr })
    vim.keymap.set('n', '<leader>hp', gs.preview_hunk, { desc = 'Preview hunk', buffer = bufnr })
    vim.keymap.set('n', '<leader>hb', gs.blame_line, { desc = 'Blame line', buffer = bufnr })
    vim.keymap.set('n', '<leader>hd', gs.diffthis, { desc = 'Diff index', buffer = bufnr })
    vim.keymap.set('n', '<leader>hD', function() gs.diffthis '@' end, { desc = 'Diff last commit', buffer = bufnr })
    vim.keymap.set('n', '<leader>tb', gs.toggle_current_line_blame, { desc = 'Toggle blame', buffer = bufnr })
    vim.keymap.set('n', '<leader>tD', gs.preview_hunk_inline, { desc = 'Toggle deleted', buffer = bufnr })
  end,
}

-- Autopairs
require('nvim-autopairs').setup()

-- Guess indent
require('guess-indent').setup()

-- Hotreload
require('hotreload').setup()

-- Code review
require('review').setup()

-- Tiny code action
require('tiny-code-action').setup { backend = 'vim', picker = 'snacks' }

-- Symbols
local r = require 'symbols.recipes'
require('symbols').setup(r.DefaultFilters, r.AsciiSymbols, {
  sidebar = { cursor_follow = true },
})
vim.keymap.set('n', ',s', '<cmd>SymbolsToggle<CR>')

-- Krust
require('krust').setup {
  keymap = '<leader>k',
  float_win = { border = 'rounded', auto_focus = false },
}

-- CodeDiff
require('codediff').setup { diff = { layout = 'inline' } }
vim.keymap.set('n', '<leader>cd', '<cmd>CodeDiff<CR>', { desc = 'CodeDiff' })

-- Mini
require('mini.ai').setup { n_lines = 500 }
require('mini.surround').setup()

-- Lualine + Navic
local navic = require 'nvim-navic'
navic.setup { icons_enabled = false }

require('lualine').setup {
  options = {
    component_separators = { left = '', right = '' },
    section_separators = { left = '', right = '' },
  },
  tabline = {
    lualine_a = {
      { 'tabs', mode = 1, path = 1, max_length = vim.o.columns },
    },
    lualine_y = {
      { 'fileformat', symbols = { unix = '', dos = '', mac = '' } },
      'encoding',
      { 'filetype', colored = false, icon_only = false },
    },
    lualine_z = {
      { 'lsp_status', icon = '', symbols = {
        spinner = { '◜', '◠', '◝', '◞', '◡', '◟' },
        done = '✓', separator = ' ',
      }, ignore_lsp = {} },
    },
  },
  sections = {
    lualine_b = { { 'branch', icon = '' } },
    lualine_c = {
      { 'filename', file_status = true, newfile_status = true, path = 1 },
      { function() return navic.get_location() end, cond = function() return navic.is_available() end },
    },
    lualine_x = {},
    lualine_y = {},
    lualine_z = { 'progress', 'location' },
  },
}

-- DAP
local dap = require 'dap'
local dapui = require 'dapui'

require('mason-nvim-dap').setup {
  automatic_installation = false,
  handlers = {},
  ensure_installed = { 'codelldb' },
}

dapui.setup {
  controls = {
    element = 'repl', enabled = true,
    icons = {
      disconnect = '', pause = '', play = '', run_last = '',
      step_back = '', step_into = '', step_out = '', step_over = '', terminate = '',
    },
  },
  floating = { border = 'single', mappings = { close = { 'q', '<Esc>' } } },
  icons = { collapsed = '', current_frame = '', expanded = '' },
  layouts = {
    {
      elements = {
        { id = 'scopes', size = 0.25 }, { id = 'breakpoints', size = 0.25 },
        { id = 'stacks', size = 0.25 }, { id = 'watches', size = 0.25 },
      },
      position = 'left', size = 40,
    },
    {
      elements = { { id = 'repl', size = 0.5 }, { id = 'console', size = 0.5 } },
      position = 'bottom', size = 10,
    },
  },
}

vim.api.nvim_set_hl(0, 'DapBreak', { fg = '#e51400' })
vim.api.nvim_set_hl(0, 'DapStop', { fg = '#ffcc00' })
for type, icon in pairs({
  Breakpoint = '', BreakpointCondition = '', BreakpointRejected = '',
  LogPoint = '', Stopped = '',
}) do
  local tp = 'Dap' .. type
  local hl = (type == 'Stopped') and 'DapStop' or 'DapBreak'
  vim.fn.sign_define(tp, { text = icon, texthl = hl, numhl = hl })
end

dap.listeners.after.event_initialized['dapui_config'] = dapui.open
dap.listeners.before.event_terminated['dapui_config'] = dapui.close
dap.listeners.before.event_exited['dapui_config'] = dapui.close

vim.keymap.set('n', '<F5>', dap.continue, { desc = 'Debug: Continue' })
vim.keymap.set('n', '<F1>', dap.step_into, { desc = 'Debug: Step Into' })
vim.keymap.set('n', '<F2>', dap.step_over, { desc = 'Debug: Step Over' })
vim.keymap.set('n', '<F3>', dap.step_out, { desc = 'Debug: Step Out' })
vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint, { desc = 'Toggle Breakpoint' })
vim.keymap.set('n', '<leader>B', function() dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ') end, { desc = 'Set Breakpoint' })
vim.keymap.set('n', '<F7>', dapui.toggle, { desc = 'Debug UI' })
vim.keymap.set('n', '<leader>ld', function() require('nvim-dap-projects').search_project_config() end, { desc = 'Load project debug config' })

-- Theme
require('vague').setup { transparent = true, bold = false, italic = false }
vim.cmd.colorscheme 'vague'
