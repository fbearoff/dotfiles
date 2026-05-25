vim.pack.add({
  "https://github.com/romgrk/barbar.nvim",
})

require("barbar").setup({
  auto_hide = 1,
  sidebar_filetypes = {
    snacks_picker_list = true,
  },
  tabpages = false,
  icons = {
    separator_at_end = false,
    separator = { left = "│" },
    buffer_index = true,
    button = false,
  },
  minimum_padding = 0,
  maximum_padding = 0,
})

vim.keymap.set("n", "<M-,>", "<cmd>BufferPrevious<CR>", { desc = "Previous Buffer" })
vim.keymap.set("n", "<M-.>", "<cmd>BufferNext<CR>", { desc = "Next Buffer" })
vim.keymap.set("n", "]b", "<cmd>BufferNext<CR>", { desc = "Next Buffer" })
vim.keymap.set("n", "[b", "<cmd>BufferPrevious<CR>", { desc = "Previous Buffer" })
vim.keymap.set("n", "]B", "<cmd>BufferLast<CR>", { desc = "Last Buffer" })
vim.keymap.set("n", "[B", "<cmd>BufferFirst<CR>", { desc = "First Buffer" })
vim.keymap.set("n", "<leader>bc", "<cmd>BufferClose!<CR>", { desc = "Close Buffer" })
vim.keymap.set("n", "<leader>be", "<cmd>BufferCloseAllButCurrent<CR>", { desc = "Close All But Current Buffer" })
vim.keymap.set("n", "<M-<>", "<cmd>BufferMovePrevious<CR>", { desc = "Move Buffer Left" })
vim.keymap.set("n", "<M->>", "<cmd>BufferMoveNext<CR>", { desc = "Move Buffer Right" })
vim.keymap.set("n", "<M-1>", "<cmd>BufferGoto 1<CR>", { desc = "Buffer 1" })
vim.keymap.set("n", "<M-2>", "<cmd>BufferGoto 2<CR>", { desc = "Buffer 2" })
vim.keymap.set("n", "<M-3>", "<cmd>BufferGoto 3<CR>", { desc = "Buffer 3" })
vim.keymap.set("n", "<M-4>", "<cmd>BufferGoto 4<CR>", { desc = "Buffer 4" })
vim.keymap.set("n", "<M-5>", "<cmd>BufferGoto 5<CR>", { desc = "Buffer 5" })
vim.keymap.set("n", "<M-6>", "<cmd>BufferGoto 6<CR>", { desc = "Buffer 6" })
vim.keymap.set("n", "<M-7>", "<cmd>BufferGoto 7<CR>", { desc = "Buffer 7" })
vim.keymap.set("n", "<M-8>", "<cmd>BufferGoto 8<CR>", { desc = "Buffer 8" })
vim.keymap.set("n", "<M-9>", "<cmd>BufferGoto 9<CR>", { desc = "Buffer 9" })
vim.keymap.set("n", "<M-0>", "<cmd>BufferLast<CR>", { desc = "Last Buffer" })
vim.keymap.set("n", "<M-c>", "<cmd>BufferClose<CR>", { desc = "Close Buffer" })
