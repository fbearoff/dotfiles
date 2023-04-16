return {
  { "ellisonleao/gruvbox.nvim" },

  { "folke/tokyonight.nvim" },
  {
    "rebelot/kanagawa.nvim",
    event = "VimEnter",
    priority = 1000,
    config = function()
      require("kanagawa").setup({
        undercurl = true, -- enable undercurls
        commentStyle = { italic = false },
        functionStyle = {},
        keywordStyle = { italic = false },
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
            -- Nvim-Navic
            NavicIconsFile = { link = "Directory" },
            NavicIconsModule = { link = "@include" },
            NavicIconsNamespace = { link = "@include" },
            NavicIconsPackage = { link = "@include" },
            NavicIconsClass = { link = "Structure" },
            NavicIconsMethod = { link = "Function" },
            NavicIconsProperty = { link = "@property" },
            NavicIconsField = { link = "@field" },
            NavicIconsConstructor = { link = "@constructor" },
            NavicIconsEnum = { link = "Type" },
            NavicIconsInterface = { link = "Type" },
            NavicIconsFunction = { link = "Function" },
            NavicIconsVariable = { link = "@variable" },
            NavicIconsConstant = { link = "Constant" },
            NavicIconsString = { link = "String" },
            NavicIconsNumber = { link = "Number" },
            NavicIconsBoolean = { link = "Boolean" },
            NavicIconsArray = { link = "Type" },
            NavicIconsObject = { link = "Type" },
            NavicIconsKey = { link = "Keyword" },
            NavicIconsNull = { link = "Type" },
            NavicIconsEnumMember = { link = "@field" },
            NavicIconsStruct = { link = "Structure" },
            NavicIconsEvent = { link = "Structure" },
            NavicIconsOperator = { link = "Operator" },
            NavicIconsTypeParameter = { link = "Identifier" },
            NavicText = { fg = theme.ui.fg },
            NavicSeparator = { fg = theme.ui.fg },

            -- Popup menu
            Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 },
            PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
            PmenuSbar = { bg = theme.ui.bg_m1 },
            PmenuThumb = { bg = theme.ui.bg_p2 },
          }
        end,
        theme = "wave", -- Load "wave" theme when 'background' option is not set
        background = { -- map the value of 'background' option to a theme
          dark = "wave", -- try "dragon" !
          light = "lotus",
        },
      })
      require("kanagawa").load()
    end,
  },
}
