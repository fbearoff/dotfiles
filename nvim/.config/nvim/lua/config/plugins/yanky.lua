local M = {
  "gbprod/yanky.nvim",
  event = "BufReadPost",
  dependencies = {
    "kkharji/sqlite.lua",
  },
}

function M.config()
  require("yanky").setup({
    highlight = {
      on_put = false,
      on_yank = false,
      timer = 150,
    },
    preserve_cursor_position = {
      enabled = true,
    },
    ring = {
      storage = "sqlite",
    },
  })
  vim.keymap.set({ "n", "x" }, "y", "<Plug>(YankyYank)")

  vim.keymap.set({ "n", "x" }, "p", "<Plug>(YankyPutAfter)")
  vim.keymap.set({ "n", "x" }, "P", "<Plug>(YankyPutBefore)")
  vim.keymap.set({ "n", "x" }, "gp", "<Plug>(YankyGPutAfter)")
  vim.keymap.set({ "n", "x" }, "gP", "<Plug>(YankyGPutBefore)")

  vim.keymap.set("n", "<c-n>", "<Plug>(YankyCycleForward)")
  vim.keymap.set("n", "<c-p>", "<Plug>(YankyCycleBackward)")

  vim.keymap.set("n", "]p", "<Plug>(YankyPutAfterFilter)")
  vim.keymap.set("n", "[p", "<Plug>(YankyPutBeforeFilter)")
  vim.keymap.set("n", "<leader>v", function()
    require("telescope").extensions.yank_history.yank_history({})
  end, { desc = "Paste from Yanky" })
end

return M
