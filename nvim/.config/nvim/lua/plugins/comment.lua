local M = {
  "numToStr/Comment.nvim",
  enabled = true,
  keys = { { "gc", mode = { "n", "v" } },
    "gcc",
    "gbc" },
  dependencies = {
    {
      "JoosepAlviste/nvim-ts-context-commentstring",
    },
  },
}

function M.config()
  require("Comment").setup({
    padding = true,
    sticky = true,
    ignore = nil,
    toggler = {
      line = 'gcc',
      block = 'gbc',
    },
    opleader = {
      line = 'gc',
      block = 'gb',
    },
    extra = {
      above = 'gcO',
      below = 'gco',
      eol = 'gcA',
    },
    mappings = {
      basic = true,
      extra = true,
      extended = false,
    },
    pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
  })
end

return M
