vim.pack.add({
  "https://github.com/folke/which-key.nvim",
})

require("which-key").setup({
  spec = {
    {
      { "<leader>b", group = "Buffer" },
      { "<leader>c", group = "Code", mode = { "n", "v" } },
      { "<leader>f", group = "Files" },
      { "<leader>g", group = "Git", mode = { "n", "x" } },
      { "<leader>gh", group = "Hunks", mode = { "n", "x" } },
      { "<leader>s", group = "Search", mode = { "n", "x" } },
      { "<leader>u", group = "UI" },
      { "[", group = "Prev" },
      { "]", group = "Next" },
      { "a", group = "Around", mode = { "o", "x" } },
      { "g", group = "Goto" },
      { "gr", group = "LSP Actions" },
      { "gs", group = "Surround & Custom Maps" },
      { "i", group = "Inside", mode = { "o", "x" } },
    },
  },
  icons = { rules = false },
  plugins = {
    marks = false,
    registers = false,
  },
  show_help = false,
})
