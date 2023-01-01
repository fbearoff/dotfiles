local M = {
  "phaazon/hop.nvim",
  cmd = "HopWord",
  keys = { "f", "t" },
  enabled = false,
}

function M.config()
  require("hop").setup({
    teasing = false
  })

  local hop = require("hop")
  local directions = require('hop.hint').HintDirection
  local keymap = vim.keymap.set

  keymap("", "gh", "<cmd>:HopWord<cr>", { desc = "Hop Word" })
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
end

return M
