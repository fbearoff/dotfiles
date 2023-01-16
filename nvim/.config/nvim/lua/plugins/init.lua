return {
  "williamboman/mason-lspconfig.nvim",
  "nvim-lua/plenary.nvim",

  -- UI to rename items incrementally
  {
    "smjonas/inc-rename.nvim",
    cmd = "IncRename",
    config = true,
  },

  -- Show outline of document symbols
  {
    "simrat39/symbols-outline.nvim",
    cmd = "SymbolsOutline",
    init = function()
      vim.keymap.set("n", "<leader>cs", "<cmd>SymbolsOutline<cr>", { desc = "Symbols Outline" })
    end,
    config = true
  },

  -- Highlight function arguments
  {
    "m-demare/hlargs.nvim",
    event = "BufReadPost",
    enabled = true,
    opts = {
      excluded_argnames = {
        usages = {
          lua = { "self", "use" },
        },
      },
    }
  },

  -- Better diagnostics list
  {
    "folke/trouble.nvim",
    cmd = { "TroubleToggle", "Trouble" },
    opts = {
      auto_open = false,
      use_diagnostic_signs = true,
    },
    keys = {
      { "<leader>dx", "<cmd>TroubleToggle document_diagnostics<cr>", desc = "Document Diagnostics (Trouble)" },
      { "<leader>dX", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Workspace Diagnostics (Trouble)" },
    },
  },

  -- Visualize startup time
  {
    "dstein64/vim-startuptime",
    cmd = "StartupTime",
    config = function()
      vim.g.startuptime_tries = 10
    end,
  },

  -- Show code context as top line
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = "BufReadPre",
    config = true,
  },

  -- Quicker escape from insert mode with jj/
  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = true
  },


  -- Remove trailing lines and whitespace
  { "cappyzawa/trim.nvim",
    event = "BufReadPost",
    opts = { disable = { "markdown" },
      patterns = {
        [[%s/\r//g]] --strip windows end of line character
      },
    },
  },

  -- Code block joing/splitting
  {
    "Wansmer/treesj",
    keys = {
      { "<leader>J", "<cmd>TSJJoin<CR>", desc = "Join Line" },
      { "<leader>S", "<cmd>TSJSplit<CR>", desc = "Split Line" },
    },
    cmd = { "TSJSplit", "TSJJoin" },
    opts = {
      use_default_keymaps = false,
      max_join_length = 150,
    },
  },

  -- Better text-objects
  {
    "echasnovski/mini.ai",
    keys = {
      { "a", mode = { "x", "o" } },
      { "i", mode = { "x", "o" } },
    },
    dependencies = {
      {
        "nvim-treesitter/nvim-treesitter-textobjects",
        init = function()
          -- no need to load the plugin, since we only need its queries
          require("lazy.core.loader").disable_rtp_plugin("nvim-treesitter-textobjects")
        end,
      },
    },
    config = function()
      local ai = require("mini.ai")
      ai.setup({
        n_lines = 500,
        custom_textobjects = {
          o = ai.gen_spec.treesitter({
            a = { "@block.outer", "@conditional.outer", "@loop.outer" },
            i = { "@block.inner", "@conditional.inner", "@loop.inner" },
          }, {}),
          f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }, {}),
          c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }, {}),
        },
      })
    end,
  },

}
