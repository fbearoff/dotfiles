return {
  { "ellisonleao/gruvbox.nvim" },

  { "folke/tokyonight.nvim" },
  {
    "rebelot/kanagawa.nvim",
    event = "VimEnter",
    priority = 1000,
    opts = {
      undercurl = true, -- enable undercurls
      commentStyle = { italic = true },
      functionStyle = {},
      keywordStyle = { italic = false },
      statementStyle = { bold = true },
      typeStyle = {},
      variablebuiltinStyle = { italic = false },
      specialReturn = true, -- special highlight for the return keyword
      specialException = true, -- special highlight for exception handling keywords
      transparent = false, -- do not set background color
      dimInactive = true, -- dim inactive window `:h hl-NormalNC`
      globalStatus = true, -- adjust window separators highlight for laststatus=3
      terminalColors = true, -- define vim.g.terminal_color_{0,17}
      colors = {},
      overrides = {},
      theme = "default",
    },
    config = function()
      require("kanagawa").load()
    end,
  },
}
