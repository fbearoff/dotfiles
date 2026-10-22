vim.pack.add({
  { src = "https://github.com/petertriho/nvim-scrollbar", version = "refactor/v2" },
})

require("scrollbar").setup({
  scrollbar = { visibility = "active" },
  marks = {
    GitAdd = {
      text = "│",
    },
    GitChange = {
      text = "│",
    },
  },
  providers = { gitsigns = true },
})
