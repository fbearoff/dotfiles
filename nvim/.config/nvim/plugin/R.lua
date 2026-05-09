vim.pack.add({ "https://github.com/R-nvim/R.nvim" })
require("r").setup({
  hook = {
    on_filetype = function()
      vim.keymap.set("n", "<leader><Space>", function()
        require("r.send").line("move")
      end, { desc = "Send Line to R", buf = 0 })
      vim.keymap.set("x", "<leader><Space>", function()
        require("r.send").selection(true)
      end, { desc = "Send Selection to R", buf = 0 })
      vim.keymap.set("n", "<localleader>:", ":RSend ", { desc = "Send R Command", buf = 0 })
      vim.keymap.set("n", "<localleader>f", function()
        require("r.run").start_R("R")
      end, { desc = "Start R", buf = 0 })
      vim.keymap.set("n", "<localleader>o", function()
        require("r.browser").start()
      end, { desc = "Object Browser", buf = 0 })
      vim.keymap.set("n", "<localleader>q", function()
        require("r.run").quit_R("nosave")
      end, { desc = "Stop R", buf = 0 })
      vim.keymap.set("n", "<localleader>H", function()
        require("r.run").action("help")
      end, { desc = "R Help", buf = 0 })
      vim.keymap.set("n", "<localleader>p", function()
        require("r.run").action("print")
      end, { desc = "Print Object", buf = 0 })
      vim.keymap.set("n", "<localleader>s", function()
        require("r.run").action("str")
      end, { desc = "Print Structure", buf = 0 })
      vim.keymap.set("n", "<localleader>S", function()
        require("r.run").action("summary")
      end, { desc = "Summary", buf = 0 })
      vim.keymap.set("n", "<localleader>n", function()
        require("r.run").action("nvim.names")
      end, { desc = "View Names", buf = 0 })
      vim.keymap.set("n", "<localleader>v", function()
        require("r.run").action("viewobj")
      end, { desc = "View DF", buf = 0 })
      vim.keymap.set("n", "<localleader>P", function()
        require("r.path").separate()
      end, { desc = "Separate Path", buf = 0 })
      vim.keymap.set("n", "<localleader>g", function()
        require("r.run").action("glimpse")
      end, { desc = "Glimpse", buf = 0 })
      vim.keymap.set("n", "<localleader>c", function()
        require("r.run").action("class")
      end, { desc = "View Class", buf = 0 })
      vim.keymap.set("n", "<localleader>l", function()
        require("r.run").action("levels")
      end, { desc = "View Levels", buf = 0 })
      vim.keymap.set("n", "<localleader>h", function()
        require("r.run").action("head")
      end, { desc = "View Head", buf = 0 })
      vim.keymap.set("n", "<localleader>t", function()
        require("r.run").action("tail")
      end, { desc = "View Tail", buf = 0 })
      vim.keymap.set(
        "n",
        "<localleader>u",
        "<cmd>RSend update.packages(checkBuilt = TRUE, ask = FALSE)<CR>",
        { desc = "Update Packages", buf = 0 }
      )
      vim.keymap.set(
        "n",
        "<localleader>U",
        "<cmd>RSend BiocManager::install()<CR>",
        { desc = "Update Bioconductor Packages", buf = 0 }
      )
      vim.keymap.set("n", "<localleader>i", function()
        require("r.packages").install_missing_packages()
      end, { desc = "Install Missing Packages", buf = 0 })
      vim.keymap.set("n", "<localleader>R", "<cmd>Roxygenize<CR>", { desc = "Roxygenize", buf = 0 })
      vim.keymap.set(
        "n",
        "<localleader>G",
        "<cmd>RSend httpgd::hgd(); httpgd::hgd_browse()<CR>",
        { desc = "Start httpgd", buf = 0 }
      )
      vim.keymap.set(
        "n",
        "<localleader>r",
        "<cmd>RSend shiny::runApp('app.R')<CR>",
        { desc = "Start Shiny App", buf = 0 }
      )
      vim.keymap.set("n", "<localleader>Q", "<cmd>RStop<CR>", { desc = "Stop R Command", buf = 0 })
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
  view_df = {
    open_app = ":split",
  },
  hl_term = false,
  setwd = "file",
  user_maps_only = true,
})
