return {
  -- Show code context as top line
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = "BufReadPre",
    keys = {
      { "<leader>uT", "<cmd>TSContext toggle<cr>", desc = "Toggle TS Context" },
      {
        "gC",
        function()
          require("treesitter-context").go_to_context()
        end,
        desc = "Goto Context",
      },
    },
    opts = {
      max_lines = 2,
      line_numbers = true,
    },
  },

  -- Code tree based highlighting and other features
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      { "hiphish/rainbow-delimiters.nvim", submodules = false },
    },
    keys = {
      { "<C-space>", desc = "Increment selection" },
      { "<bs>", desc = "Decrement selection", mode = "x" },
      {
        "]C",
        function()
          require("nvim-treesitter.textobjects.move").goto_next_start("@comment.outer")
        end,
        desc = "Next Comment",
      },
      {
        "[C",
        function()
          require("nvim-treesitter.textobjects.move").goto_previous_start("@comment.outer")
        end,
        desc = "Previous Comment",
      },
      {
        "]#",
        function()
          require("nvim-treesitter.textobjects.move").goto_next_start("@number.inner")
        end,
        desc = "Next Number",
      },
      {
        "[#",
        function()
          require("nvim-treesitter.textobjects.move").goto_previous_start("@number.inner")
        end,
        desc = "Previous Number",
      },
      {
        "<C-S-l>",
        function()
          require("nvim-treesitter.textobjects.swap").swap_next("@parameter.inner")
        end,
        desc = "Swap Next Sibling",
      },
      {
        "<C-S-h>",
        function()
          require("nvim-treesitter.textobjects.swap").swap_previous("@parameter.inner")
        end,
        desc = "Swap Previous Sibling",
      },
    },
    opts = {
      highlight = {
        enable = true,
        disable = { "csv", "tsv" },
      },
      indent = { enable = true },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-space>",
          node_incremental = "<C-space>",
          scope_incremental = false,
          node_decremental = "<bs>",
        },
      },
      auto_install = true,
      ensure_installed = {
        "bash",
        "diff",
        "git_rebase",
        "gitignore",
        "html",
        "ini",
        "json",
        "jsonc",
        "lua",
        "luadoc",
        "luap",
        "markdown",
        "markdown_inline",
        "python",
        "query",
        "r",
        "regex",
        "rnoweb",
        "toml",
        "vim",
        "vimdoc",
        "xml",
        "yaml",
      },
    },
    config = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        local added = {}
        opts.ensure_installed = vim.tbl_filter(function(lang)
          if added[lang] then
            return false
          end
          added[lang] = true
          return true
        end, opts.ensure_installed)
      end
      require("nvim-treesitter.configs").setup(opts)
    end,
  },

  -- sort treesitter nodes
  {
    "mtrajano/tssorter.nvim",
    opts = {
      sortables = {
        r = {
          arguments = {
            node = "argument",
          },
        },
      },
    },
    keys = {
      {
        mode = { "n", "x" },
        "<leader>S",
        function()
          require("tssorter").sort()
        end,
        desc = "Sort",
      },
    },
  },

  -- navigate around treesitter nodes
  {
    "aaronik/treewalker.nvim",
    opts = {},
    keys = {
      -- movement
      {
        "<C-j>",
        mode = { "n", "v" },
        function()
          require("treewalker").move_down()
        end,
        desc = "Move Down TS Node",
      },
      {
        "<C-k>",
        mode = { "n", "v" },
        function()
          require("treewalker").move_up()
        end,
        desc = "Move Up TS Node",
      },
      {
        "<C-h>",
        mode = { "n", "v" },
        function()
          require("treewalker").move_out()
        end,
        desc = "Move Out of TS Node",
      },
      {
        "<C-l>",
        mode = { "n", "v" },
        function()
          require("treewalker").move_in()
        end,
        desc = "Move Into TS Node",
      },
      -- swaps
      {
        "<C-S-j>",
        function()
          require("treewalker").swap_down()
        end,
        desc = "Swap TS Node Down",
      },
      {
        "<C-S-k>",
        function()
          require("treewalker").swap_up()
        end,
        desc = "Swap TS Node Up",
      },
    },
  },
}
