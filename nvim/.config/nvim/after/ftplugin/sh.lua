local keymap = vim.keymap.set
keymap(
  { "o", "x" },
  "i|",
  "<cmd>lua require('various-textobjs').shellPipe(true)<CR>",
  { buffer = true, desc = "ShellPipe" }
)
keymap(
  { "o", "x" },
  "a|",
  "<cmd>lua require('various-textobjs').shellPipe(false)<CR>",
  { buffer = true, desc = "ShellPipe" }
)
