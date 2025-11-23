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
    branch = "main",
    build = function()
      local TS = require("nvim-treesitter")
      TS.update(nil, { summary = true })
    end,
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      { "hiphish/rainbow-delimiters.nvim", submodules = false },
    },
    keys = {
      {
        "]C",
        function()
          require("nvim-treesitter-textobjects.move").goto_next_start("@comment.outer")
        end,
        desc = "Next Comment",
      },
      {
        "[C",
        function()
          require("nvim-treesitter-textobjects.move").goto_previous_start("@comment.outer")
        end,
        desc = "Previous Comment",
      },
      {
        "]#",
        function()
          require("nvim-treesitter-textobjects.move").goto_next_start("@number.inner")
        end,
        desc = "Next Number",
      },
      {
        "[#",
        function()
          require("nvim-treesitter-textobjects.move").goto_previous_start("@number.inner")
        end,
        desc = "Previous Number",
      },
      {
        "<C-S-l>",
        function()
          require("nvim-treesitter-textobjects.swap").swap_next("@parameter.inner")
        end,
        desc = "Swap Next Sibling",
      },
      {
        "<C-S-h>",
        function()
          require("nvim-treesitter-textobjects.swap").swap_previous("@parameter.inner")
        end,
        desc = "Swap Previous Sibling",
      },
    },
    opts = {
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
        "zsh",
      },
    },
    config = function(_, opts)
      local TS = require("nvim-treesitter")

      TS.setup(opts)

      UtilTS.get_installed(true) -- initialize the installed langs

      -- install missing parsers
      local install = vim.tbl_filter(function(lang)
        return not UtilTS.have(lang)
      end, opts.ensure_installed or {})
      if #install > 0 then
        TS.install(install, { summary = true }):await(function()
          UtilTS.get_installed(true) -- refresh the installed langs
        end)
      end

      -- treesitter highlighting
      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("treesitter", { clear = true }),
        callback = function(ev)
          if UtilTS.have(ev.match) then
            pcall(vim.treesitter.start)

            -- check if ftplugins changed foldexpr/indentexpr
            for _, option in ipairs({ "foldexpr", "indentexpr" }) do
              local expr = "v:lua.UtilTS." .. option .. "()"
              if vim.opt_global[option]:get() == expr then
                vim.opt_local[option] = expr
              end
            end
          end
        end,
      })
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
