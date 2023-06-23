return {
  "nvim-lua/plenary.nvim",

  -- Easy terminal access
  {
    "akinsho/toggleterm.nvim",
    keys = {
      { [[<c-\>]], desc = "ToggleTerm" },
      { "<leader>tf", "<cmd>ToggleTerm direction=float<CR>", desc = "Float" },
      { "<leader>t-", "<cmd>ToggleTerm size=10 direction=horizontal<CR>", desc = "Horizontal" },
      { "<leader>t\\", "<cmd>ToggleTerm size=80 direction=vertical<CR>", desc = "Vertical" },
      { "<leader>ts", "<cmd>ToggleTermSendCurrentLine<CR>", desc = "Send Line" },
      { mode = "x", "<leader>s", ":ToggleTermSendVisualLines<CR>", desc = "Send Lines to Terminal" },
    },
    cmd = { "ToggleTerm", "TermExec" },
    opts = function()
      function _G.set_terminal_keymaps()
        local opts = { buffer = 0 }
        vim.keymap.set("t", "jk", [[<C-\><C-n>]], opts)
        vim.keymap.set("t", "<C-h>", [[<C-\><C-n><C-W>h]], opts)
        vim.keymap.set("t", "<C-j>", [[<C-\><C-n><C-W>j]], opts)
        vim.keymap.set("t", "<C-k>", [[<C-\><C-n><C-W>k]], opts)
        vim.keymap.set("t", "<C-l>", [[<C-\><C-n><C-W>l]], opts)
      end

      vim.api.nvim_create_autocmd({ "TermOpen" }, {
        pattern = "term://*",
        callback = set_terminal_keymaps,
      })
      return {
        autochdir = true,
        open_mapping = [[<c-\>]],
        shading_factor = 2,
        direction = "horizontal",
        float_opts = {
          border = "curved",
          winblend = 5,
        },
      }
    end,
  },

  -- Visualize startup time
  {
    "dstein64/vim-startuptime",
    cmd = "StartupTime",
    config = function()
      vim.g.startuptime_tries = 10
    end,
  },

  -- Quicker escape from insert mode with jj/jk
  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    opts = {},
  },

  -- Remove trailing lines and whitespace
  {
    "cappyzawa/trim.nvim",
    event = "BufReadPost",
    opts = {
      ft_blocklist = { "markdown" },
      patterns = {
        [[%s/\r//g]], --strip windows end of line character
      },
    },
  },
  -- makes some plugins dot-repeatable
  { "tpope/vim-repeat", event = "VeryLazy" },

  -- URL opening
  {
    "axieax/urlview.nvim",
    cmd = "UrlView",
    opts = {},
    keys = {
      { "[u", desc = "Previous URL" },
      { "]u", desc = "Next URL" },
      { "<leader>su", "<cmd>UrlView buffer bufnr=0<cr>", desc = "URLs" },
      { "<leader>sU", "<cmd>UrlView lazy<cr>", desc = "Plugin URLs" },
    },
  },

  -- Prevent nesting of nvim instances
  {
    "willothy/flatten.nvim",
    lazy = false,
    priority = 1001,
    opts = {
      callbacks = {
        pre_open = function()
          require("toggleterm").toggle(0)
        end,
        post_open = function(bufnr, winnr, ft)
          if ft == "gitcommit" then
            vim.api.nvim_create_autocmd("BufWritePost", {
              buffer = bufnr,
              once = true,
              callback = function()
                vim.defer_fn(function()
                  vim.api.nvim_buf_delete(bufnr, {})
                end, 50)
              end,
            })
          else
            require("toggleterm").toggle(0)
            vim.api.nvim_set_current_win(winnr)
          end
        end,
        block_end = function()
          require("toggleterm").toggle(0)
        end,
      },
    },
  },

  -- Highlight undo
  {
    "tzachar/highlight-undo.nvim",
    keys = { "u", "<C-r>" },
    opts = {},
  },
}
