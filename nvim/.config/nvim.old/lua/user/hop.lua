local status_ok, hop = pcall(require, "hop")
if not status_ok then
  return
end

hop.setup()

local keymap = vim.keymap.set
local directions = require('hop.hint').HintDirection

keymap('', 'f/', function()
  hop.hint_patterns({})
end, { remap = true })
keymap('', 'f', function()
  hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true })
end, { remap = true })
keymap('', 'F', function()
  hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true })
end, { remap = true })
keymap('', 't', function()
  hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true, hint_of = -1 })
end, { remap = true })
keymap('', 'T', function()
  hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true, hint_of = 1 })
end, { remap = true })
