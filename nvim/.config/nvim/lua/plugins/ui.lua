return {

  { "ellisonleao/gruvbox.nvim" },

  -- Notification provider
  { "rcarriga/nvim-notify",
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
      { "<S-Enter>", function() require("noice").redirect(vim.fn.getcmdline()) end, mode = "c", desc = "Redirect Cmdline" },
      { "<leader>nl", function() require("noice").cmd("last") end, desc = "Noice Last Message" },
      { "<leader>nh", function() require("noice").cmd("history") end, desc = "Noice History" },
      { "<leader>na", function() require("noice").cmd("all") end, desc = "Noice All" },
      { "<c-f>", function() if not require("noice.lsp").scroll(4) then return "<c-f>" end end, silent = true, expr = true,
        desc = "Scroll forward" },
      { "<c-b>", function() if not require("noice.lsp").scroll(-4) then return "<c-b>" end end, silent = true,
        expr = true, desc = "Scroll backward" },
    },
    opts = {
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
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
          {
            filter = {
              event = "msg_show",
              kind = "search_count",
            },
            opts = { skip = true },
          },
          filter = {
            event = "msg_show",
            kind = "search_count",
          },
          opts = { skip = true },
        },
        {
          filter = {
            event = "msg_show",
            kind = "",
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
    config = true,
  },

  -- Scrollbar
  { "lewis6991/satellite.nvim",
    event = "BufReadPost",
    opts = {
      current_only = true,
      excluded_filetypes = {
        "prompt",
        "TelescopePrompt",
        "noice",
        "notify",
      },
      width = 1,
    },
  },

  -- Floating filename
  { "b0o/incline.nvim",
    event = "BufReadPre",
    config = function()
      local colors = require("kanagawa.colors").setup()
      require("incline").setup({
        highlight = {
          groups = {
            InclineNormal = {
              guibg = colors.bg,
              guifg = colors.fg,
              gui = "bold",
            },
            InclineNormalNC = {
              guifg = colors.fg,
              guibg = colors.bg_dim,
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
      })
    end,
  },

  -- Fancy select and input dialogs
  { "stevearc/dressing.nvim", init = function()
    vim.ui.select = function(...)
      require("lazy").load({ plugins = { "dressing.nvim" } })
      return vim.ui.select(...)
    end
    vim.ui.input = function(...)
      require("lazy").load({ plugins = { "dressing.nvim" } })
      return vim.ui.input(...)
    end
  end,
  },

  -- Show code context
  {
    "SmiteshP/nvim-navic",
    config = function()
      vim.g.navic_silence = true
      require("nvim-navic").setup({
        separator = " ",
        highlight = false, -- lualine colors don't apply if highlight is on
        depth_limit = 5,
      })
    end,
  },

  -- Show available code actions as lightbulb character
  {
    "kosayoda/nvim-lightbulb",
    opts = {
      autocmd = {
        enabled = true,
      },
    },
    event = "BufReadPost"
  },

  -- Clickable status column items
  { "luukvbaal/statuscol.nvim",
    event = "VeryLazy",
    opts = {
      separator = " ",
      relculright = true,
      setopt = true,
      order = "SNsFs",
    },
  },

  -- Indent guides
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "BufReadPre",
    opts = {
      char = "│",
      filetype_exclude = { "help", "alpha", "dashboard", "neo-tree", "NvimTree", "Trouble", "lazy" },
      show_trailing_blankline_indent = false,
      show_current_context = false,
      buftype_exclude = { "terminal", "nofile" },
    },
  },

  -- active indent guide and indent text objects
  {
    "echasnovski/mini.indentscope",
    event = "BufReadPre",
    opts = {
      symbol = "│",
      options = { try_as_border = false },
    },
    config = function(_, opts)
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "help", "alpha", "dashboard", "neo-tree", "NvimTree", "Trouble", "lazy", "mason", "noice", "rdoc",
          "terminal" },
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
      { '<M-,>', '<cmd>BufferPrevious<CR>', desc = "Previous Buffer" },
      { '<M-.>', '<cmd>BufferNext<CR>', desc = "Next Buffer" },
      { "<C-l>", "<cmd>bnext<CR>", desc = "Next Buffer" },
      { "<C-h>", "<cmd>bprevious<CR>", desc = "Previous Buffer" },
      { "]b", "<cmd>bnext<CR>", desc = "Next Buffer" },
      { "[b", "<cmd>bprevious<CR>", desc = "Previous Buffer" },
      { "<leader>bc", "<cmd>BufferClose!<CR>", desc = "Close Buffer" },
      { "<leader>be", "<cmd>BufferCloseAllButCurrent<CR>", desc = "Close All But Current Buffer" },
      { '<M-<>', '<cmd>BufferMovePrevious<CR>', desc = "Move Buffer Left" },
      { '<M->>', '<cmd>BufferMoveNext<CR>', desc = "Move Buffer Right" },
      { '<M-1>', '<cmd>BufferGoto 1<CR>', desc = "Buffer 1" },
      { '<M-2>', '<cmd>BufferGoto 2<CR>', desc = "Buffer 2" },
      { '<M-3>', '<cmd>BufferGoto 3<CR>', desc = "Buffer 3" },
      { '<M-4>', '<cmd>BufferGoto 4<CR>', desc = "Buffer 4" },
      { '<M-5>', '<cmd>BufferGoto 5<CR>', desc = "Buffer 5" },
      { '<M-6>', '<cmd>BufferGoto 6<CR>', desc = "Buffer 6" },
      { '<M-7>', '<cmd>BufferGoto 7<CR>', desc = "Buffer 7" },
      { '<M-8>', '<cmd>BufferGoto 8<CR>', desc = "Buffer 8" },
      { '<M-9>', '<cmd>BufferGoto 9<CR>', desc = "Buffer 9" },
      { '<M-0>', '<cmd>BufferLast<CR>', desc = "Last Buffer" },
      { '<M-c>', '<cmd>BufferClose<CR>', desc = "Close Buffer" },
    },
    opts = {
      tabpages = false,
      diagnostics = {
        [vim.diagnostic.severity.ERROR] = { enabled = true, icon = ' ' },
      },
      icons = 'both',
      maximum_padding = 1,
    }
  },

  -- Dashboard
  {
    "goolord/alpha-nvim",
    event = "VimEnter",
    config = function()
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
        dashboard.button("f", " " .. " Find file", ":Telescope find_files <CR>"),
        dashboard.button("e", " " .. " New file", ":ene <BAR> startinsert <CR>"),
        dashboard.button("r", " " .. " Recent files", ":Telescope oldfiles <CR>"),
        dashboard.button("t", " " .. " Find text", ":Telescope live_grep <CR>"),
        dashboard.button("c", " " .. " Config", ":e $MYVIMRC <CR>"),
        dashboard.button("p", " " .. " Open Project", ":Telescope projects<CR>"),
        dashboard.button("l", "鈴 " .. " Lazy", ":Lazy<CR>"),
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

      local alpha = require("alpha")
      if vim.o.filetype == "lazy" then
        -- close and re-open Lazy after showing alpha
        vim.cmd.close()
        alpha.setup(dashboard.opts)
        require("lazy").show()
      else
        alpha.setup(dashboard.opts)
      end

      vim.api.nvim_create_autocmd("User", {
        pattern = "LazyVimStarted",
        callback = function()
          local stats = require("lazy").stats()
          local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
          dashboard.section.footer.val = "💪 Neovim loaded " .. stats.count .. " plugins in " .. ms .. "ms 💪"
          pcall(vim.cmd.AlphaRedraw)
        end,
      })
    end
  },

  -- icons
  "nvim-tree/nvim-web-devicons",

  -- ui components
  "MunifTanjim/nui.nvim",
}
