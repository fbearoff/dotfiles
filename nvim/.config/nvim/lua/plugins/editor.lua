return {
  -- Key hinting
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      spec = {
        {
          { "<leader>b", group = "Buffer" },
          { "<leader>d", group = "Diagnostics" },
          { "<leader>f", group = "Files" },
          { "<leader>g", group = "Git" },
          { "<leader>gh", group = "Hunks" },
          { "<leader>s", group = "Search" },
          { "<leader>t", group = "Terminal" },
          { "<leader>u", group = "UI" },
          { "[", group = "Prev" },
          { "]", group = "Next" },
          { "g", group = "Goto" },
          { "<leader>c", group = "Code", mode = { "n", "v" } },
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

  -- Better diagnostics list
  {
    "folke/trouble.nvim",
    cmd = { "TroubleToggle", "Trouble" },
    opts = {
      use_diagnostic_signs = true,
    },
    keys = {
      { "<leader>dL", "<cmd>TroubleToggle loclist<cr>", desc = "Location List (Trouble)" },
      { "<leader>dQ", "<cmd>TroubleToggle quickfix<cr>", desc = "Quickfix List (Trouble)" },
      {
        "[q",
        function()
          if require("trouble").is_open() then
            require("trouble").previous({ skip_groups = true, jump = true })
          else
            local ok, err = pcall(vim.cmd.cprev)
            if not ok then
              vim.notify(err, vim.log.levels.ERROR)
            end
          end
        end,
        desc = "Previous trouble/quickfix item",
      },
      {
        "]q",
        function()
          if require("trouble").is_open() then
            require("trouble").next({ skip_groups = true, jump = true })
          else
            local ok, err = pcall(vim.cmd.cnext)
            if not ok then
              vim.notify(err, vim.log.levels.ERROR)
            end
          end
        end,
        desc = "Next trouble/quickfix item",
      },
    },
  },

  -- todo comments
  {
    "folke/todo-comments.nvim",
    cmd = { "TodoTrouble", "TodoTelescope" },
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      keywords = {
        CITE = { icon = "", color = "warning" },
      },
      highlight = {
        multiline = false,
      },
    },
    keys = {
      {
        "<localleader>t",
        "",
        desc = "+TODO Comments",
      },
      {
        "]t",
        function()
          require("todo-comments").jump_next()
        end,
        desc = "Next Todo Comment",
      },
      {
        "[t",
        function()
          require("todo-comments").jump_prev()
        end,
        desc = "Previous Todo Comment",
      },
      { "<leader>dt", "<cmd>TodoTrouble<cr>", desc = "Todo (Trouble)" },
      { "<leader>st", "<cmd>TodoTelescope<cr>", desc = "Todo" },
      { "<localleader>tt", "<cmd>lua require('Comment.api').insert.linewise.above()<cr>TODO: ", desc = "TODO" },
      { "<localleader>tn", "<cmd>lua require('Comment.api').insert.linewise.above()<cr>NOTE: ", desc = "NOTE" },
      { "<localleader>tf", "<cmd>lua require('Comment.api').insert.linewise.above()<cr>FIX: ", desc = "FIX" },
      {
        "<localleader>tc",
        function()
          require("util").cite()
        end,
        desc = "CITE",
      },
    },
  },

  -- Easy commenting
  {
    "numToStr/Comment.nvim",
    event = "BufReadPost",
    dependencies = {
      "JoosepAlviste/nvim-ts-context-commentstring",
      opts = function()
        vim.g.skip_ts_context_commentstring_module = true
        return { enable_autocmd = false }
      end,
    },
    opts = {
      pre_hook = function()
        require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook()
      end,
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
        map("n", "<leader>gb", "<cmd>Telescope git_branches<CR>", "Checkout Branch")
        map("n", "<leader>gc", "<cmd>Telescope git_commits<CR>", "Checkout Commit")
        map("n", "<leader>gs", "<cmd>Telescope git_status<CR>", "Git Status")
        map("n", "<leader>gl", gs.toggle_linehl, "Toggle Line Highlight")
        map("n", "<leader>gL", gs.toggle_current_line_blame, "Toggle Line Blame")
        map("n", "<leader>gw", gs.toggle_word_diff, "Toggle Word Diff")
        map("n", "<leader>gd", gs.diffthis, "Diff This")
        map("n", "<leader>gD", function()
          gs.diffthis("~")
        end, "Diff This ~")

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
        map({ "o", "x" }, "ig", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
      end,
    },
  },

  -- Marks in status column
  {
    "chentoast/marks.nvim",
    event = "BufReadPost",
    keys = {
      { "<leader>m", "", desc = "+Marks" },
      {
        "<leader>ms",
        function()
          require("marks").set()
        end,
        desc = "Set",
      },
      {
        "<leader>mn",
        function()
          require("marks").set_next()
        end,
        desc = "Set Next",
      },
      {
        "<leader>md",
        function()
          require("marks").delete_line()
        end,
        desc = "Delete Line",
      },
      {
        "<leader>mD",
        function()
          require("marks").delete_buf()
        end,
        desc = "Delete All",
      },
      {
        "<leader>mj",
        function()
          require("marks").next()
        end,
        desc = "Next",
      },
      {
        "<leader>mk",
        function()
          require("marks").prev()
        end,
        desc = "Previous",
      },
      {
        "<leader>mp",
        function()
          require("marks").preview()
        end,
        desc = "Preview",
      },
      {
        "<leader>mt",
        function()
          require("marks").toggle_signs()
        end,
        desc = "Toggle Signs",
      },
    },
    opts = {
      default_mappings = false,
      excluded_filetypes = { "lspinfo", "toggleterm" },
    },
  },

  -- Macro recording
  {
    "ecthelionvi/NeoComposer.nvim",
    dependencies = { "kkharji/sqlite.lua" },
    opts = function()
      local colors = require("kanagawa.colors").setup()
      return {
        colors = {
          bg = colors.theme.ui.bg_p1,
          fg = "#ff9e64",
          red = "#ec5f67",
          blue = "#5fb3b3",
          green = "#99c794",
        },
        keymaps = {
          cycle_next = "<m-n>",
          cycle_prev = "<m-p>",
        },
      }
    end,
    config = function(_, opts)
      require("NeoComposer").setup(opts)
      require("telescope").load_extension("macros")
    end,
  },

  -- Show color of color values
  {
    "NvChad/nvim-colorizer.lua",
    event = "BufReadPre",
    keys = { { "<leader>uC", "<cmd>ColorizerToggle<CR>", desc = "Toggle Colorizer" } },
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
        virtualtext = "⬤",
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
        "!rdoc",
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
        "<C-s>",
        mode = { "n", "x", "o" },
        function()
          require("flash").jump()
        end,
        desc = "Flash",
      },
      {
        "<M-s>",
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
        "<M-S>",
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
        "<c-s>",
        mode = { "c" },
        function()
          require("flash").toggle()
        end,
        desc = "Toggle Flash Search",
      },
    },
  },

  -- Better % matching
  {
    "andymass/vim-matchup",
    enabled = true,
    event = "BufReadPost",
    init = function()
      vim.o.matchpairs = "(:),{:},[:],<:>"
    end,
    config = function()
      vim.g.matchup_matchparen_deferred = 1
      vim.g.matchup_matchparen_offscreen = { method = "status_manual" }
    end,
  },

  -- Highlight outer brackets
  {
    "utilyre/sentiment.nvim",
    event = "BufReadPost",
    opts = {},
  },

  -- Auto insert matching pair character
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {
      check_ts = true,
      ts_config = {
        lua = { "string", "source", "comment" },
      },
      disable_filetype = { "TelescopePrompt", "spectre_panel" },
      -- enable_check_bracket_line = true,
      fast_wrap = {},
    },
    config = function(_, opts)
      local npairs = require("nvim-autopairs")
      npairs.setup(opts)
      local Rule = require("nvim-autopairs.rule")
      npairs.add_rule(Rule("<", ">", "lua"))
      require("cmp").event:on("confirm_done", require("nvim-autopairs.completion.cmp").on_confirm_done())
    end,
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
          augend.misc.alias.markdown_header,
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
      { "[y", "<Plug>(YankyCycleForward)", desc = "Yanky Cycle Forward" },
      { "]y", "<Plug>(YankyCycleBackward)", desc = "Yanky Cycle Backward" },
      { "]p", "<Plug>(YankyPutAfterFilter)", desc = "Put After Filter" },
      { "[p", "<Plug>(YankyPutBeforeFilter)", desc = "Put Before Filter" },
      {
        "<leader>v",
        function()
          require("telescope").extensions.yank_history.yank_history({})
        end,
        desc = "Yank History",
      },
    },
    opts = {
      highlight = {
        timer = 200,
      },
      preserve_cursor_position = {
        enabled = true,
      },
      ring = {
        storage = "sqlite",
      },
      system_clipboard = {
        sync_with_ring = true,
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

  -- references
  {
    "RRethy/vim-illuminate",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      delay = 200,
      large_file_cutoff = 2000,
      large_file_overrides = {
        providers = { "lsp" },
      },
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

      local function map(key, dir, buffer)
        vim.keymap.set("n", key, function()
          require("illuminate")["goto_" .. dir .. "_reference"]()
        end, { desc = dir:sub(1, 1):upper() .. dir:sub(2) .. " Reference", buffer = buffer })
      end

      map("]]", "next")
      map("[[", "prev")

      -- also set it after loading ftplugins, since a lot overwrite [[ and ]]
      vim.api.nvim_create_autocmd("FileType", {
        callback = function()
          local buffer = vim.api.nvim_get_current_buf()
          map("]]", "next", buffer)
          map("[[", "prev", buffer)
        end,
      })
    end,
    keys = {
      { "]]", desc = "Next Reference" },
      { "[[", desc = "Prev Reference" },
    },
  },

  -- More natural split navigation
  {
    "mrjones2014/smart-splits.nvim",
    event = "BufReadPost",
    keys = {
      {
        "<leader>br",
        function()
          require("smart-splits").start_resize_mode()
        end,
        desc = "Resize Windows",
      },
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

  -- Better text moving
  {
    "echasnovski/mini.move",
    event = "BufReadPre",
    keys = {
      { "<M-h>", mode = { "n", "x" } },
      { "<M-j>", mode = { "n", "x" } },
      { "<M-k>", mode = { "n", "x" } },
      { "<M-l>", mode = { "n", "x" } },
    },
    opts = {},
  },

  -- Folding
  {
    "kevinhwang91/nvim-ufo",
    dependencies = "kevinhwang91/promise-async",
    event = "BufReadPost",
    keys = {
      {
        "zR",
        function()
          require("ufo").openAllFolds()
        end,
        desc = "Open All Folds",
      },
      {
        "zr",
        function()
          require("ufo").openFoldsExceptKinds()
        end,
        desc = "Open Folds Except Kinds",
      },
      {
        "zM",
        function()
          require("ufo").closeAllFolds()
        end,
        desc = "Close All Folds",
      },
      {
        "zp",
        function()
          require("ufo").peekFoldedLinesUnderCursor()
        end,
        desc = "Peek Fold",
      },
      {
        "[z",
        function()
          require("ufo").goPreviousClosedFold()
        end,
        desc = "Previous Closed Fold",
      },
      {
        "]z",
        function()
          require("ufo").goNextClosedFold()
        end,
        desc = "Next Closed Fold",
      },
    },
    opts = {
      ---@diagnostic disable-next-line: unused-local
      provider_selector = function(bufnr, filetype, buftype)
        local ftMap = {
          markdown = { "treesitter" },
        }
        return ftMap[filetype]
      end,
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
    "cameron-wags/rainbow_csv.nvim",
    opts = function()
      vim.g.disable_rainbow_statusline = 1
      vim.g.disable_rainbow_hover = 1
      vim.g.disable_rainbow_key_mappings = 1
    end,
    ft = {
      "csv",
      "tsv",
    },
    keys = {
      {
        "<localleader>A",
        "<cmd>RainbowAlign<cr>",
        ft = { "csv", "tsv" },
        desc = "Align Columns",
      },
      {
        "<localleader>S",
        "<cmd>RainbowShrink<cr>",
        ft = { "csv", "tsv" },
        desc = "Shrink Columns",
      },
    },
  },

  -- navigation hints
  {
    "tris203/precognition.nvim",
    opts = {
      startVisible = false,
    },
    cmd = "Precognition",
    keys = {
      {
        "<leader>up",
        function()
          require("precognition").toggle()
        end,
        desc = "Toggle Precognition",
      },
      {
        "<leader>p",
        function()
          require("precognition").peek()
        end,
        desc = "Peek Precognition",
      },
    },
  },
}
