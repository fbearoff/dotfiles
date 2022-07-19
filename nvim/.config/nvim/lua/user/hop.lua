local status_ok, hop = pcall(require, "hop")
if not status_ok then
  return
end

hop.setup()

local opts = { noremap = true, silent = true }

local keymap = vim.api.nvim_set_keymap

-- keymap("n", "s/", ':HopPattern<cr>' , opts)
keymap('', 's/', "<cmd>lua require'hop'.hint_patterns({ })<cr>", opts)
keymap('', 'sW', "<cmd>lua require'hop'.hint_words({ current_line_only = false })<cr>", opts)
keymap('', 'sw', "<cmd>lua require'hop'.hint_words({ current_line_only = true })<cr>", opts)
keymap('', 'se', "<cmd>lua require'hop'.hint_words({ hint_position = require'hop.hint'.HintPosition.END, current_line_only = true })<cr>", opts)
keymap('', 'sE', "<cmd>lua require'hop'.hint_words({ hint_position = require'hop.hint'.HintPosition.END, current_line_only = false })<cr>", opts)
