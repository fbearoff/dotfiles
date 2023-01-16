local M = {
  "jalvesaq/Nvim-R",
  ft = { "r", "rmd", },
  event = "BufReadPost"
}

function M.config()

  local options = {
    R_bracketed_paste = true,
    R_esc_term = false,
    R_commented_lines = true,
    R_args = { '--quiet', '--no-save' },
    R_source_args = 'echo = TRUE, spaced = TRUE',
    R_term_title = 'R',
    R_hl_term = false,
    R_editing_mode = 'vi',
    R_clear_console = false,
    R_clear_line = true,
    R_specialplot = true,
    R_assign = 0,
    R_csv_app = ':TermExec cmd="vd %s"',
    R_auto_omni = {},
    R_hi_fun = false,
    rmd_fenced_languages = { 'r' }
  }

  for k, v in pairs(options) do
    vim.g[k] = v
  end

  -- Keymaps
  local keymap = require('util').keymap

  keymap("n", "<leader><Space>", "<Plug>RDSendLine", { desc = "which_key_ignore" })
  keymap("v", "<leader><Space>", "<Plug>RDSendSelection", { desc = "Send Selection to R" })
  keymap("n", "<LocalLeader>R:", ":RSend ", { desc = "Send R Command" })
  keymap("n", "<LocalLeader>Rl", "<cmd>call RAction('levels')<CR>", { desc = "View Levels" })
  keymap("n", "<LocalLeader>Rh", "<cmd>call RAction('head')<CR>", { desc = "View Head" })
  keymap("n", "<LocalLeader>Rt", "<cmd>call RAction('tail')<CR>", { desc = "View Tail" })
  keymap("n", "<LocalLeader>Ru", "<cmd>RSend update.packages(ask = FALSE)<CR>", { desc = "Update Packages" })
  keymap("n", "<LocalLeader>Ri", function()
    require 'util'.R_install()
  end,
    { desc = "Install Package" })

end

return M
