vim.pack.add({
  "https://github.com/folke/which-key.nvim",
  "https://github.com/lewis6991/gitsigns.nvim",
  "https://github.com/saghen/blink.lib",
  { src = "https://github.com/saghen/blink.pairs", version = vim.version.range("*") },
  "https://github.com/kawre/neotab.nvim",
  "https://github.com/folke/flash.nvim",
  "https://github.com/monaqa/dial.nvim",
  "https://github.com/gbprod/yanky.nvim",
  "https://github.com/gbprod/substitute.nvim",
  "https://github.com/hat0uma/csvview.nvim",
})
-- Key hinting
require("which-key").setup({
  spec = {
    {
      { "<leader>b", group = "Buffer" },
      { "<leader>f", group = "Files" },
      { "<leader>g", group = "Git", mode = { "n", "x" } },
      { "<leader>gh", group = "Hunks", mode = { "n", "x" } },
      { "<leader>s", group = "Search", mode = { "n", "x" } },
      { "<leader>u", group = "UI" },
      { "[", group = "Prev" },
      { "]", group = "Next" },
      { "g", group = "Goto" },
      { "gr", group = "LSP Actions" },
      { "a", group = "Around", mode = { "o", "x" } },
      { "i", group = "Inside", mode = { "o", "x" } },
      { "<leader>c", group = "Code", mode = { "n", "v" } },
      { "<localleader>m", group = "Markdown" },
    },
  },
  icons = { rules = false },
  plugins = {
    marks = false,
    registers = false,
  },
  win = { wo = { winblend = 5 } },
  show_help = false,
})

-- Git signs in status column
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
  on_attach = function(buffer)
    local gs = package.loaded.gitsigns

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
      gs.nav_hunk("pre")
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

-- Flash.nvim
-- Location jumping and enhanced f/t
vim.api.nvim_create_autocmd("FileType", {
  pattern = "qf",
  callback = function()
    vim.keymap.set("n", "<CR>", "<CR>", { buffer = true })
  end,
})
vim.api.nvim_create_autocmd("CmdwinEnter", {
  pattern = "*",
  callback = function()
    vim.keymap.set("n", "<CR>", "<CR>", { buffer = true })
  end,
})

vim.keymap.set({ "n", "x", "o" }, "<Enter>", function()
  require("flash").jump()
end, { desc = "Flash" })
vim.keymap.set({ "n", "x", "o" }, "<M-Enter>", function()
  require("flash").jump({
    search = { mode = "search" },
    label = { after = { 0, 0 } },
    pattern = "^",
  })
end, { desc = "Flash Lines" })
vim.keymap.set("o", "r", function()
  require("flash").remote()
end, { desc = "Remote Flash" })
vim.keymap.set({ "n", "o", "x" }, "<C-space>", function()
  require("flash").treesitter({
    actions = {
      ["<c-space>"] = "next",
      ["<BS>"] = "prev",
    },
  })
end, { desc = "Treesitter Incremental Seelction" })

-- Better increment/decrement
local augend = require("dial.augend")
require("dial.config").augends:register_group({
  default = {
    augend.integer.alias.decimal,
    augend.integer.alias.hex,
    augend.date.alias["%Y/%m/%d"],
    augend.semver.alias.semver,
    augend.constant.new({
      elements = { "true", "false" },
      word = true,
      cyclic = true,
      preserve_case = true,
    }),
    augend.constant.new({
      elements = { "&&", "||" },
      word = false,
      cyclic = true,
    }),
    augend.date.new({
      pattern = "%Y_%m_%d",
      default_kind = "day",
      only_valid = true,
      word = false,
    }),
    augend.decimal_fraction.new({
      signed = false,
      point_char = ".",
    }),
    -- markdown
    augend.misc.alias.markdown_header,
    augend.constant.new({
      elements = { "[ ]", "[-]", "[x]" },
      word = false,
      cyclic = true,
    }),
    -- R
    augend.constant.new({
      elements = { "%>%", "|>" },
      word = false,
      cyclic = true,
    }),
    augend.constant.new({
      elements = { "&", "|" },
      word = false,
      cyclic = true,
    }),
    augend.constant.new({
      elements = { "==", "!=" },
      word = false,
      cyclic = true,
    }),
  },
})

vim.keymap.set("n", "<C-a>", function()
  return require("dial.map").inc_normal()
end, { expr = true, desc = "Dial Increment" })
vim.keymap.set("n", "<C-x>", function()
  return require("dial.map").dec_normal()
end, { expr = true, desc = "Dial Decrement" })
vim.keymap.set("n", "g<C-a>", function()
  return require("dial.map").inc_gnormal()
end, { expr = true, desc = "Dial Additive Increment" })
vim.keymap.set("n", "g<C-x>", function()
  return require("dial.map").dec_gnormal()
end, { expr = true, desc = "Dial Additive Decrement" })

-- Enhanced yank/put
require("yanky").setup()
vim.keymap.set({ "n", "x" }, "y", "<Plug>(YankyYank)", { desc = "Yanky Yank" })
vim.keymap.set({ "n", "x" }, "p", "<Plug>(YankyPutAfter)", { desc = "Yanky Put After" })
vim.keymap.set({ "n", "x" }, "P", "<Plug>(YankyPutBefore)", { desc = "Yanky Put Before" })
vim.keymap.set("n", "]p", "<Plug>(YankyPutAfterFilter)", { desc = "Put After Filter" })
vim.keymap.set("n", "[p", "<Plug>(YankyPutBeforeFilter)", { desc = "Put Before Filter" })
vim.keymap.set("n", "<leader>v", function()
  Snacks.picker.yanky()
end, { desc = "Yank History" })

-- Enhanced substitute/exchange operator
require("substitute").setup({
  on_substitute = function()
    require("yanky.integration").substitute()
  end,
})

vim.keymap.set("n", "s", function()
  require("substitute").operator()
end, { desc = "Substitute Operator" })
vim.keymap.set("n", "ss", function()
  require("substitute").line()
end, { desc = "Substitute Line" })
vim.keymap.set("n", "S", function()
  require("substitute").eol()
end, { desc = "Substitute EOL" })
vim.keymap.set("x", "s", function()
  require("substitute").visual()
end, { desc = "Substitute Selection" })
vim.keymap.set("n", "sx", function()
  require("substitute.exchange").operator()
end, { desc = "Exchange Operator" })
vim.keymap.set("n", "sxx", function()
  require("substitute.exchange").line()
end, { desc = "Exchange Line" })
vim.keymap.set("x", "sx", function()
  require("substitute.exchange").visual()
end, { desc = "Exchange" })

-- Escape from surrounds
require("neotab").setup()

-- Highlight csv column in rainbow colors
require("csvview").setup({
  parser = { comments = { "#", "//" } },
  keymaps = {
    -- Text objects for selecting fields
    textobject_field_inner = { "if", mode = { "o", "x" } },
    textobject_field_outer = { "af", mode = { "o", "x" } },

    jump_next_field_start = { "w", mode = { "n", "v" } },
    jump_prev_field_start = { "b", mode = { "n", "v" } },
  },
  view = {
    display_mode = "border",
  },
})

vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = {
    "csv",
    "tsv",
  },
  callback = function()
    vim.keymap.set("n", "<localleader>t", function()
      require("csvview").toggle()
    end, { desc = "Toggle CSV View", buf = 0 })
    require("csvview").enable()
  end,
})

-- autopairs
require("blink.pairs").setup({
  mappings = {
    cmdline = false,
    pairs = {
      ["<"] = { ">", languages = { "lua" } },
    },
  },
  highlights = {
    matchparen = {
      include_surrounding = true,
    },
  },
})
