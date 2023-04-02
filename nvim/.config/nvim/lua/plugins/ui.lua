return {

  -- Notification provider
  {
    "rcarriga/nvim-notify",
    keys = {
      {
        "<leader>nc",
        function()
          require("notify").dismiss({ silent = true, pending = true })
        end,
        desc = "Clear all Notifications",
      },
    },
    opts = {
      timeout = 0,
      render = "minimal",
      max_height = function()
        return math.floor(vim.o.lines * 0.75)
      end,
      max_width = function()
        return math.floor(vim.o.columns * 0.75)
      end,
    },
  },

  -- Fancy UI elements
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    keys = {
      {
        "<S-Enter>",
        function()
          require("noice").redirect(vim.fn.getcmdline())
        end,
        mode = "c",
        desc = "Redirect Cmdline",
      },
      {
        "<leader>nl",
        function()
          require("noice").cmd("last")
        end,
        desc = "Noice Last Message",
      },
      {
        "<leader>nh",
        function()
          require("noice").cmd("history")
        end,
        desc = "Noice History",
      },
      {
        "<leader>na",
        function()
          require("noice").cmd("all")
        end,
        desc = "Noice All",
      },
      {
        "<leader>nm",
        "<cmd>messages<cr>",
        desc = "Messages",
      },
      {
        "<c-f>",
        function()
          if not require("noice.lsp").scroll(4) then
            return "<c-f>"
          end
        end,
        silent = true,
        expr = true,
        desc = "Scroll forward",
        mode = { "i", "n", "s" },
      },
      {
        "<c-b>",
        function()
          if not require("noice.lsp").scroll(-4) then
            return "<c-b>"
          end
        end,
        silent = true,
        expr = true,
        desc = "Scroll backward",
        mode = { "i", "n", "s" },
      },
    },
    opts = {
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
        progress = {
          enabled = true,
        },
      },
      presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
        inc_rename = true,
        lsp_doc_border = true,
      },
      routes = {
        {
          filter = {
            event = "msg_show",
            find = "%d+L, %d+B",
          },
          view = "mini",
        },
        {
          filter = {
            event = "msg_show",
            kind = "search_count",
          },
          opts = { skip = true },
        },
        { -- filter annoying buffer messages
          filter = {
            event = "msg_show",
            kind = "",
            any = {
              { find = "written" },
              { find = "line less" },
              { find = "fewer lines" },
              { find = "more line" },
              { find = "change; before" },
              { find = "change; after" },
            },
          },
          opts = { skip = true },
        },
        {
          filter = {
            event = "notify",
            find = "No node found at cursor",
          },
          opts = { skip = true },
        },
        {
          filter = {
            event = "lsp",
            kind = "progress",
            find = "code_action",
          },
          opts = { skip = true },
        },
      },
    },
  },

  -- UI to rename items incrementally
  {
    "smjonas/inc-rename.nvim",
    cmd = "IncRename",
    opts = {},
  },

  -- Scrollbar
  {
    "lewis6991/satellite.nvim",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      current_only = true,
      excluded_filetypes = {
        "prompt",
        "TelescopePrompt",
        "noice",
        "notify",
      },
      width = 1,
      handlers = {
        marks = {
          enable = false,
        },
      },
    },
  },

  -- Floating filename
  {
    "b0o/incline.nvim",
    event = "BufReadPre",
    opts = function()
      local colors = require("kanagawa.colors").setup()
      return {
        highlight = {
          groups = {
            InclineNormal = {
              guibg = colors.theme.ui.bg,
              guifg = colors.theme.ui.fg,
              gui = "bold",
            },
            InclineNormalNC = {
              guifg = colors.theme.ui.fg,
              guibg = colors.theme.ui.bg_dim,
            },
          },
        },
        window = {
          margin = {
            vertical = 0,
            horizontal = 1,
          },
        },
        render = function(props)
          local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
          local icon, color = require("nvim-web-devicons").get_icon_color(filename)
          return { { icon, guifg = color }, { " " }, { filename } }
        end,
      }
    end,
  },

  -- Fancy select and input dialogs
  {
    "stevearc/dressing.nvim",
    init = function()
      vim.ui.select = function(...)
        ---@diagnostic disable-next-line: different-requires
        require("lazy").load({ plugins = { "dressing.nvim" } })
        return vim.ui.select(...)
      end
      vim.ui.input = function(...)
        ---@diagnostic disable-next-line: different-requires
        require("lazy").load({ plugins = { "dressing.nvim" } })
        return vim.ui.input(...)
      end
    end,
  },

  -- Show code context
  {
    "SmiteshP/nvim-navic",
    opts = {
      separator = " ",
      highlight = true,
      depth_limit = 5,
      icons = require("config.icons").kinds,
      safe_output = true,
      lsp = {
        auto_attach = true,
      },
    },
  },

  -- Show available code actions as lightbulb character
  {
    "kosayoda/nvim-lightbulb",
    opts = {
      autocmd = {
        enabled = true,
      },
      sign = {
        enabled = false,
      },
      status_text = {
        enabled = true,
      },
    },
    event = "BufReadPost",
  },

  -- Clickable status column items
  {
    "luukvbaal/statuscol.nvim",
    event = "BufReadPost",
    opts = function()
      local builtin = require("statuscol.builtin")
      return {
        relculright = true,
        ft_ignore = { "query" },
        bt_ignore = { "terminal", "nofile" },
        segments = {
          -- GitSigns
          {
            sign = {
              name = { "Git*" },
              maxwidth = 1,
              auto = true,
            },
            click = "v:lua.ScSa",
          },
          -- Todo Comments
          {
            sign = {
              name = { "todo*" },
              maxwidth = 1,
              auto = true,
            },
            condition = {
              function(args)
                return vim.api.nvim_get_current_win() == args.win
              end,
            },
          },
          -- Marks signs
          {
            sign = {
              name = { "Marks*" },
              maxwidth = 1,
            },
            condition = {
              function(args)
                return vim.api.nvim_get_current_win() == args.win
              end,
            },
          },
          -- line numbers
          {
            text = { builtin.lnumfunc },
            click = "v:lua.ScLa",
          },
          -- folds
          {
            text = { " ", builtin.foldfunc },
            condition = {
              builtin.not_empty,
              function(args)
                return vim.api.nvim_get_current_win() == args.win
              end,
            },
            click = "v:lua.ScFa",
          },
          -- Diagnostic signs
          {
            sign = {
              name = { "Diagnostic" },
              maxwidth = 1,
              auto = true,
            },
            click = "v:lua.ScSa",
            condition = { true },
          },
        },
      }
    end,
  },

  -- Indent guides
  {
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      char = "│",
      filetype_exclude = { "help", "alpha", "dashboard", "neo-tree", "NvimTree", "Trouble", "lazy", "lspinfo" },
      show_trailing_blankline_indent = false,
      show_current_context = false,
      buftype_exclude = { "terminal", "nofile" },
    },
  },

  -- active indent guide and indent text objects
  {
    "echasnovski/mini.indentscope",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      symbol = "│",
      options = { try_as_border = false },
    },
    config = function(_, opts)
      vim.api.nvim_create_autocmd("FileType", {
        pattern = {
          "help",
          "alpha",
          "dashboard",
          "neo-tree",
          "NvimTree",
          "Trouble",
          "lazy",
          "mason",
          "noice",
          "rdoc",
          "terminal",
          "checkhealth",
          "lspinfo",
          "query",
        },
        callback = function()
          vim.b.miniindentscope_disable = true
        end,
      })
      require("mini.indentscope").setup(opts)
    end,
  },

  -- Bufferline
  {
    "romgrk/barbar.nvim",
    event = "VeryLazy",
    keys = {
      { "<M-,>", "<cmd>BufferPrevious<CR>", desc = "Previous Buffer" },
      { "<M-.>", "<cmd>BufferNext<CR>", desc = "Next Buffer" },
      { "]b", "<cmd>bnext<CR>", desc = "Next Buffer" },
      { "[b", "<cmd>bprevious<CR>", desc = "Previous Buffer" },
      { "<leader>bc", "<cmd>BufferClose!<CR>", desc = "Close Buffer" },
      { "<leader>be", "<cmd>BufferCloseAllButCurrent<CR>", desc = "Close All But Current Buffer" },
      { "<M-<>", "<cmd>BufferMovePrevious<CR>", desc = "Move Buffer Left" },
      { "<M->>", "<cmd>BufferMoveNext<CR>", desc = "Move Buffer Right" },
      { "<M-1>", "<cmd>BufferGoto 1<CR>", desc = "Buffer 1" },
      { "<M-2>", "<cmd>BufferGoto 2<CR>", desc = "Buffer 2" },
      { "<M-3>", "<cmd>BufferGoto 3<CR>", desc = "Buffer 3" },
      { "<M-4>", "<cmd>BufferGoto 4<CR>", desc = "Buffer 4" },
      { "<M-5>", "<cmd>BufferGoto 5<CR>", desc = "Buffer 5" },
      { "<M-6>", "<cmd>BufferGoto 6<CR>", desc = "Buffer 6" },
      { "<M-7>", "<cmd>BufferGoto 7<CR>", desc = "Buffer 7" },
      { "<M-8>", "<cmd>BufferGoto 8<CR>", desc = "Buffer 8" },
      { "<M-9>", "<cmd>BufferGoto 9<CR>", desc = "Buffer 9" },
      { "<M-0>", "<cmd>BufferLast<CR>", desc = "Last Buffer" },
      { "<M-c>", "<cmd>BufferClose<CR>", desc = "Close Buffer" },
    },
    opts = {
      sidebar_filetypes = {
        NvimTree = { text = "NvimTree" },
      },
      tabpages = false,
      icons = {
        buffer_index = true,
        diagnostics = {
          [vim.diagnostic.severity.ERROR] = { enabled = true, icon = " " },
        },
      },
      highlight_visible = false,
      maximum_padding = 1,
    },
  },

  -- Dashboard
  {
    "goolord/alpha-nvim",
    event = "VimEnter",
    opts = function()
      local dashboard = require("alpha.themes.dashboard")
      local logo = [[
       ___       __   ___  ___  ________  _________       ___  ___  ________  ___  ___  ___
      |\  \     |\  \|\  \|\  \|\   __  \|\___   ___\    |\  \|\  \|\   __  \|\  \|\  \|\  \
      \ \  \    \ \  \ \  \\\  \ \  \|\  \|___ \  \_|    \ \  \\\  \ \  \|\  \ \  \ \  \ \  \
       \ \  \  __\ \  \ \   __  \ \   __  \   \ \  \      \ \  \\\  \ \   ____\ \  \ \  \ \  \
        \ \  \|\__\_\  \ \  \ \  \ \  \ \  \   \ \  \      \ \  \\\  \ \  \___|\ \__\ \__\ \__\
         \ \____________\ \__\ \__\ \__\ \__\   \ \__\      \ \_______\ \__\    \|__|\|__|\|__|
          \|____________|\|__|\|__|\|__|\|__|    \|__|       \|_______|\|__|        ___  ___  ___
                                                                                   |\__\|\__\|\__\
                                                                                   \|__|\|__|\|__|
   ]]

      dashboard.section.header.val = vim.split(logo, "\n")
      dashboard.section.buttons.val = {
        dashboard.button("f", " " .. " Find file", ":Telescope find_files <CR>"),
        dashboard.button("e", " " .. " New file", ":ene <BAR> startinsert <CR>"),
        dashboard.button("r", " " .. " Recent files", ":Telescope oldfiles <CR>"),
        dashboard.button("t", " " .. " Find text", ":Telescope live_grep <CR>"),
        dashboard.button("c", " " .. " Config", ":e $MYVIMRC <CR>"),
        dashboard.button("p", " " .. " Open Project", ":Telescope projects<CR>"),
        dashboard.button("l", "󰒲 " .. " Lazy", ":Lazy<CR>"),
        dashboard.button("q", " " .. " Quit", ":qa<CR>"),
      }
      for _, button in ipairs(dashboard.section.buttons.val) do
        button.opts.hl = "Type"
        button.opts.hl_shortcut = "Constant"
      end
      dashboard.section.footer.opts.hl = "Function"
      dashboard.section.header.opts.hl = "Keyword"
      dashboard.section.buttons.opts.hl = "Type"
      dashboard.opts.layout[1].val = 8
      return dashboard
    end,
    config = function(_, dashboard)
      -- close Lazy and re-open when the dashboard is ready
      if vim.o.filetype == "lazy" then
        vim.cmd.close()
        vim.api.nvim_create_autocmd("User", {
          pattern = "AlphaReady",
          callback = function()
            ---@diagnostic disable-next-line: different-requires
            require("lazy").show()
          end,
        })
      end

      require("alpha").setup(dashboard.opts)

      vim.api.nvim_create_autocmd("User", {
        pattern = "LazyVimStarted",
        callback = function()
          ---@diagnostic disable-next-line: different-requires
          local stats = require("lazy").stats()
          local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
          dashboard.section.footer.val = "💪 Neovim loaded " .. stats.count .. " plugins in " .. ms .. "ms 💪"
          pcall(vim.cmd.AlphaRedraw)
        end,
      })
    end,
  },

  -- icons
  "nvim-tree/nvim-web-devicons",

  -- ui components
  "MunifTanjim/nui.nvim",
}
