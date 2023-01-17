return {
  -- Show code context as top line
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = "BufReadPre",
    config = true,
  },

  -- Code tree based highlighting and other features
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = "BufReadPost",
    dependencies = {
      "RRethy/nvim-treesitter-textsubjects",
      "mrjones2014/nvim-ts-rainbow"
    },
    opts = {
      ensure_installed = {
        "bash",
        "comment",
        "diff",
        "gitignore",
        "help",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "r",
        "regex",
        "yaml",
      },
      highlight = { enable = true },
      indent = { enable = true },
      context_commentstring = { enable = true, enable_autocmd = false },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<c-space>",
          node_incremental = "<c-space>",
          scope_incremental = "<c-s>",
          node_decremental = "<c-backspace>",
        },
      },
      autopairs = {
        enable = true,
      },
      rainbow = {
        enable = true,
        extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
        max_file_lines = nil, -- Do not enable for files with more than n lines, int
      },
      textsubjects = {
        enable = true,
        keymaps = {
          ["."] = "textsubjects-smart",
          [";"] = "textsubjects-container-outer",
          ['i;'] = 'textsubjects-container-inner',
        },
      },
      matchup = { enable = true, },
    }
  },
}
