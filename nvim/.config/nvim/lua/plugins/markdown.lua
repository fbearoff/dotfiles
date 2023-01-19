return {
  {
    "ellisonleao/glow.nvim",
    cmd = "Glow",
    keys = {
      { "<localleader>Mg", "<cmd>Glow<cr>", desc = "Glow" }
    }
  },
  -- Markdown live preview, needs `webkit2gtk`
  {
    "toppair/peek.nvim",
    build = "deno task --quiet build:fast",
    keys = {
      {
        "<localleader>Mp",
        function()
          local peek = require("peek")
          if peek.is_open() then
            peek.close()
          else
            peek.open()
          end
        end,
        desc = "Peek",
      },
    },
    config = true,
  },

  -- Edit fenced language in popup
  { "AckslD/nvim-FeMaco.lua",
    cmd = "FeMaco",
    keys = {
      { "<localleader>Mf", "<cmd>FeMaco<cr>", desc = "FeMaco" }
    },
    opts = {
      ---@diagnostic disable-next-line: unused-local
      ensure_newline = function(base_filetype)
        return true
      end,
    }
  },

  { 'quarto-dev/quarto-nvim',
    dependencies = {
      'jmbuhr/otter.nvim',
      -- 'neovim/nvim-lspconfig'
    },
    ft = "quarto",
    keys = {
      { "<localleader>MP",
        function()
          require 'quarto'.quartoPreview()
        end,
        desc = 'Quarto Preview' },
      { "<localleader>MQ",
        function()
          require 'quarto'.quartoClosePreview()
        end,
        desc = 'Close Quarto Preview' },
    },
    opts = {
      lspFeatures = {
        enabled = true,
        languages = { 'r', 'python', 'julia' },
        diagnostics = {
          enabled = false,
          triggers = { "BufWrite" }
        },
        completion = {
          enabled = false
        }
      }
    }
  }
}
