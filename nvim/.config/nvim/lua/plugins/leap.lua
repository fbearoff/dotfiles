local M = {
  "ggandor/leap.nvim",
  event = "BufReadPost",
  dependencies = {
    { "ggandor/flit.nvim",
      opts = {
        labeled_modes = "nvo",
        multiline = false
      }
    },
    "ggandor/leap-ast.nvim"
  },

    config = function()
      -- require("leap").add_default_mappings()
    vim.keymap.set({ "n", "x", "o" }, "s", "<Plug>(leap-forward-to)")
    vim.keymap.set({ "n", "x", "o" }, "S", "<Plug>(leap-backward-to)")
    vim.keymap.set("n", "gS", "<Plug>(leap-cross-window)")
    vim.keymap.set('n', 'gs',
      function()
        require 'leap'.leap({ target_windows = { vim.api.nvim_get_current_win() } })
      end,
      { desc = "Leap in window" })
    vim.keymap.set({ 'n', 'x', 'o' }, '<M-a>', function() require 'leap-ast'.leap() end, {})

    vim.api.nvim_set_hl(0, 'LeapBackdrop', { link = 'Comment' })
  end,
}

return M
