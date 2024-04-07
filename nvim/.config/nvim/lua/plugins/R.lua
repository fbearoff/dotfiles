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
    { "<LocalLeader>rP", "<Plug>RSeparatePathPaste", desc = "Separate Path Paste" },
    {
      "<LocalLeader>rg",
      function()
        require("r.run").action("glimpse")
      end,
      desc = "Glimpse",
    },
    {
      "<LocalLeader>rc",
      function()
        require("r.run").action("class")
      end,
      desc = "View Class",
    },
    {
      "<LocalLeader>rl",
      function()
        require("r.run").action("levels")
      end,
      desc = "View Levels",
    },
    {
      "<LocalLeader>rh",
      function()
        require("r.run").action("head")
      end,
      desc = "View Head",
    },
    {
      "<LocalLeader>rt",
      function()
        require("r.run").action("tail")
      end,
      desc = "View Tail",
    },
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
    setwd = "file",
    user_maps_only = true,
  },
}
