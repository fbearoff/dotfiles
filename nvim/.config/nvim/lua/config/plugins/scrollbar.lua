local M = {
  "lewis6991/satellite.nvim",
  event = "BufReadPost",
}

function M.config()
  require("satellite").setup({
    current_only = true,
    winblend = 50,
    zindex = 40,
    excluded_filetypes = {
      "prompt",
      "TelescopePrompt",
      "noice",
      "notify",
    },
    width = 1,
    handlers = {
      search = {
        enable = true,
      },
      diagnostic = {
        enable = true,
      },
      gitsigns = {
        enable = true,
      },
      marks = {
        enable = true,
        show_builtins = false, -- shows the builtin marks like [ ] < >
      },
    },
  })
end

return M
