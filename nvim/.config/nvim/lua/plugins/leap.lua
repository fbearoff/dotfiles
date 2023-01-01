local M = {
  "ggandor/leap.nvim",
  keys = { "<M-s>", "<M-S>", "f", "t", "gs" },

  dependencies = {
    { "ggandor/flit.nvim",
      config = {
        labeled_modes = "nvo",
        multiline = false
      }
    },
  },

  config = function()
    vim.keymap.set({ "n", "x", "o" }, "<M-s>", "<Plug>(leap-forward-to)")
    vim.keymap.set({ "x", "o" }, "<M-x>", "<Plug>(leap-forward-till)")

    vim.keymap.set({ "n", "x", "o" }, "<M-S>", "<Plug>(leap-backward-to)")
    vim.keymap.set({ "x", "o" }, "<M-X>", "<Plug>(leap-backward-till)")

    vim.keymap.set({ "n", "x", "o" }, "gs", "<Plug>(leap-cross-window)")

    vim.api.nvim_set_hl(0, 'LeapBackdrop', { link = 'Comment' })
  end,
}

return M
