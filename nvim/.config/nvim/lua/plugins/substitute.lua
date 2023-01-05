local M = {
  "gbprod/substitute.nvim",
  enable = true,
  keys = {
    "<M-s>",
    "<M-S>",
    "xc"
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

  vim.keymap.set("n", "<M-s>", require('substitute').operator, { noremap = true })
  vim.keymap.set("x", "<M-s>", require('substitute').visual, { noremap = true })
  vim.keymap.set("n", "xc", require('substitute.exchange').operator, { noremap = true })
  vim.keymap.set("x", "xc", require('substitute.exchange').visual, { noremap = true })
end

return M
