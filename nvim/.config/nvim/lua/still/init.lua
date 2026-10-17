local M = {}
M.palette = require 'still.palette'
M.config = { transparent = false }

function M.setup(opts)
  M.config = vim.tbl_extend('force', M.config, opts or {})
end

function M.load()
  vim.o.termguicolors = true
  vim.o.background = 'dark'
  vim.cmd 'highlight clear'
  vim.g.colors_name = 'still'

  local c = M.palette
  local bg = M.config.transparent and 'NONE' or c.bg
  local hl = vim.api.nvim_set_hl
  local function set(name, spec) hl(0, name, spec) end
  local function links(target, names)
    for name in names:gmatch('%S+') do set(name, { link = target }) end
  end

  set('Normal', { fg = c.fg, bg = bg })
  -- Foreground-only syntax keeps diff/selection backgrounds visible.
  set('StillText', { fg = c.fg })
  set('StillUI', { fg = c.ui })
  set('StillMuted', { fg = c.muted })
  set('StillMatch', { fg = c.ui, underline = true })
  links('Normal', 'NormalNC Terminal')
  set('MsgArea', { fg = c.ui, bg = bg })
  set('NormalFloat', { fg = c.ui, bg = c.panel })
  set('FloatBorder', { fg = c.border, bg = c.panel })
  set('FloatTitle', { fg = c.ui, bg = c.panel })
  set('FloatFooter', { fg = c.muted, bg = c.panel })
  set('FloatShadow', { bg = '#000000', blend = 80 })
  set('FloatShadowThrough', { bg = '#000000', blend = 100 })
  set('WinSeparator', { fg = c.border })
  set('ColorColumn', { bg = c.panel })
  set('CursorLine', { bg = c.panel })
  links('CursorLine', 'CursorColumn')
  set('Cursor', { fg = c.bg, bg = c.fg })
  links('Cursor', 'lCursor CursorIM TermCursor')
  set('TermCursorNC', { fg = c.bg, bg = c.muted })
  set('LineNr', { fg = c.subtle })
  links('LineNr', 'LineNrAbove LineNrBelow')
  set('CursorLineNr', { fg = c.ui })
  set('SignColumn', { bg = bg })
  links('SignColumn', 'CursorLineSign FoldColumn CursorLineFold')
  set('NonText', { fg = c.subtle })
  links('NonText', 'Whitespace SpecialKey Conceal')
  set('EndOfBuffer', { fg = c.bg })
  set('Visual', { bg = c.selection })
  links('Visual', 'VisualNOS SnippetTabstop')
  set('SnippetTabstopActive', { bg = c.change_text })
  set('Search', { bg = c.selection })
  set('CurSearch', { bg = c.selection, underline = true })
  links('CurSearch', 'IncSearch')
  set('Substitute', { bg = c.selection, underline = true })
  set('MatchParen', { bg = c.selection, underline = true, sp = c.muted })
  set('QuickFixLine', { bg = c.selection })
  set('Folded', { fg = c.muted, bg = c.panel })
  links('StillUI', 'Title Directory Special')
  set('ErrorMsg', { fg = c.red })
  set('WarningMsg', { fg = c.yellow })
  links('StillUI', 'MoreMsg')
  links('Special', 'Question ModeMsg')
  set('StatusLine', { fg = c.ui, bg = c.panel })
  set('StatusLineNC', { fg = c.muted, bg = c.panel })
  links('StatusLine', 'StatusLineTerm')
  set('TabLineSel', { fg = c.ui, bg = c.raised })
  links('StatusLineNC', 'StatusLineTermNC TabLine TabLineFill')
  set('WinBar', { fg = c.ui, bg = bg })
  set('WinBarNC', { fg = c.muted, bg = bg })
  set('Pmenu', { fg = c.ui, bg = c.panel })
  set('PmenuSel', { fg = c.ui, bg = c.selection })
  set('PmenuKind', { fg = c.muted, bg = c.panel })
  set('PmenuExtra', { fg = c.muted, bg = c.panel })
  set('PmenuKindSel', { fg = c.ui, bg = c.selection })
  set('PmenuExtraSel', { fg = c.muted, bg = c.selection })
  links('StillMatch', 'PmenuMatch')
  links('PmenuMatch', 'PmenuMatchSel')
  links('FloatBorder', 'PmenuBorder')
  set('PmenuSbar', { bg = c.raised })
  set('PmenuThumb', { bg = c.border })
  links('StillMatch', 'ComplMatchIns')
  links('PmenuSel', 'WildMenu')

  -- Legacy syntax stays quiet; Tree-sitter distinguishes definitions from calls.
  links('StillText', 'Identifier Function Statement Conditional Repeat Label Keyword Exception PreProc Include Define Macro PreCondit Type StorageClass Structure Typedef SpecialChar Tag Debug')
  set('Delimiter', { fg = c.punctuation })
  set('Operator', { fg = c.punctuation })
  set('Comment', { fg = c.violet })
  set('Constant', { fg = c.green })
  links('Constant', 'String Character Number Boolean Float')
  links('Comment', 'SpecialComment Todo')
  set('Underlined', { fg = c.blue, underline = true })
  set('Ignore', { fg = c.muted })
  set('Error', { fg = c.red, sp = c.red, undercurl = true })
  set('StillDefinition', { fg = c.yellow })
  set('StillDeclaration', { fg = c.blue })

  links('StillText', '@variable @variable.builtin @variable.parameter @variable.parameter.builtin @variable.member @property @module @module.builtin @label @type @type.builtin @attribute @attribute.builtin @constructor @keyword @function.call @function.method.call @function.builtin @function.macro @tag @tag.builtin @tag.attribute')
  links('StillDefinition', '@function @function.method @function.definition @type.definition')
  links('StillDeclaration', '@variable.declaration @variable.parameter.declaration')
  links('Constant', '@constant @constant.builtin @constant.macro @string @string.regexp @string.escape @string.special @character @character.special @boolean @number @number.float')
  links('Comment', '@comment @comment.documentation @comment.error @comment.warning @comment.todo @comment.note @string.documentation')
  links('Delimiter', '@punctuation @punctuation.delimiter @punctuation.bracket @punctuation.special @tag.delimiter')
  links('Operator', '@operator')
  -- Explicitly reset runtime links which otherwise inherit colorful defaults.
  links('StillText', '@keyword.coroutine @keyword.function @keyword.operator @keyword.import @keyword.type @keyword.modifier @keyword.repeat @keyword.return @keyword.debug @keyword.exception @keyword.conditional @keyword.conditional.ternary @keyword.directive @keyword.directive.define')
  links('StillDefinition', '@markup.heading')
  links('StillText', '@markup.strong @markup.italic @markup.math')
  links('Comment', '@markup.quote')
  links('String', '@markup.raw @markup.raw.block')
  links('Underlined', '@markup.link @markup.link.label @markup.link.url @string.special.url')
  links('Delimiter', '@markup.list @markup.list.unchecked')
  links('String', '@markup.list.checked')
  set('@markup.strikethrough', { fg = c.muted, strikethrough = true })
  set('@markup.underline', { underline = true })
  for level = 1, 6 do links('StillDefinition', '@markup.heading.' .. level) end

  -- Preserve Tree-sitter's declaration/call distinction under semantic tokens.
  -- Empty type groups add no paint; modifiers below color declarations only.
  for _, group in ipairs(vim.fn.getcompletion('@lsp', 'highlight')) do set(group, {}) end
  for _, token in ipairs {
    'class', 'comment', 'decorator', 'enum', 'enumMember', 'event', 'function',
    'interface', 'keyword', 'macro', 'method', 'modifier', 'namespace', 'number',
    'operator', 'parameter', 'property', 'regexp', 'string', 'struct', 'type',
    'typeParameter', 'variable', 'boolean',
  } do
    set('@lsp.type.' .. token, {})
  end
  for _, modifier in ipairs { 'declaration', 'definition' } do
    for _, token in ipairs { 'variable', 'parameter', 'property', 'enumMember' } do
      links('StillDeclaration', '@lsp.typemod.' .. token .. '.' .. modifier)
    end
    for _, token in ipairs { 'function', 'method', 'class', 'struct', 'enum', 'interface', 'type' } do
      links('StillDefinition', '@lsp.typemod.' .. token .. '.' .. modifier)
    end
  end
  links('Comment', '@lsp.type.comment')
  links('Constant', '@lsp.type.string @lsp.type.number @lsp.type.regexp @lsp.type.boolean')
  set('@lsp.mod.deprecated', { strikethrough = true })
  set('LspInlayHint', { fg = c.muted, bg = c.panel })
  set('LspCodeLens', { fg = c.muted })
  links('NonText', 'LspCodeLensSeparator')
  set('LspReferenceText', { bg = c.raised })
  links('LspReferenceText', 'LspReferenceRead LspReferenceWrite LspReferenceTarget')
  set('LspSignatureActiveParameter', { bg = c.selection, underline = true })

  for severity, color in pairs { Error = c.red, Warn = c.yellow, Info = c.muted, Hint = c.muted, Ok = c.green } do
    local name = 'Diagnostic' .. severity
    set(name, { fg = color })
    links(name, 'DiagnosticSign' .. severity .. ' DiagnosticFloating' .. severity)
    set('DiagnosticVirtualText' .. severity, { fg = color, bg = c.panel })
    links('DiagnosticVirtualText' .. severity, 'DiagnosticVirtualLines' .. severity)
    set('DiagnosticUnderline' .. severity, { sp = color, undercurl = true })
  end
  links('DiagnosticWarn', 'DiagnosticWarning')
  links('NonText', 'DiagnosticUnnecessary')
  set('DiagnosticDeprecated', { strikethrough = true, sp = c.red })
  for name, color in pairs { Bad = c.red, Cap = c.yellow, Rare = c.violet, Local = c.blue } do
    set('Spell' .. name, { sp = color, undercurl = true })
  end

  -- Background-only diffs retain syntax colors, including 0.12 inline diffs.
  set('DiffAdd', { bg = c.add })
  set('DiffChange', { bg = c.change })
  set('DiffDelete', { fg = c.red, bg = c.delete })
  set('DiffText', { bg = c.change_text })
  set('DiffTextAdd', { bg = c.add_text })
  links('DiagnosticOk', 'Added @diff.plus')
  links('DiagnosticError', 'Removed @diff.minus')
  links('DiagnosticInfo', 'Changed @diff.delta')

  require('still.plugins').apply(set, links, c)

  -- Plugins such as devicons and DiffBandit reapply their own highlights on
  -- ColorScheme. Run after those callbacks so chrome keeps its neutral palette.
  local plugin_group = vim.api.nvim_create_augroup('still-plugin-highlights', { clear = true })
  vim.api.nvim_create_autocmd('ColorScheme', {
    group = plugin_group,
    pattern = '*',
    callback = function()
      if vim.g.colors_name == 'still' then
        require('still.plugins').apply(set, links, c)
      else
        require('still.plugins').restore_ui_windows()
      end
    end,
  })
  vim.api.nvim_create_autocmd('FileType', {
    group = plugin_group,
    pattern = { 'leaninfo', 'dapui*', 'snacks_*', 'mason', 'Symbols*' },
    callback = function()
      vim.schedule(function()
        if vim.g.colors_name == 'still' then require('still.plugins').apply(set, links, c) end
      end)
    end,
  })
  vim.api.nvim_create_autocmd('BufWinEnter', {
    group = plugin_group,
    callback = function() vim.schedule(function() require('still.plugins').ui_windows() end) end,
  })

  -- Also used by Krust's ANSI renderer and new :terminal buffers.
  local terminal = {
    c.bg, c.red, c.green, c.yellow, c.blue, c.violet, c.blue, c.fg,
    c.punctuation, c.red, c.green, c.yellow, c.blue, c.violet, c.blue, '#f1f3f7',
  }
  for i, color in ipairs(terminal) do vim.g['terminal_color_' .. (i - 1)] = color end
end

return M
