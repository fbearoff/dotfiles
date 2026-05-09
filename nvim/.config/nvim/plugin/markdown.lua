vim.pack.add({
  "https://github.com/MeanderingProgrammer/render-markdown.nvim",
})

require("render-markdown").setup({
  completions = { blink = { enabled = true } },
  code = {
    sign = false,
    width = "block",
    right_pad = 1,
  },
  checkbox = {
    checked = { scope_highlight = "@markup.strikethrough" },
  },
  heading = {
    sign = false,
    width = "block",
    left_pad = 2,
    right_pad = 4,
  },
})

vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "markdown" },
  callback = function()
    vim.keymap.set("n", "<localleader>t", function()
      require("render-markdown").buf_toggle()
    end, { desc = "Toggle Markdown Rendering", buf = 0 })
  end,
})
