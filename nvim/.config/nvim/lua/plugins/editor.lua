return {
  -- Key hinting
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      spec = {
        {
          { "<leader>b", group = "Buffer" },
          { "<leader>f", group = "Files" },
          { "<leader>g", group = "Git" },
          { "<leader>gh", group = "Hunks" },
          { "<leader>s", group = "Search" },
          { "<leader>u", group = "UI" },
          { "[", group = "Prev" },
          { "]", group = "Next" },
          { "g", group = "Goto" },
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
    },
  },

  -- Git signs in status column
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
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
          Snacks.picker.git_branches()
        end, "Branchs")
        map("n", "<leader>gc", function()
          Snacks.picker.git_log()
        end, "Commit Log")
        map("n", "<leader>gs", function()
          Snacks.picker.git_status()
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
    },
  },

  -- Location jumping and enhanced f/t
  {
    "folke/flash.nvim",
    opts = {},
    keys = {
      "f",
      "F",
      "t",
      "T",
      {
        "<Enter>",
        mode = { "n", "x", "o" },
        function()
          require("flash").jump()
        end,
        desc = "Flash",
      },
      {
        "<M-Enter>",
        mode = { "n", "x", "o" },
        function()
          require("flash").jump({
            search = { mode = "search" },
            label = { after = { 0, 0 } },
            pattern = "^",
          })
        end,
        desc = "Flash Lines",
      },
      {
        "<S-Enter>",
        mode = { "n", "o", "x" },
        function()
          require("flash").treesitter()
        end,
        desc = "Flash Treesitter",
      },
      {
        "r",
        mode = "o",
        function()
          require("flash").remote()
        end,
        desc = "Remote Flash",
      },
      {
        "R",
        mode = { "o", "x" },
        function()
          require("flash").treesitter_search({

            label = {
              rainbow = {
                enabled = true,
                shade = 5,
              },
            },
          })
        end,
        desc = "Treesitter Search",
      },
      {
        "<C-space>",
        mode = { "n", "o", "x" },
        function()
          require("flash").treesitter({
            actions = {
              ["<c-space>"] = "next",
              ["<BS>"] = "prev",
            },
          })
        end,
        desc = "Treesitter Incremental Seelction",
      },
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
        desc = "Dial Increment",
      },
      {
        "<C-x>",
        function()
          return require("dial.map").dec_normal()
        end,
        expr = true,
        desc = "Dial Decrement",
      },
      {
        "g<C-a>",
        function()
          return require("dial.map").inc_gnormal()
        end,
        expr = true,
        desc = "Dial Additive Increment",
      },
      {
        "g<C-x>",
        function()
          return require("dial.map").dec_gnormal()
        end,
        expr = true,
        desc = "Dial Additive Decrement",
      },

      {
        "<C-a>",
        function()
          return require("dial.map").inc_visual()
        end,
        mode = "v",
        expr = true,
        desc = "Dial Increment",
      },
      {
        "<C-x>",
        function()
          return require("dial.map").dec_visual()
        end,
        mode = "v",
        expr = true,
        desc = "Dial Decrement",
      },
      {
        "g<C-a>",
        function()
          return require("dial.map").inc_gvisual()
        end,
        mode = "v",
        expr = true,
        desc = "Dial Additive Increment",
      },
      {
        "g<C-x>",
        function()
          return require("dial.map").dec_gvisual()
        end,
        mode = "v",
        expr = true,
        desc = "Dial Additive Decrement",
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
    end,
  },

  -- Enhanced yank/put
  {
    "gbprod/yanky.nvim",
    dependencies = {
      "kkharji/sqlite.lua",
    },
    keys = {
      { mode = { "n", "x" }, "y", "<Plug>(YankyYank)", desc = "Yanky Yank" },
      { mode = { "n", "x" }, "p", "<Plug>(YankyPutAfter)", desc = "Yanky Put After" },
      { mode = { "n", "x" }, "P", "<Plug>(YankyPutBefore)", desc = "Yanky Put Before" },
      { "]p", "<Plug>(YankyPutAfterFilter)", desc = "Put After Filter" },
      { "[p", "<Plug>(YankyPutBeforeFilter)", desc = "Put Before Filter" },
      {
        "<leader>v",
        mode = { "n", "x" },
        function()
          Snacks.picker.yanky()
        end,
        desc = "Yank History",
      },
    },
    opts = {
      ring = {
        storage = "sqlite",
      },
    },
  },

  -- Enhanced substitute/exchange operator
  {
    "gbprod/substitute.nvim",
    keys = {
      {
        "s",
        function()
          require("substitute").operator()
        end,
        desc = "Substitute Operator",
      },
      {
        "ss",
        function()
          require("substitute").line()
        end,
        desc = "Substitute Line",
      },
      {
        "S",
        function()
          require("substitute").eol()
        end,
        desc = "Substitute EOL",
      },
      {
        mode = "x",
        "s",
        function()
          require("substitute").visual()
        end,
        desc = "Substitute Selection",
      },
      {
        "sx",
        function()
          require("substitute.exchange").operator()
        end,
        desc = "Exchange Operator",
      },
      {
        "sxx",
        function()
          require("substitute.exchange").line()
        end,
        desc = "Exchange Line",
      },
      {
        mode = "x",
        "sx",
        function()
          require("substitute.exchange").visual()
        end,
        desc = "Exchange",
      },
    },
    opts = {
      on_substitute = function()
        require("yanky.integration").substitute()
      end,
    },
  },

  -- More natural split navigation
  {
    "mrjones2014/smart-splits.nvim",
    event = "BufReadPost",
    keys = {
      -- swap buffers
      {
        "<leader>bh",
        function()
          require("smart-splits").swap_buf_left()
        end,
        desc = "Swap Left",
      },
      {
        "<leader>bj",
        function()
          require("smart-splits").swap_buf_down()
        end,
        desc = "Swap Down",
      },
      {
        "<leader>bk",
        function()
          require("smart-splits").swap_buf_up()
        end,
        desc = "Swap Up",
      },
      {
        "<leader>bl",
        function()
          require("smart-splits").swap_buf_right()
        end,
        desc = "Swap Right",
      },
      -- navigate buffers
      {
        "<leader>h",
        function()
          require("smart-splits").move_cursor_left()
        end,
        desc = "Move to Left Window",
      },
      {
        "<leader>j",
        function()
          require("smart-splits").move_cursor_down()
        end,
        desc = "Move to Lower Window",
      },
      {
        "<leader>k",
        function()
          require("smart-splits").move_cursor_up()
        end,
        desc = "Move to Upper Window",
      },
      {
        "<leader>l",
        function()
          require("smart-splits").move_cursor_right()
        end,
        desc = "Move to Right Window",
      },
      {
        "<M-Right>",
        mode = { "n", "i" },
        function()
          require("smart-splits").move_cursor_left()
        end,
        desc = "Move to Left Window",
      },
      {
        "<M-Down>",
        mode = { "n", "i" },
        function()
          require("smart-splits").move_cursor_down()
        end,
        desc = "Move to Lower Window",
      },
      {
        "<M-Up>",
        mode = { "n", "i" },
        function()
          require("smart-splits").move_cursor_up()
        end,
        desc = "Move to Upper Window",
      },
      {
        "<M-Left>",
        mode = { "n", "i" },
        function()
          require("smart-splits").move_cursor_right()
        end,
        desc = "Move to Right Window",
      },
      -- resize buffers
      {
        "<C-Left>",
        mode = { "n", "i" },
        function()
          require("smart-splits").resize_left()
        end,
        desc = "Resize Window Left",
      },
      {
        "<C-Down>",
        mode = { "n", "i" },
        function()
          require("smart-splits").resize_down()
        end,
        desc = "Resize  Window Down",
      },
      {
        "<C-Up>",
        mode = { "n", "i" },
        function()
          require("smart-splits").resize_up()
        end,
        desc = "Resize Window Up ",
      },
      {
        "<C-Right>",
        mode = { "n", "i" },
        function()
          require("smart-splits").resize_right()
        end,
        desc = "Resize Window Right",
      },
    },
    opts = {
      move_cursor_same_row = true,
      cursor_follows_swapped_bufs = true,
    },
  },

  -- Escape from surrounds
  {
    "kawre/neotab.nvim",
    event = "InsertEnter",
    opts = {},
  },

  -- Highlight csv column in rainbow colors
  {
    "hat0uma/csvview.nvim",
    ft = { "csv", "tsv" },
    cmd = { "CsvViewEnable", "CsvViewDisable", "CsvViewToggle" },
    keys = {
      {
        "<localleader>t",
        function()
          require("csvview").toggle()
        end,
        desc = "Toggle CSV View",
      },
    },
    opts = {
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
    },
    config = function(_, opts)
      require("csvview").setup(opts)
      require("csvview").enable()
    end,
  },

  -- autopairs
  {
    "saghen/blink.pairs",
    event = "BufReadPost",
    version = "*",
    dependencies = "saghen/blink.lib",
    opts = {
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
    },
  },
}
