return {

  { "ellisonleao/gruvbox.nvim" },

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

  {
    "folke/noice.nvim",
    event = "VeryLazy",
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

    -- stylua: ignore
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
  },
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

  {
    "kosayoda/nvim-lightbulb",
    opts = {
      autocmd = {
        enabled = true,
      },
    },
    event = "BufReadPost"
  },
  -- icons
  "nvim-tree/nvim-web-devicons",

  -- ui components
  "MunifTanjim/nui.nvim",
}
