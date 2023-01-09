local M = {
  "gbprod/substitute.nvim",
  enabled = true,
  keys = {
    "<A-s>",
    "<A-S>",
  },
}

function M.config()

  require("substitute").setup({
    on_substitute = nil,
    yank_substituted_text = false,
    exchange = {
      motion = "iw",
      use_esc_to_cancel = true,
    },
  })

  vim.keymap.set("n", "<A-s>", require('substitute').operator, { noremap = true })
  vim.keymap.set("x", "<A-s>", require('substitute').visual, { noremap = true })
  vim.keymap.set("n", "<A-x>", require('substitute.exchange').operator, { noremap = true })
  vim.keymap.set("x", "<A-x>", require('substitute.exchange').visual, { noremap = true })
end

return M
