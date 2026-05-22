vim.pack.add({ "https://github.com/lewis6991/gitsigns.nvim" })

require("gitsigns").setup({
  numhl = true,
  signs = {
    add = { text = "│" },
    change = { text = "│" },
    delete = { text = "" },
    topdelete = { text = "" },
    changedelete = { text = "│" },
    untracked = { text = "│" },
  },
  signs_staged = {
    add = { text = "│" },
    change = { text = "│" },
    delete = { text = "" },
    topdelete = { text = "" },
    changedelete = { text = "│" },
    untracked = { text = "│" },
  },
  on_attach = function(buffer)
    local gs = require("gitsigns")

    local function map(mode, l, r, desc)
      vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
    end
    -- general git
    map("n", "<leader>gb", function()
      Snacks.picker.git_branches({ cwd = vim.lsp.buf.list_workspace_folders()[1] })
    end, "Branchs")
    map("n", "<leader>gc", function()
      Snacks.picker.git_log({ cwd = vim.lsp.buf.list_workspace_folders()[1] })
    end, "Commit Log")
    map("n", "<leader>gs", function()
      Snacks.picker.git_status({ cwd = vim.lsp.buf.list_workspace_folders()[1] })
    end, "Git Status")
    map("n", "<leader>gf", function()
      Snacks.picker.git_log_file()
    end, "Git Log File")

    map("n", "<leader>gW", function()
      gs.blame()
    end, "Git Blame")

    Snacks.toggle({
      name = "Line Blame",
      get = function()
        return require("gitsigns.config").config.current_line_blame
      end,
      set = function(state)
        gs.toggle_current_line_blame(state)
      end,
    }):map("<leader>gL")
    Snacks.toggle({
      name = "Word Diff",
      get = function()
        return require("gitsigns.config").config.word_diff
      end,
      set = function(state)
        gs.toggle_word_diff(state)
      end,
    }):map("<leader>gw")
    Snacks.toggle({
      name = "Line Highlight",
      get = function()
        return require("gitsigns.config").config.linehl
      end,
      set = function(state)
        gs.toggle_linehl(state)
      end,
    }):map("<leader>gl")

    Snacks.toggle({
      name = "Number Highlight",
      get = function()
        return require("gitsigns.config").config.numhl
      end,
      set = function(state)
        gs.toggle_numhl(state)
      end,
    }):map("<leader>gn")

    -- hunks
    map("n", "]h", function()
      gs.nav_hunk("next")
    end, "Next Hunk")
    map("n", "]H", function()
      gs.nav_hunk("last")
    end, "Last Hunk")
    map("n", "[h", function()
      gs.nav_hunk("prev")
    end, "Prev Hunk")
    map("n", "[H", function()
      gs.nav_hunk("first")
    end, "First Hunk")
    map({ "n", "v" }, "<leader>ghs", gs.stage_hunk, "Stage Hunk")
    map({ "n", "v" }, "<leader>ghr", gs.reset_hunk, "Reset Hunk")
    map("n", "<leader>ghS", gs.stage_buffer, "Stage Buffer")
    map("n", "<leader>ghu", gs.undo_stage_hunk, "Undo Stage Hunk")
    map("n", "<leader>ghR", gs.reset_buffer, "Reset Buffer")
    map("n", "<leader>ghp", gs.preview_hunk, "Preview Hunk")
    map("n", "<leader>ghP", gs.preview_hunk_inline, "Preview Hunk Inline")
    map("n", "<leader>ghb", function()
      gs.blame_line({ full = true })
    end, "Blame Line")
    map({ "o", "x" }, "ih", gs.select_hunk, "GitSigns Select Hunk")
  end,
})
