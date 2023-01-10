return {
  {
    "ellisonleao/glow.nvim",
    cmd = "Glow"
  },
  -- Markdown live preview, needs `webkit2gtk`
  {
    "toppair/peek.nvim",
    build = "deno task --quiet build:fast",
    keys = { "<leader>cp" },
    config = true,
  },

  -- Edit fenced language in popup
  { "AckslD/nvim-FeMaco.lua",
    cmd = "FeMaco",
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
      'neovim/nvim-lspconfig'
    },
    ft = "quarto",
    config = function()
      require 'quarto'.setup {
        lspFeatures = {
          enabled = true,
          languages = { 'r', 'python', 'julia' },
          diagnostics = {
            enabled = true,
            triggers = { "BufWrite" }
          },
          completion = {
            enabled = false
          }
        }
      }
    end
  }
}
