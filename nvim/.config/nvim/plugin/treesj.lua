vim.pack.add({ "https://github.com/wansmer/treesj" })

require("treesj").setup({ use_default_keymaps = false, max_join_length = 150 })

vim.keymap.set({ "n", "x" }, "gj", function()
  require("treesj").join()
end, { desc = "Join Line" })

vim.keymap.set({ "n", "x" }, "gk", function()
  require("treesj").split()
end, { desc = "Split Line" })
