return {
  "nvim-lua/plenary.nvim",

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
      { "<leader>su", "<cmd>UrlView<cr>", desc = "URLs" },
      { "<leader>sU", "<cmd>UrlView lazy<cr>", desc = "Plugin URLs" },
    },
  },

  -- Prevent nesting of nvim instances
  {
    "willothy/flatten.nvim",
    event = "VeryLazy",
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
}
