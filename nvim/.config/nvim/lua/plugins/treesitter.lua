return {
  -- perform actions on TS nodes
  {
    "CKolkey/ts-node-action",
    keys = {
      {
        mode = { "n", "x" },
        "<leader>cn",
        function()
          require("ts-node-action").node_action()
        end,
        desc = "Trigger Node Action",
      },
    },
    opts = {},
  },

  -- Show code context as top line
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = "BufReadPre",
    keys = {
      { "<leader>uT", "<cmd>TSContextToggle<cr>", desc = "Toggle TS Context" },
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
        "]x",
        function()
          require("nvim-treesitter.textobjects.swap").swap_next("@parameter.inner")
        end,
        desc = "Swap Next Sibling",
      },
      {
        "[x",
        function()
          require("nvim-treesitter.textobjects.swap").swap_previous("@parameter.inner")
        end,
        desc = "Swap Previous Sibling",
      },
    },
    dependencies = {
      "hiphish/rainbow-delimiters.nvim",
    },
    opts = {
      highlight = { enable = true, disable = { "csv", "tsv" } },
      indent = { enable = true },
      context_commentstring = { enable = true, enable_autocmd = false },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-space>",
          node_incremental = "<C-space>",
          scope_incremental = false,
          node_decremental = "<bs>",
        },
      },
      autopairs = {
        enable = true,
      },
      matchup = {
        enable = true,
        enable_quotes = true,
      },
      auto_install = true,
      ensure_installed = {
        "bash",
        "diff",
        "git_rebase",
        "gitignore",
        "vimdoc",
        "html",
        "ini",
        "json",
        "lua",
        "luadoc",
        "luap",
        "markdown",
        "markdown_inline",
        "python",
        "query",
        "r",
        "regex",
        "vim",
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

  {
    "yaocccc/nvim-hl-mdcodeblock.lua",
    dependencies = "nvim-treesitter/nvim-treesitter",
    ft = { "markdown", "quarto" },
    opts = {
      hl_group = "CursorLine",
      minumum_len = 15,
      query_by_ft = {
        quarto = {
          "markdown", -- parser
          "(fenced_code_block) @codeblock", -- query
        },
      },
    },
  },
}
