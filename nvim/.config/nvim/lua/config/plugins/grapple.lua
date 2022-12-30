local M = {
  "cbochs/grapple.nvim",
  dependencies = "nvim-lua/plenary.nvim",
  keys = { "<leader><tab>" },
  enabled = true
}

function M.config()
  require("grapple").setup({
    log_level = "warn",

    scope = "git",

    ---Window options used for the popup menu
    popup_options = {
      relative = "editor",
      width = 60,
      height = 12,
      style = "minimal",
      focusable = false,
      border = "single",
    },

    integrations = {
      resession = false,
    },
  })
end

return M
