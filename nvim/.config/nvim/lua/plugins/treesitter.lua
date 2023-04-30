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
    },
    opts = {
      max_lines = 2,
      line_numbers = false,
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
    },
    dependencies = {
      "HiPhish/nvim-ts-rainbow2",
    },
    opts = {
      highlight = { enable = true },
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
      rainbow = {
        enable = true,
      },
      matchup = { enable = true },
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

  -- Highlight defined TS nodes
  {
    "atusy/tsnode-marker.nvim",
    enabled = false,
    init = function()
      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("tsnode-marker-markdown", {}),
        pattern = "markdown",
        callback = function(ctx)
          require("tsnode-marker").set_automark(ctx.buf, {
            target = { "code_fence_content" }, -- list of target node types
            hl_group = "CursorLine", -- highlight group
          })
        end,
      })
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
