vim.pack.add({
  "https://github.com/folke/which-key.nvim",
  "https://github.com/kawre/neotab.nvim",
})

require("which-key").setup({
  spec = {
    {
      { "<leader>b", group = "Buffer" },
      { "<leader>f", group = "Files" },
      { "<leader>g", group = "Git", mode = { "n", "x" } },
      { "<leader>gh", group = "Hunks", mode = { "n", "x" } },
      { "<leader>s", group = "Search", mode = { "n", "x" } },
      { "<leader>u", group = "UI" },
      { "[", group = "Prev" },
      { "]", group = "Next" },
      { "g", group = "Goto" },
      { "gr", group = "LSP Actions" },
      { "a", group = "Around", mode = { "o", "x" } },
      { "i", group = "Inside", mode = { "o", "x" } },
      { "<leader>c", group = "Code", mode = { "n", "v" } },
      { "<localleader>m", group = "Markdown" },
    },
  },
  icons = { rules = false },
  plugins = {
    marks = false,
    registers = false,
  },
  win = { wo = { winblend = 5 } },
  show_help = false,
})
