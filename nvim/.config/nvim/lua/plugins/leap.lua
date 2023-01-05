local M = {
  "ggandor/leap.nvim",
  event = "BufReadPost",
  dependencies = {
    { "ggandor/flit.nvim",
      config = {
        labeled_modes = "nvo",
        multiline = false
      }
    },
    "ggandor/leap-ast.nvim"
  },

  config = function()
    vim.keymap.set({ "n", "x", "o" }, "s", "<Plug>(leap-forward-to)")
    vim.keymap.set({ "n", "x", "o" }, "S", "<Plug>(leap-backward-to)")
    vim.keymap.set({ "n", "x", "o" }, "gs", "<Plug>(leap-cross-window)")
    --
    vim.api.nvim_set_hl(0, 'LeapBackdrop', { link = 'Comment' })
    vim.keymap.set({ 'n', 'x', 'o' }, '<M-a>', function() require 'leap-ast'.leap() end, {})
  end,
}

return M
