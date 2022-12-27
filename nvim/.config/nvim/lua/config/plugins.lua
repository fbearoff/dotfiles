return {
  "jay-babu/mason-null-ls.nvim",
  "williamboman/mason-lspconfig.nvim",
  "MunifTanjim/nui.nvim",
  "nvim-lua/plenary.nvim",
  "folke/which-key.nvim",

  {
    "smjonas/inc-rename.nvim",
    cmd = "IncRename",
    config = true,
  },

  { "ellisonleao/gruvbox.nvim" },

  { "stevearc/dressing.nvim", event = "VeryLazy" },

  -- LSP
  {
    "SmiteshP/nvim-navic",
    config = function()
      vim.g.navic_silence = true
      require("nvim-navic").setup({ separator = " ", highlight = true, depth_limit = 5 })
    end,
  },

  {
    "simrat39/symbols-outline.nvim",
    cmd = "SymbolsOutline",
    init = function()
      vim.keymap.set("n", "<leader>ls", "<cmd>SymbolsOutline<cr>", { desc = "Symbols Outline" })
    end,
    config = true
  },

  {
    "m-demare/hlargs.nvim",
    event = "VeryLazy",
    enabled = false,
    config = {
      excluded_argnames = {
        usages = {
          lua = { "self", "use" },
        },
      },
    }
  },

  {
    "nvim-tree/nvim-web-devicons",
    config = { default = true },
  },

  {
    "folke/trouble.nvim",
    cmd = { "TroubleToggle", "Trouble" },
    config = {
      auto_open = false,
      use_diagnostic_signs = true,
    }
  },

  {
    "dstein64/vim-startuptime",
    cmd = "StartupTime",
    config = function()
      vim.g.startuptime_tries = 10
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter-context",
    event = "BufReadPre",
    config = true,
  },

  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = true
  },
  {
    "ellisonleao/glow.nvim",
    cmd = "Glow"
  },


}
