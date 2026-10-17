local M = {}

function M.apply(set, links, c)
  links('StillUI', 'lualine_transparent')
  -- UI labels never borrow the syntax palette, including groups created lazily.
  for _, prefix in ipairs { 'SnacksPicker', 'BlinkCmp', 'WhichKey', 'Navic', 'DapUI', 'Mason', 'TinyCodeActionKind' } do
    for _, name in ipairs(vim.fn.getcompletion(prefix, 'highlight')) do links('StillUI', name) end
  end
  for _, prefix in ipairs { 'DevIcon', 'MiniIcons' } do
    for _, name in ipairs(vim.fn.getcompletion(prefix, 'highlight')) do links('StillMuted', name) end
  end
  local function neutral(prefix, names, target)
    for suffix in names:gmatch('%S+') do links(target or 'StillUI', prefix .. suffix) end
  end

  -- Define lazy Snacks groups before their modules install syntax-based defaults.
  neutral('SnacksPicker', [[
    Match Search Prompt InputSearch Special Label Totals File Link LinkBroken
    Directory PathIgnored PathHidden Dir Toggle Dimmed Row Col Comment Desc Delim
    Spinner Selected Cmd CmdBuiltin Unselected Idx Bold Italic Code AuPattern
    AuEvent AuGroup DiagnosticCode DiagnosticSource Register KeymapMode KeymapLhs
    KeymapNowait BufNr BufFlags BufType FileType KeymapRhs Time UndoCurrent
    UndoSaved GitCommit GitDetached GitBranch GitBranchCurrent GitDate GitIssue
    GitAuthor GitType GitScope GitStatus GitStatusRenamed GitStatusCopied
    GitStatusUntracked GitStatusIgnored ManSection PickWin PickWinCurrent
    LspDisabled LspEnabled LspAttached LspAttachedBuf LspUnavailable ManPage
    Icon IconSource IconName IconCategory Rule Tree
  ]])
  links('NormalFloat', 'SnacksNormal SnacksInputNormal SnacksPickerNormal SnacksPickerInput SnacksPickerList SnacksPickerPreview SnacksPickerBox SnacksNotifierHistory SnacksNotifierMinimal')
  links('WinSeparator', 'SnacksWinBar SnacksWinSeparator')
  links('FloatBorder', 'SnacksInputBorder SnacksPickerBorder SnacksPickerInputBorder SnacksPickerListBorder SnacksPickerPreviewBorder SnacksPickerBoxBorder')
  links('FloatTitle', 'SnacksInputTitle SnacksPickerTitle SnacksPickerInputTitle SnacksPickerListTitle SnacksPickerPreviewTitle SnacksPickerBoxTitle SnacksNotifierHistoryTitle')
  links('StillUI', 'SnacksInputIcon SnacksInputPrompt')
  links('StillMatch', 'SnacksPickerMatch')
  neutral('SnacksPicker', 'Dir Tree Dimmed Totals Unselected Idx BufNr Col Row Time Comment DiagnosticSource GitDate', 'StillMuted')
  links('NonText', 'SnacksIndent SnacksScope SnacksIndentScope SnacksIndentChunk')
  links('LspReferenceText', 'SnacksWordsRead SnacksWordsWrite')
  links('Visual', 'SnacksPickerCursorLine SnacksPickerListCursorLine SnacksPickerPreviewCursorLine')
  links('DiagnosticOk', 'SnacksPickerGitStatusAdded SnacksPickerUndoAdded')
  links('DiagnosticWarn', 'SnacksPickerGitStatusModified')
  links('DiagnosticError', 'SnacksPickerGitStatusDeleted SnacksPickerGitStatusUnmerged SnacksPickerUndoRemoved SnacksPickerGitBreaking SnacksPickerLinkBroken')
  links('StillUI', 'SnacksPickerGitStatusStaged')
  for _, level in ipairs { 'Trace', 'Debug', 'Info', 'Warn', 'Error' } do
    links('NormalFloat', 'SnacksNotifier' .. level)
    links('FloatBorder', 'SnacksNotifierBorder' .. level)
    links('FloatTitle', 'SnacksNotifierTitle' .. level)
    links('FloatFooter', 'SnacksNotifierFooter' .. level)
    local target = (level == 'Warn' or level == 'Error') and 'Diagnostic' .. level or 'StillMuted'
    links(target, 'SnacksNotifierIcon' .. level)
  end

  links('Pmenu', 'BlinkCmpMenu')
  links('FloatBorder', 'BlinkCmpMenuBorder BlinkCmpDocBorder BlinkCmpSignatureHelpBorder')
  links('PmenuSel', 'BlinkCmpMenuSelection')
  links('StillUI', 'BlinkCmpLabel')
  links('StillMatch', 'BlinkCmpLabelMatch')
  links('StillMuted', 'BlinkCmpKind BlinkCmpLabelDetail BlinkCmpLabelDescription BlinkCmpSource BlinkCmpGhostText')
  links('NormalFloat', 'BlinkCmpDoc BlinkCmpSignatureHelp')
  links('WinSeparator', 'BlinkCmpDocSeparator')
  links('Visual', 'BlinkCmpDocCursorLine')
  links('LspSignatureActiveParameter', 'BlinkCmpSignatureHelpActiveParameter')
  links('PmenuThumb', 'BlinkCmpScrollBarThumb')
  links('PmenuSbar', 'BlinkCmpScrollBarGutter')
  set('BlinkCmpLabelDeprecated', { fg = c.muted, strikethrough = true })

  links('NormalFloat', 'WhichKeyNormal')
  links('FloatBorder', 'WhichKeyBorder')
  links('FloatTitle', 'WhichKeyTitle')
  links('StillUI', 'WhichKey WhichKeyGroup WhichKeyDesc')
  links('StillMuted', 'WhichKeySeparator WhichKeyValue WhichKeyIcon')
  neutral('WhichKeyIcon', 'Azure Blue Cyan Green Grey Orange Purple Red Yellow', 'StillMuted')

  for kind, target in pairs { Add = 'DiagnosticOk', Change = 'StillMuted', Delete = 'DiagnosticError', Topdelete = 'DiagnosticError', Changedelete = 'DiagnosticWarn', Untracked = 'NonText' } do
    links(target, 'GitSigns' .. kind .. ' GitSigns' .. kind .. 'Nr')
    links('StillMuted', 'GitSignsStaged' .. kind .. ' GitSignsStaged' .. kind .. 'Nr')
  end
  links('DiffAdd', 'GitSignsAddLn GitSignsAddPreview')
  links('DiffChange', 'GitSignsChangeLn')
  links('DiffDelete', 'GitSignsDeleteLn GitSignsDeletePreview')
  links('DiffTextAdd', 'GitSignsAddInline')
  links('DiffText', 'GitSignsChangeInline')
  set('GitSignsDeleteInline', { bg = c.delete_text })
  links('StillMuted', 'GitSignsCurrentLineBlame GitSignsVirtLnum')

  links('DiffAdd', 'CodeDiffLineInsert')
  set('CodeDiffLineDelete', { bg = c.delete })
  links('DiffTextAdd', 'CodeDiffCharInsert')
  set('CodeDiffCharDelete', { bg = c.delete_text })
  links('DiffChange', 'CodeDiffLineMove')
  links('DiffText', 'CodeDiffCharMove')
  links('StillMuted', 'CodeDiffMoveFrom CodeDiffMoveTo CodeDiffConflictSignResolved')
  links('NonText', 'CodeDiffFiller NeoTreeIndentMarker')
  links('StillUI', 'ExplorerDirectorySmall CodeDiffExplorerTreeGroup CodeDiffHistoryTitle')
  links('Visual', 'CodeDiffExplorerSelected')
  links('DiagnosticOk', 'CodeDiffStatusAdded CodeDiffConflictSignAccepted')
  links('DiagnosticWarn', 'CodeDiffStatusModified CodeDiffConflictSign')
  links('DiagnosticError', 'CodeDiffStatusDeleted CodeDiffStatusConflict CodeDiffConflictSignRejected')
  links('StillMuted', 'CodeDiffStatusRenamed CodeDiffStatusUntracked')
  for name, spec in pairs(M.diffbandit()) do set(name, spec) end

  -- Symbol kinds label the UI; their syntax colors belong inside the code buffer.
  for _, kind in ipairs {
    'File', 'Module', 'Namespace', 'Package', 'Class', 'Method', 'Property',
    'Field', 'Constructor', 'Enum', 'Interface', 'Function', 'Variable',
    'Constant', 'String', 'Number', 'Boolean', 'Array', 'Object', 'Key',
    'Null', 'EnumMember', 'Struct', 'Event', 'Operator', 'TypeParameter',
    'Text', 'Unit', 'Value', 'Keyword', 'Snippet', 'Color', 'Reference', 'Folder',
  } do
    links('StillMuted', 'NavicIcons' .. kind .. ' BlinkCmpKind' .. kind .. ' SnacksPickerIcon' .. kind)
  end
  links('StillUI', 'NavicText')
  links('StillMuted', 'NavicSeparator')

  links('DiagnosticError', 'DapBreak DapBreakpoint DapBreakpointCondition DapBreakpointRejected DapUIWatchesError')
  links('DiagnosticWarn', 'DapStop DapStopped')
  links('StillMuted', 'DapLogPoint DapUIUnavailable DapUIBreakpointsDisabledLine DapUILineNumber DapUIBreakpointsLine DapUIWatchesEmpty DapUIBreakpointsInfo')
  links('StillUI', 'DapUINormal')
  links('StillUI', 'DapUIVariable DapUIValue DapUIFrameName DapUIWatchesValue DapUIScope DapUIDecoration DapUIThread DapUISource DapUIBreakpointsPath DapUIType DapUIStoppedThread')
  links('StillMatch', 'DapUIModifiedValue DapUICurrentFrameName DapUIBreakpointsCurrentLine DapUIWinSelect')
  links('NormalFloat', 'DapUIFloatNormal')
  links('FloatBorder', 'DapUIFloatBorder')
  links('NonText', 'DapUIEndofBuffer')
  neutral('DapUI', 'PlayPause Restart Stop StepOver StepInto StepBack StepOut', 'StillMuted')
  for _, control in ipairs { 'Normal', 'PlayPause', 'Restart', 'Stop', 'Unavailable', 'StepOver', 'StepInto', 'StepBack', 'StepOut' } do
    links('DapUI' .. control, 'DapUI' .. control .. 'NC')
  end

  links('Visual', 'MiniSurround LuaSnipChoiceNodeActive LuaSnipInsertNodeActive')
  links('StillUI', 'MasonHeader MasonHighlight MasonHighlightSecondary MasonHeaderSecondary')
  links('PmenuSel', 'MasonHighlightBlock MasonHighlightBlockBold MasonHighlightBlockSecondary MasonHighlightBlockBoldSecondary')
  links('NormalFloat', 'MasonNormal')
  links('StillMuted', 'MasonMuted MasonMutedBlock MasonMutedBlockBold')
  links('StillUI', 'MasonHeading MasonLink')
  links('DiagnosticError', 'MasonError')
  links('DiagnosticWarn', 'MasonWarning')
  neutral('TinyCodeActionKind', 'quickfix others refactor refactor.move refactor.extract source.organizeImports source.fixAll source rename codeAction')
  links('StillUI', 'leanInfoHypName leanInfoExpectedType leanInfoGoalPrefix leanInfoGoalCase leanInfoGoals leanInfoMultipleGoals')
  links('Visual', 'leanInfoSelected')
  links('DiffAdd', 'leanInfoHypNameInserted leanInfoGoalInserted')
  links('DiffDelete', 'leanInfoHypNameRemoved leanInfoGoalRemoved')
  M.ui_windows()
end

-- Some UIs use syntax groups directly. A window highlight namespace keeps
-- those neutral without inheritable winhighlight overrides leaking into code.
local ui_namespace = vim.api.nvim_create_namespace 'still-ui'
local ui_windows = {}
function M.ui_windows()
  if vim.g.colors_name ~= 'still' then return M.restore_ui_windows() end
  local c = require('still').palette
  for _, group in ipairs { 'Comment', 'SpecialComment', 'Number', 'Float' } do
    vim.api.nvim_set_hl(ui_namespace, group, { fg = c.muted })
  end
  for _, group in ipairs { 'Constant', 'String', 'Character', 'Boolean', 'Title', 'Function', 'Identifier', 'Type' } do
    vim.api.nvim_set_hl(ui_namespace, group, { fg = c.ui })
  end
  vim.api.nvim_set_hl(ui_namespace, 'Underlined', { fg = c.ui, underline = true })
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local ft = vim.bo[vim.api.nvim_win_get_buf(win)].filetype
    local current = vim.api.nvim_get_hl_ns { winid = win }
    local saved = ui_windows[win]
    if ft == 'mason' or ft == 'SymbolsSidebar' or ft == 'SymbolsSearch' or ft == 'SymbolsHelp' then
      if current ~= ui_namespace then
        ui_windows[win] = current
        vim.api.nvim_win_set_hl_ns(win, ui_namespace)
      end
    else
      if current == ui_namespace then vim.api.nvim_win_set_hl_ns(win, saved or -1) end
      ui_windows[win] = nil
    end
  end
  for win in pairs(ui_windows) do
    if not vim.api.nvim_win_is_valid(win) then ui_windows[win] = nil end
  end
end

function M.restore_ui_windows()
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    if vim.api.nvim_get_hl_ns { winid = win } == ui_namespace then
      vim.api.nvim_win_set_hl_ns(win, ui_windows[win] or -1)
    end
  end
  ui_windows = {}
end

-- DiffBandit's supported overrides survive its own highlight refreshes.
function M.diffbandit()
  return {
    DiffBanditStatus = { link = 'StatusLine' },
    DiffBanditStatusLine = { link = 'StatusLineNC' },
    DiffBanditStatusAccent = { link = 'StatusLine' },
    DiffBanditStatusMuted = { link = 'StatusLineNC' },
    DiffBanditAccentText = { link = 'StillUI' },
    DiffBanditMutedText = { link = 'StillMuted' },
    DiffBanditGap = { link = 'NonText' },
    DiffBanditPlaceholder = { link = 'NonText' },
    DiffBanditEmptyNotice = { link = 'StillMuted' },
    DiffBanditConnectorContext = { link = 'NonText' },
  }
end

function M.symbols()
  local kinds = {}
  for _, kind in ipairs(vim.lsp.protocol.SymbolKind) do kinds[kind] = 'StillUI' end
  for i = 1, 6 do kinds['H' .. i] = 'StillUI' end
  kinds.Tag = 'StillUI'
  return {
    sidebar = { hl_details = 'StillMuted', chars = { hl_guides = 'NonText', hl_foldmarker = 'NonText' } },
    providers = {
      lsp = { highlights = { default = kinds } },
      treesitter = { highlights = { default = kinds, markdown = kinds, help = kinds, json = kinds, jsonl = kinds, org = kinds } },
    },
  }
end

return M
