vim.pack.add({
  "https://github.com/rebelot/kanagawa.nvim",
})
require("kanagawa").setup({
  dimInactive = true,
  colors = {
    theme = {
      all = {
        ui = { bg_gutter = "none" },
      },
    },
  },
  overrides = function(colors)
    local theme = colors.theme
    return {
      -- Floats
      NormalFloat = { bg = "none" },
      FloatBorder = { bg = "none" },
      FloatTitle = { bg = "none" },

      -- for Snacks words
      LspReferenceText = { bg = "none", underline = true },
      LspReferenceWrite = { bg = "none", underline = true },

      -- Popup menu
      Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 },
      PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
      PmenuSbar = { bg = theme.ui.bg_m1 },
      PmenuThumb = { bg = theme.ui.bg_p2 },

      -- blink.pairs
      BlinkPairsOrange = { fg = colors.palette.surimiOrange },
      BlinkPairsBlue = { fg = colors.palette.dragonBlue },
      BlinkPairsPurple = { fg = colors.palette.oniViolet },
      BlinkPairsUnmatched = { fg = colors.palette.waveAqua1 },
      BlinkPairsMatchParen = { fg = colors.palette.surimiOrange, bold = true },
    }
  end,
})

vim.cmd("colorscheme kanagawa")

-- Highlights HL group under cursor
vim.keymap.set("n", "<leader>sH", vim.show_pos, { desc = "Highlight Groups" })
