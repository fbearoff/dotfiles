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
  vim.keymap.set({ "n", "x" }, "y", "<Plug>(YankyYank)", {desc = "Yanky Yank"})

  vim.keymap.set({ "n", "x" }, "p", "<Plug>(YankyPutAfter)", {desc = "Yanky Put After"})
  vim.keymap.set({ "n", "x" }, "P", "<Plug>(YankyPutBefore)", {desc = "Yanky Put Before"})

  vim.keymap.set("n", "<c-n>", "<Plug>(YankyCycleForward)", {desc = "Yanky Cycle Forward"})
  vim.keymap.set("n", "<c-p>", "<Plug>(YankyCycleBackward)", {desc = "Yanky Cycle Backward"})

  vim.keymap.set("n", "]p", "<Plug>(YankyPutAfterFilter)", { desc = "Put After Filter" })
  vim.keymap.set("n", "[p", "<Plug>(YankyPutBeforeFilter)", { desc = "Put before Filter" })
  vim.keymap.set("n", "<leader>v", function()
    require("telescope").extensions.yank_history.yank_history({})
  end, { desc = "Yank History" })
end

return M
