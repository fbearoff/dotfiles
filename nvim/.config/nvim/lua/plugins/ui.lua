return {

  -- Fancy UI elements
  {
    "folke/noice.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
    event = "VeryLazy",
    keys = {
      {
        "<leader>n",
        "",
        desc = "+Notifications",
      },
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
        desc = "Last Message",
      },
      {
        "<leader>na",
        function()
          require("noice").cmd("all")
        end,
        desc = "All",
      },
      {
        "<leader>nd",
        function()
          require("noice").cmd("dismiss")
        end,
        desc = "Dismiss All",
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
            any = {
              { find = "%d+L, %d+B" },
              { find = "; after" },
              { find = "; before" },
            },
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
              { find = "line" },
              { find = "written" },
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
    keys = {
      {
        "<leader>cr",
        function()
          return ":IncRename " .. vim.fn.expand("<cword>")
        end,
        expr = true,
        desc = "Rename",
      },
      {
        "grn",
        function()
          return ":IncRename " .. vim.fn.expand("<cword>")
        end,
        expr = true,
        desc = "Rename",
      },
    },
    opts = {},
  },

  -- Scrollbar
  {
    "petertriho/nvim-scrollbar",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      show_in_active_only = true,
      marks = {
        GitAdd = {
          text = "│",
        },
        GitChange = {
          text = "│",
        },
      },
      excluded_buftypes = {
        "terminal",
        "nofile",
      },
      handlers = {
        gitsigns = true,
      },
    },
  },

  -- Show code context
  {
    "SmiteshP/nvim-navic",
    opts = {
      highlight = true,
      depth_limit = 5,
      icons = require("config.icons").kinds,
      safe_output = true,
      lazy_update_context = true,
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
      code_lenses = true,
      sign = {
        enabled = false,
      },
      status_text = {
        enabled = true,
      },
    },
    event = "BufReadPost",
  },

  -- Bufferline
  {
    "romgrk/barbar.nvim",
    event = "VeryLazy",
    keys = {
      { "<M-,>", "<cmd>BufferPrevious<CR>", desc = "Previous Buffer" },
      { "<M-.>", "<cmd>BufferNext<CR>", desc = "Next Buffer" },
      { "]b", "<cmd>BufferNext<CR>", desc = "Next Buffer" },
      { "[b", "<cmd>BufferPrevious<CR>", desc = "Previous Buffer" },
      { "]B", "<cmd>BufferLast<CR>", desc = "Last Buffer" },
      { "[B", "<cmd>BufferFirst<CR>", desc = "First Buffer" },
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
      },
      highlight_visible = false,
      maximum_padding = 1,
    },
  },

  -- icons
  "nvim-tree/nvim-web-devicons",
}
