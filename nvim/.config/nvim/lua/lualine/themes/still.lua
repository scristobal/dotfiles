local c = require('still').palette
local function mode()
  return {
    a = { fg = c.ui, bg = c.raised, gui = 'NONE' },
    b = { fg = c.ui, bg = c.panel, gui = 'NONE' },
    c = { fg = c.muted, bg = c.panel, gui = 'NONE' },
  }
end

return {
  normal = mode(),
  insert = mode(),
  visual = mode(),
  replace = mode(),
  command = mode(),
  terminal = mode(),
  inactive = {
    a = { fg = c.muted, bg = c.panel, gui = 'NONE' },
    b = { fg = c.muted, bg = c.panel, gui = 'NONE' },
    c = { fg = c.muted, bg = c.panel, gui = 'NONE' },
  },
}
