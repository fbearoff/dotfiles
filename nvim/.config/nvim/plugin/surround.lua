vim.g.nvim_surround_no_mappings = true

vim.pack.add({
  "https://github.com/kylechui/nvim-surround",
})

vim.keymap.set("n", "gs", "<Plug>(nvim-surround-normal)", { desc = "Surround" })
vim.keymap.set("n", "gss", "<Plug>(nvim-surround-normal-cur)", { desc = "Surround Current Line" })
vim.keymap.set("x", "gs", "<Plug>(nvim-surround-visual)", { desc = "Surround" })
vim.keymap.set("n", "ds", "<Plug>(nvim-surround-delete)", { desc = "Delete" })
vim.keymap.set("n", "cs", "<Plug>(nvim-surround-change)", { desc = "Change" })
