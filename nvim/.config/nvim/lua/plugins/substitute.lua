local M = {
  "gbprod/substitute.nvim",
  enable = true,
  keys = { { "s", mode = "n", "x" },
    "sx",
    { "X", mode = "x" } }
}

function M.config()

  require("substitute").setup({
    on_substitute = nil,
    yank_substituted_text = false,
    range = {
      prefix = "s",
      prompt_current_text = false,
      confirm = false,
      complete_word = false,
      motion1 = false,
      motion2 = false,
      suffix = "",
    },
    exchange = {
      motion = "iw",
      use_esc_to_cancel = true,
    },
  })

  vim.keymap.set("n", "s", require('substitute').operator, { noremap = true })
  vim.keymap.set("x", "s", require('substitute').visual, { noremap = true })
  vim.keymap.set("n", "sx", require('substitute.exchange').operator, { noremap = true })
  vim.keymap.set("x", "X", require('substitute.exchange').visual, { noremap = true })
end

return M
