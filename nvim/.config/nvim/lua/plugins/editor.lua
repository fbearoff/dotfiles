return {
  -- Key hinting
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

  -- Easy commenting
  {
    "numToStr/Comment.nvim",
    keys = { { "gc", mode = { "n", "v" } },
      "gcc",
      "gbc" },
    dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" },
    config = function()
      require("Comment").setup({
        pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
      })
    end
  },

  -- Git signs in status column
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

  -- Marks in status column
  {
    "chentoast/marks.nvim",
    event = "BufReadPost",
    opts = {
      default_mappings = false,
      builtin_marks = false,
      excluded_filetypes = { "lspinfo", "toggleterm" },
      mappings = {
        set_next = "m,",
        delete_line = "dm",
        next = "mj",
        prev = "mk",
      },
    },
  },

  -- Macro recording
  {
    "chrisgrieser/nvim-recorder",
    lazy = false,
    config = function()
      require("recorder").setup({})
    end,
  },

  -- Quick tagged file switching
  {
    "cbochs/grapple.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    keys = {
      { "<leader>!", function() require('grapple').toggle() end, desc = "Grapple Toggle" },
      { "<leader><tab>", function() require('grapple').cycle_backwards() end, desc = "Grapple Cycle" },
      { "<leader>bg", function() require('grapple').popup_tags() end, desc = "Grapple Tags" },
    },
  },

  -- Show color of color values
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

  -- Better % matching
  {
    "andymass/vim-matchup",
    event = "BufReadPost",
    config = function()
      vim.g.matchup_matchparen_offscreen = { method = "status_manual" }
    end,
  },

  -- Auto insert matching pair character
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("nvim-autopairs").setup({
        check_ts = true,
        ts_config = {
          lua = { "string", "source", "comment" },
        },
        disable_filetype = { "TelescopePrompt", "spectre_panel" },
        fast_wrap = {},
      })
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      ---@diagnostic disable-next-line: undefined-field
      require("cmp").event:on(
        "confirm_done",
        cmp_autopairs.on_confirm_done()
      )
    end
  },
  -- Code minimap
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

  -- Better increment/decrement
  {
    "monaqa/dial.nvim",
    keys = {
      {
        "<C-a>",
        function()
          return require("dial.map").inc_normal()
        end,
        expr = true,
      },
      {
        "<C-x>",
        function()
          return require("dial.map").dec_normal()
        end,
        expr = true,
      },
    },
    config = function()
      local augend = require("dial.augend")
      require("dial.config").augends:register_group({
        default = {
          augend.integer.alias.decimal,
          augend.integer.alias.hex,
          augend.date.alias["%Y/%m/%d"],
          augend.semver.alias.semver,
          augend.constant.new {
            elements = { "true", "false" },
            word = true,
            cyclic = true,
            preserve_case = true
          },
          augend.constant.new {
            elements = { "&&", "||" },
            word = false,
            cyclic = true,
          },
          augend.date.new {
            pattern = "%Y_%m_%d",
            default_kind = "day",
            only_valid = true,
            word = false,
          },
        },
      })
    end
  },

  -- Enhanced yank/put
  {
    "gbprod/yanky.nvim",
    event = "BufReadPost",
    dependencies = {
      "kkharji/sqlite.lua",
    },
    keys = {
      { mode = { "n", "x" }, "y", "<Plug>(YankyYank)", desc = "Yanky Yank" },
      { mode = { "n", "x" }, "p", "<Plug>(YankyPutAfter)", desc = "Yanky Put After" },
      { mode = { "n", "x" }, "P", "<Plug>(YankyPutBefore)", desc = "Yanky Put Before" },
      { "<c-n>", "<Plug>(YankyCycleForward)", desc = "Yanky Cycle Forward" },
      { "<c-p>", "<Plug>(YankyCycleBackward)", desc = "Yanky Cycle Backward" },
      { "]p", "<Plug>(YankyPutAfterFilter)", desc = "Put After Filter" },
      { "[p", "<Plug>(YankyPutBeforeFilter)", desc = "Put Before Filter" },
      { "<leader>v", function()
        require("telescope").extensions.yank_history.yank_history({})
      end, desc = "Yank History" },
    },
    opts = {
      highlight = {
        on_put = false,
        on_yank = false,
        timer = 150,
      },
      preserve_cursor_position = {
        enabled = true,
      },
      ring = {
        storage = "sqlite",
      },
    }
  },

  -- Enhanced substitute/exchange operator
  {
    "gbprod/substitute.nvim",
    keys = {
      { "<M-s>",
        function()
          require('substitute').operator()
        end,
        desc = "Substitute Operator" },
      { mode = "x", "<M-s>",
        function()
          require('substitute').visual()
        end,
        desc = "Substitute Selection" },
      { "<M-x>",
        function()
          require('substitute.exchange').operator()
        end,
        desc = "Exchange Operator" },
      { mode = "x", "<M-x>",
        function()
          require('substitute.exchange').visual()
        end,
        desc = "Exchange Word" },
    },
    opts = {
      on_substitute = nil,
      yank_substituted_text = false,
      exchange = {
        motion = "iw",
        use_esc_to_cancel = true,
      },
    },
  },

  -- references
  {
    "RRethy/vim-illuminate",
    event = "BufReadPost",
    opts = {
      delay = 200,
      filetypes_denylist = {
        "dirvish",
        "fugitive",
        "alpha",
        "NvimTree",
        "Trouble",
        "lir",
        "Outline",
        "spectre_panel",
        "toggleterm",
        "DressingSelect",
        "TelescopePrompt",
      },
    },
    config = function(_, opts)
      require("illuminate").configure(opts)
    end,
    keys = {
      { "]]", function() require("illuminate").goto_next_reference(false) end, desc = "Next Reference", },
      { "[[", function() require("illuminate").goto_prev_reference(false) end, desc = "Prev Reference" },
    },
  },

  -- More natural split navigation
  {
    "mrjones2014/smart-splits.nvim",
    event = "BufReadPost",
    keys = {
      { "<M-h>", mode = { "n", "i" }, function() require('smart-splits').move_cursor_left() end,
        desc = "Move to Left Window" },
      { "<M-j>", mode = { "n", "i" }, function() require('smart-splits').move_cursor_down() end,
        desc = "Move to Lower Window" },
      { "<M-k>", mode = { "n", "i" }, function() require('smart-splits').move_cursor_up() end,
        desc = "Move to Upper Window" },
      { "<M-l>", mode = { "n", "i" }, function() require('smart-splits').move_cursor_right() end,
        desc = "Move to Right Window" },
      { "<C-Left>", mode = { "n", "i" }, function() require('smart-splits').resize_left() end,
        desc = "Resize Window Left" },
      { "<C-Down>", mode = { "n", "i" }, function() require('smart-splits').resize_down() end,
        desc = "Resize  Window Down" },
      { "<C-Up>", mode = { "n", "i" }, function() require('smart-splits').resize_up() end,
        desc = "Resize Window Up " },
      { "<C-Right>", mode = { "n", "i" }, function() require('smart-splits').resize_right() end,
        desc = "Resize Window Right" },
    },
    opts = {
      ignored_filetypes = {
        'nofile',
        'quickfix',
        'prompt',
      },
      ignored_buftypes = { 'NvimTree' },
      move_cursor_same_row = true,
    },
  }
}
