local M = {
  "chentoast/marks.nvim",
  event = "BufReadPost"
}

function M.config()
  require("marks").setup({
    default_mappings = false,
    builtin_marks = { ".", "<", ">", "^" },
    cyclic = true,
    refresh_interval = 250,
    sign_priority = { lower = 10, upper = 15, builtin = 8, bookmark = 20 },
    excluded_filetypes = { "lspinfo", "toggleterm" },
    mappings = {
      set_next = "m,",
      delete_line = "dm",
      next = "mj",
      prev = "mk",
    }
  })
end

return M
