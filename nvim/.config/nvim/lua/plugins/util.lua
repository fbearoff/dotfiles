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
}
