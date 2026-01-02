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
              require("r.send").line("move")
            end,
            desc = "Send Line to R",
          },
          {
            mode = "x",
            "<leader><Space>",
            function()
              require("r.send").selection(true)
            end,
            desc = "Send Selection to R",
          },
          {
            "<LocalLeader>r:",
            ":RSend ",
            desc = "Send R Command",
          },
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
              require("r.run").action("viewobj")
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
            "<LocalLeader>rR",
            "<cmd>Roxygenize<CR>",
            desc = "Roxygenize",
          },
          {
            "<LocalLeader>rG",
            "<cmd>RSend httpgd::hgd(); httpgd::hgd_browse()<CR>",
            desc = "Start httpgd",
          },
          {
            "<LocalLeader>rr",
            "<cmd>RSend shiny::runApp('app.R')<CR>",
            desc = "Start Shiny App",
          },
          {
            "<LocalLeader>rQ",
            "<cmd>RStop<CR>",
            desc = "Stop R Command",
          },
        })
        -- auto align output from RViewDF
        vim.api.nvim_create_autocmd("BufReadPost", {
          desc = "Align TSV output from R.nvim",
          group = vim.api.nvim_create_augroup("CsvView", { clear = true }),
          callback = function(opts)
            if vim.bo[opts.buf].filetype == "tsv" then
              vim.cmd("CsvViewToggle")
              vim.keymap.set("n", "q", "<cmd>bd<cr>", { buffer = opts.buf, silent = true })
            end
          end,
        })
      end,
    },
    R_args = { "--quiet", "--no-save" },
    bracketed_paste = true,
    clear_console = false,
    clear_line = true,
    view_df = {
      open_app = ":split",
    },
    esc_term = true,
    hl_term = false,
    source_args = "echo = TRUE, spaced = TRUE",
    specialplot = true,
    setwd = "file",
    user_maps_only = true,
  },
}
