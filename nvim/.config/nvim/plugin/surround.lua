vim.pack.add({
  "https://github.com/kylechui/nvim-surround",
})

-- surround
vim.keymap.set("i", "<C-g>s", "<Plug>(nvim-surround-insert)", { desc = "Surround" })
vim.keymap.set("i", "<C-g>S", "<Plug>(nvim-surround-insert-line)", { desc = "Surround Line" })
vim.keymap.set("n", "ys", "<Plug>(nvim-surround-normal)", { desc = "Surround" })
vim.keymap.set("n", "yss", "<Plug>(nvim-surround-normal-cur)", { desc = "Surround Current Line" })
vim.keymap.set("n", "yS", "<Plug>(nvim-surround-normal-line)", { desc = "Surround Around Motion on New Lines" })
vim.keymap.set("n", "ySS", "<Plug>(nvim-surround-normal-cur-line)", { desc = "Surround Around Current Line" })
vim.keymap.set("x", "S", "<Plug>(nvim-surround-visual)", { desc = "Surround" })
vim.keymap.set("x", "gS", "<Plug>(nvim-surround-visual-line)", { desc = "Surround Line" })
vim.keymap.set("n", "ds", "<Plug>(nvim-surround-delete)", { desc = "Delete" })
vim.keymap.set("n", "cs", "<Plug>(nvim-surround-change)", { desc = "Change" })
vim.keymap.set("n", "cS", "<Plug>(nvim-surround-change-line)", { desc = "Change Line" })
