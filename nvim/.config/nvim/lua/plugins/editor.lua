return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      plugins = {
        marks = false,
        registers = false,
        spelling = true,
      },
      key_labels = {
        ["<leader>"] = "SPC",
        ["<space>"] = "SPC"
      },
      window = { winblend = 5 },
      layout = { align = "center" },
      show_help = false,
    },
    config = function(_, opts)
      local wk = require("which-key")
      wk.setup(opts)
      wk.register({
        ["g"] = { name = "+Goto" },
        ["]"] = { name = "+Next" },
        ["["] = { name = "+Prev" },
        ["<leader>b"] = { name = "+Buffer" },
        ["<leader>c"] = { name = "+Code", mode = { "n", "v" }, },
        ["<leader>d"] = { name = "+Diagnostics" },
        ["<leader>g"] = { name = "+Git" },
        ["<leader>gh"] = { name = "+Hunks" },
        ["<leader>n"] = { name = "+Noice" },
        ["<leader>o"] = { name = "+Options" },
        ["<leader>s"] = { name = "+Search" },
        ["<leader>t"] = { name = "+Terminal" },
        ["<leader>u"] = { name = "+UI" },
        ["<localleader>M"] = { name = "+Markdown" },
        ["<localleader>R"] = { name = "+R" },
      })
    end,
  },

  {
    "lewis6991/gitsigns.nvim",
    event = "BufReadPre",
    opts = {
      signs = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "契" },
        topdelete = { text = "契" },
        changedelete = { text = "▎" },
        untracked = { text = "▎" },
      },
      on_attach = function(buffer)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, desc)
          vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
        end

        -- general git
        map("n", "<leader>gb", "<cmd>Telescope git_branches<CR>", "Checkout Branch")
        map("n", "<leader>gc", "<cmd>Telescope git_commits<CR>", "Checkout Commit")
        map("n", "<leader>gs", "<cmd>Telescope git_status<CR>", "Git Status")
        map("n", "<leader>gl", gs.toggle_linehl, "Toggle Line Highlight")
        map("n", "<leader>gL", gs.toggle_current_line_blame, "Toggle Line Blame")
        map("n", "<leader>gw", gs.toggle_word_diff, "Toggle Word Diff")
        map("n", "<leader>gd", gs.diffthis, "Diff This")
        map("n", "<leader>gD", function() gs.diffthis("~") end, "Diff This ~")

        -- hunks
        map("n", "]h", gs.next_hunk, "Next Hunk")
        map("n", "[h", gs.prev_hunk, "Prev Hunk")
        map({ "n", "v" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
        map({ "n", "v" }, "<leader>ghr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
        map("n", "<leader>ghS", gs.stage_buffer, "Stage Buffer")
        map("n", "<leader>ghu", gs.undo_stage_hunk, "Undo Stage Hunk")
        map("n", "<leader>ghR", gs.reset_buffer, "Reset Buffer")
        map("n", "<leader>ghp", gs.preview_hunk, "Preview Hunk")
        map("n", "<leader>ghb", function() gs.blame_line({ full = true }) end, "Blame Line")
        map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
      end,
    },
  },

  {
    "cbochs/grapple.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    keys = {
      { "<leader>!", function() require('grapple').toggle() end, desc = "Grapple Toggle" },
      { "<leader><tab>", function() require('grapple').cycle_backwards() end, desc = "Grapple Cycle" },
      { "<leader>bg", function() require('grapple').popup_tags() end, desc = "Grapple Tags" },
    },
  },

  {
    "NvChad/nvim-colorizer.lua",
    event = "BufReadPre",
    keys = { { "<leader>oC", "<cmd>ColorizerToggle<CR>", desc = "Toggle Colorizer" } },
    opts = {
      user_default_options = {
        RGB = true, -- #RGB hex codes
        RRGGBB = true, -- #RRGGBB hex codes
        names = false, -- "Name" codes like Blue
        RRGGBBAA = true, -- #RRGGBBAA hex codes
        AARRGGBB = false, -- 0xAARRGGBB hex codes
        rgb_fn = false, -- CSS rgb() and rgba() functions
        hsl_fn = false, -- CSS hsl() and hsla() functions
        css = false, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
        css_fn = false, -- Enable all CSS *functions*: rgb_fn, hsl_fn
        mode = "virtualtext",
        virtualtext = "⬤"
      },
      filetypes = {
        "*",
        "!dirvish",
        "!fugitive",
        "!alpha",
        "!NvimTree",
        "!Lazy",
        "!Trouble",
        "!lir",
        "!Outline",
        "!spectre_panel",
        "!toggleterm",
        "!DressingSelect",
        "!TelescopePrompt",
        "!rbrowser",
        "!rdoc"
      },
      -- all the sub-options of filetypes apply to buftypes
      buftypes = {
        "!nofile",
        "!prompt",
        "!popup",
        "!scratch",
        "!unlisted",
      },
    },
  },

  {
    "andymass/vim-matchup",
    event = "BufReadPost",
    config = function()
      vim.g.matchup_matchparen_offscreen = { method = "status_manual" }
    end,
  },

  {
    "gorbit99/codewindow.nvim",
    config = true,
    keys = {
      { "<leader>cm",
        function()
          require('codewindow').toggle_minimap()
        end,
        desc = "Toggle Minimap" },
    },
  },
}
