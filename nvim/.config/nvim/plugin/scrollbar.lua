vim.pack.add({
  "https://github.com/petertriho/nvim-scrollbar",
})

require("scrollbar").setup({
  show_in_active_only = true,
  marks = {
    GitAdd = {
      text = "│",
    },
    GitChange = {
      text = "│",
    },
  },
  excluded_buftypes = {
    "terminal",
    "nofile",
  },
  handlers = {
    gitsigns = true,
  },
})
