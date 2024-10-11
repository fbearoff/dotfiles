return {
  "R-nvim/R.nvim",
  ft = { "r", "rmd" },
  opts = {
    hook = {
      on_filetype = function()
        require("which-key").add({
          buffer = true,
          { "<LocalLeader>r", group = "+R" },
          {
            "<leader><Space>",
            function()
              require("r.send").line(true)
            end,
            desc = "which_key_ignore",
          },
          {
            mode = "x",
            "<leader><Space>",
            function()
              require("r.send").selection(true)
            end,
            desc = "Send Selection to R",
          },
          { "<LocalLeader>r:", ":RSend ", desc = "Send R Command" },
          {
            "<LocalLeader>rf",
            function()
              require("r.run").start_R("R")
            end,
            desc = "Start R",
          },
          {
            "<LocalLeader>ro",
            function()
              require("r.browser").start()
            end,
            desc = "Object Browser",
          },
          {
            "<LocalLeader>rq",
            function()
              require("r.run").quit_R("nosave")
            end,
            desc = "Stop R",
          },
          {
            "<LocalLeader>rH",
            function()
              require("r.run").action("help")
            end,
            desc = "R Help",
          },
          {
            "<LocalLeader>rp",
            function()
              require("r.run").action("print")
            end,
            desc = "Print Object",
          },
          {
            "<LocalLeader>rs",
            function()
              require("r.run").action("str")
            end,
            desc = "Print Structure",
          },
          {
            "<LocalLeader>rS",
            function()
              require("r.run").action("summary")
            end,
            desc = "Summary",
          },
          {
            "<LocalLeader>rn",
            function()
              require("r.run").action("nvim.names")
            end,
            desc = "View Names",
          },
          {
            "<LocalLeader>rv",
            function()
              require("r.run").action("viewobj", "v")
            end,
            desc = "View DF",
          },
          {
            "<LocalLeader>rP",
            function()
              require("r.path").separate()
            end,
            desc = "Separate Path",
          },
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
              require("r.packages").install_missing_packages()
            end,
            desc = "Install Missing Packages",
          },
          {
            "<LocalLeader>rr",
            "<cmd>Roxygenize<CR>",
            desc = "Roxygenize",
          },
        })
      end,
    },
    R_args = { "--quiet", "--no-save" },
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
