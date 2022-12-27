local M = {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  event = "BufReadPost",

  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
    "RRethy/nvim-treesitter-textsubjects",
    "p00f/nvim-ts-rainbow"
  },
}

function M.config()
  require("nvim-treesitter.configs").setup({
    ensure_installed = {
      "bash",
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
      -- "comment", -- comments are slowing down TS bigtime, so disable for now
    },
    sync_install = false,
    auto_install = false,
    highlight = { enable = true },
    indent = { enable = true },
    context_commentstring = { enable = true, enable_autocmd = false },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "gnn",
        node_incremental = "grn",
        scope_incremental = "grc",
        node_decremental = "grm",
      },
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
      },
    },
  })
end

return M
