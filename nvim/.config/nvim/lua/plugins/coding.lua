return {

  -- Code block joing/splitting
  {
    "Wansmer/treesj",
    keys = {
      {
        mode = { "n", "x" },
        "gj",
        function()
          require("treesj").join()
        end,
        desc = "Join Line",
      },
      {
        mode = { "n", "x" },
        "gk",
        function()
          require("treesj").split()
        end,
        desc = "Split Line",
      },
    },
    cmd = { "TSJSplit", "TSJJoin", "TSJToggle" },
    opts = {
      use_default_keymaps = false,
      max_join_length = 150,
    },
  },

  -- Autoformat
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    init = function()
      vim.api.nvim_create_user_command("FormatDisable", function(args)
        if args.bang then
          -- FormatDisable! will disable formatting just for this buffer
          vim.b.disable_autoformat = true
        else
          vim.g.disable_autoformat = true
        end
        vim.notify("Autoformat Disabled")
      end, {
        desc = "Disable autoformat-on-save",
        bang = true,
      })
      vim.api.nvim_create_user_command("FormatEnable", function()
        vim.b.disable_autoformat = false
        vim.g.disable_autoformat = false
        vim.notify("Autoformat Enabled")
      end, {
        desc = "Re-enable autoformat-on-save",
      })
    end,
    keys = {
      {
        "<leader>cf",
        function()
          require("conform").format({ async = true })
        end,
        mode = "",
        desc = "Format Buffer",
      },
      {
        "=",
        function()
          require("conform").format({ async = true })
        end,
        mode = "",
        desc = "Format buffer",
      },
      {
        "<leader>uf",
        function()
          if vim.b.disable_autoformat or vim.g.disable_autoformat then
            vim.cmd("FormatEnable")
          else
            vim.cmd("FormatDisable")
          end
        end,
        desc = "Toggle Autoformat",
      },
    },
    opts = {
      default_format_opts = {
        lsp_format = "fallback",
      },
      format_on_save = function(bufnr)
        -- Disable with a global or buffer-local variable
        if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
          return
        end
        return { timeout_ms = 500, lsp_fallback = true }
      end,
      formatters_by_ft = {
        lua = { "stylua" },
        r = { "air" },
        sh = { "shfmt" },
        markdown = { "mdformat", "markdown-toc" },
        ["_"] = { "trim_whitespace", "trim_newlines" },
      },
    },
  },
}
