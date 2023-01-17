return {
  "jalvesaq/Nvim-R",
  ft = { "r", "rmd" },
  keys = {
    { "<leader><Space>", "<Plug>RDSendLine", desc = "which_key_ignore" },
    { mode = "x", "<leader><Space>", "<Plug>RDSendSelection", desc = "Send Selection to R" },
    { "<LocalLeader>R:", ":RSend ", desc = "Send R Command" },
    { "<LocalLeader>Rl", "<cmd>call RAction('levels')<CR>", desc = "View Levels" },
    { "<LocalLeader>Rh", "<cmd>call RAction('head')<CR>", desc = "View Head" },
    { "<LocalLeader>Rt", "<cmd>call RAction('tail')<CR>", desc = "View Tail" },
    { "<LocalLeader>Ru", "<cmd>RSend update.packages(ask = FALSE)<CR>", desc = "Update Packages" },
    { "<LocalLeader>Ri", function() require 'util'.R_install() end, desc = "Install Package" },
  },
  config = function()
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
  end
}
