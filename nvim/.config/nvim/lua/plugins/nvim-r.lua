return {
  "jalvesaq/Nvim-R",
  -- which key integration
  dependencies = {
    {
      "folke/which-key.nvim",
      opts = function(_, opts)
        if require("util").has("Nvim-R") then
          opts.defaults["<localleader>r"] = { name = "+R" }
        end
      end,
    },
  },
  ft = { "r", "rmd" },
  keys = {
    { "<leader><Space>", "<Plug>RDSendLine", desc = "which_key_ignore" },
    { mode = "x", "<leader><Space>", "<Plug>RDSendSelection", desc = "Send Selection to R" },
    { "<LocalLeader>r:", ":RSend ", desc = "Send R Command" },
    { "<LocalLeader>rf", "<Plug>RStart", desc = "Start R" },
    { "<LocalLeader>rq", "<Plug>RStop", desc = "Stop R" },
    { "<LocalLeader>rH", "<Plug>RHelp", desc = "R Help" },
    { "<LocalLeader>rp", "<Plug>RObjectPr", desc = "Print Object" },
    { "<LocalLeader>rs", "<Plug>RObjectStr", desc = "Print Structure" },
    { "<LocalLeader>rS", "<Plug>RSummary", desc = "Summary" },
    { "<LocalLeader>rn", "<Plug>RObjectNames", desc = "View Names" },
    { "<LocalLeader>rv", "<Plug>RViewDF", desc = "View DF" },
    { "<LocalLeader>rl", "<cmd>call RAction('levels')<CR>", desc = "View Levels" },
    { "<LocalLeader>rh", "<cmd>call RAction('head')<CR>", desc = "View Head" },
    { "<LocalLeader>rt", "<cmd>call RAction('tail')<CR>", desc = "View Tail" },
    { "<LocalLeader>ru", "<cmd>RSend update.packages(ask = FALSE)<CR>", desc = "Update Packages" },
    {
      "<LocalLeader>ri",
      function()
        local current_word = vim.call("expand", "<cword>")
        local rsend_command = string.format(':RSend install.packages("' .. current_word .. '")')
        vim.api.nvim_command(rsend_command)
      end,
      desc = "Install Package",
    },
  },
  config = function()
    local options = {
      R_user_maps_only = true,
      R_bracketed_paste = true,
      R_esc_term = false,
      R_commented_lines = true,
      R_args = { "--quiet", "--no-save" },
      R_source_args = "echo = TRUE, spaced = TRUE",
      R_term_title = "R",
      R_hl_term = false,
      R_editing_mode = "vi",
      R_clear_console = false,
      R_clear_line = true,
      R_specialplot = true,
      R_assign = 0,
      R_csv_app = ':TermExec direction=float cmd="vd %s"',
      R_hi_fun = false,
      rmd_fenced_languages = { "r" },
      R_app = "radian",
      R_cmd = "R",
    }
    for k, v in pairs(options) do
      vim.g[k] = v
    end
  end,
}
