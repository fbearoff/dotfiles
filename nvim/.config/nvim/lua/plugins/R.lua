return {
  "R-nvim/R.nvim",
  ft = { "r", "rmd" },
  keys = {
    { ft = { "r", "rdoc" }, "<leader><Space>", "<Plug>RDSendLine", desc = "which_key_ignore" },
    { ft = { "r", "rdoc" }, mode = "x", "<leader><Space>", "<Plug>RDSendSelection", desc = "Send Selection to R" },
    { "<LocalLeader>r:", ":RSend ", desc = "Send R Command" },
    { "<LocalLeader>rf", "<Plug>RStart", desc = "Start R" },
    { "<LocalLeader>ro", "<Plug>ROBToggle", desc = "Object Browser" },
    { "<LocalLeader>rq", "<Plug>RClose", desc = "Stop R" },
    { "<LocalLeader>rH", "<Plug>RHelp", desc = "R Help" },
    { "<LocalLeader>rp", "<Plug>RObjectPr", desc = "Print Object" },
    { "<LocalLeader>rs", "<Plug>RObjectStr", desc = "Print Structure" },
    { "<LocalLeader>rS", "<Plug>RSummary", desc = "Summary" },
    { "<LocalLeader>rn", "<Plug>RObjectNames", desc = "View Names" },
    { "<LocalLeader>rv", "<Plug>RViewDF", desc = "View DF" },
    { "<LocalLeader>rg", "<cmd>call RAction('glimpse')<CR>", desc = "Glimpse" },
    { "<LocalLeader>rc", "<cmd>call RAction('class')<CR>", desc = "View Class" },
    { "<LocalLeader>rl", "<cmd>call RAction('levels')<CR>", desc = "View Levels" },
    { "<LocalLeader>rh", "<cmd>call RAction('head')<CR>", desc = "View Head" },
    { "<LocalLeader>rt", "<cmd>call RAction('tail')<CR>", desc = "View Tail" },
    {
      "<LocalLeader>ru",
      "<cmd>RSend update.packages(ask = FALSE)<CR>",
      desc = "Update Packages",
    },
    {
      "<LocalLeader>rU",
      "<cmd>RSend BiocManager::install()<CR>",
      desc = "Update Bioconductor Packages",
    },
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
  opts = {
    R_args = { "--quiet", "--no-save" },
    assign = false,
    bracketed_paste = true,
    clear_console = false,
    clear_line = true,
    csv_app = ':TermExec direction=float cmd="vd %s"',
    editing_mode = "vi",
    esc_term = false,
    hl_term = false,
    source_args = "echo = TRUE, spaced = TRUE",
    specialplot = true,
    term_title = "R",
    user_maps_only = true,
  },
}
