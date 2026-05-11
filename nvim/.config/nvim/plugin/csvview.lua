vim.pack.add({ "https://github.com/hat0uma/csvview.nvim" })

require("csvview").setup({
  parser = { comments = { "#", "//" } },
  keymaps = {
    -- Text objects for selecting fields
    textobject_field_inner = { "if", mode = { "o", "x" } },
    textobject_field_outer = { "af", mode = { "o", "x" } },

    jump_next_field_start = { "w", mode = { "n", "v" } },
    jump_prev_field_start = { "b", mode = { "n", "v" } },
  },
  view = {
    display_mode = "border",
  },
})

vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = {
    "csv",
    "tsv",
  },
  callback = function()
    vim.keymap.set("n", "<localleader>t", function()
      require("csvview").toggle()
    end, { desc = "Toggle CSV View", buf = 0 })
    require("csvview").enable()
  end,
})
