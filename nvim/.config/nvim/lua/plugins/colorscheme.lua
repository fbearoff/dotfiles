return {
  {
    "rebelot/kanagawa.nvim",
    event = "VimEnter",
    priority = 1000,
    opts = {
      undercurl = true, -- enable undercurls
      commentStyle = { italic = false },
      functionStyle = {},
      keywordStyle = { italic = true },
      statementStyle = { bold = true },
      typeStyle = {},
      transparent = false, -- do not set background color
      dimInactive = true, -- dim inactive window `:h hl-NormalNC`
      terminalColors = true, -- define vim.g.terminal_color_{0,17}
      colors = { -- add/modify theme and palette colors
        palette = {},
        theme = {
          wave = {},
          lotus = {},
          dragon = {},
          all = {
            ui = { bg_gutter = "none" },
          },
        },
      },
      overrides = function(colors)
        local theme = colors.theme
        return {
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
      theme = "wave", -- Load "wave" theme when 'background' option is not set
      background = { -- map the value of 'background' option to a theme
        dark = "wave", -- try "dragon" !
        light = "lotus",
      },
    },
    init = function()
      require("kanagawa").load()
    end,
  },
}
