vim.opt_local.spell = true

local keymap = vim.keymap.set
keymap(
  { "o", "x" },
  "iF",
  "<cmd>lua require('various-textobjs').mdFencedCodeBlock(true)<CR>",
  { buffer = true, desc = "Fenced Codeblock" }
)
keymap(
  { "o", "x" },
  "aF",
  "<cmd>lua require('various-textobjs').mdFencedCodeBlock(false)<CR>",
  { buffer = true, desc = "Fenced Codeblock" }
)
