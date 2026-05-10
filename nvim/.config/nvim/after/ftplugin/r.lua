-- keymaps
vim.keymap.set("i", ">>", "|> ", { desc = "Insert Pipe (|>)", buf = 0 })
vim.keymap.set("i", "<<", "<- ", { desc = "Insert Left Assign (<-)", buf = 0 })
vim.keymap.set("i", "i>", "%in% ", { desc = "Insert %in%", buf = 0 })
vim.keymap.set("i", "n>", "%notin% ", { desc = "Insert %notin%", buf = 0 })
