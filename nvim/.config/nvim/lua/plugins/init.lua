return {
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
      require("nvim-navic").setup({ separator = " ", highlight = false, depth_limit = 5 }) -- lualine colors don't apply if highlight is on
    end,
  },

  {
    "simrat39/symbols-outline.nvim",
    cmd = "SymbolsOutline",
    init = function()
      vim.keymap.set("n", "<leader>cls", "<cmd>SymbolsOutline<cr>", { desc = "Symbols Outline" })
    end,
    config = true
  },

  {
    "m-demare/hlargs.nvim",
    event = "BufReadPost",
    enabled = true,
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

  { "cappyzawa/trim.nvim",
    event = "BufReadPost",
    config = { disable = { "markdown" },
      patterns = {
        [[%s/\r//g]] --strip windows end of line character
      },
    },
  },

  {
    "ahmedkhalf/project.nvim",
    cmd = "Telescope projects",
    config = function()
      require("project_nvim").setup({
        detection_methods = { "lsp", "pattern" },
        patterns = { ".git", "Makefile", "package.json", "Deseq2.R" },
        datapath = vim.fn.stdpath("data"),
      })
    end
  },

  {
    "kosayoda/nvim-lightbulb",
    config = {
      autocmd = {
        enabled = true,
      },
    },
    event = "BufReadPost"
  },

  {
    "andymass/vim-matchup",
    event = "BufReadPost",
    config = function()
      vim.g.matchup_matchparen_offscreen = { method = "status_manual" }
    end,
  },

  {
    "gorbit99/codewindow.nvim",
    config = true,
    keys = "<leader>cm"
  }
}
