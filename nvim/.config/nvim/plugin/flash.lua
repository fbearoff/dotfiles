vim.pack.add({ "https://github.com/folke/flash.nvim" })
require("flash").setup({
  -- double space for EOL
  search = {
    mode = function(str)
      if str:find("^  $") then
        return "$"
      elseif str:find("^   +$") then
        return str:sub(1, -2)
      end
      return str
    end,
  },
})

-- turn off in filetypes and command line
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "qf", "nvim-undotree" },
  callback = function()
    vim.keymap.set("n", "<CR>", "<CR>", { buffer = true })
  end,
})
vim.api.nvim_create_autocmd("CmdwinEnter", {
  pattern = "*",
  callback = function()
    vim.keymap.set("n", "<CR>", "<CR>", { buffer = true })
  end,
})

vim.keymap.set({ "n", "x", "o" }, "<Enter>", function()
  require("flash").jump()
end, { desc = "Flash" })
vim.keymap.set({ "n", "x", "o" }, "<M-Enter>", function()
  require("flash").jump({
    search = { mode = "search" },
    label = { after = { 0, 0 } },
    pattern = "^",
  })
end, { desc = "Flash Lines" })
vim.keymap.set("o", "r", function()
  require("flash").remote()
end, { desc = "Remote Flash" })
vim.keymap.set({ "n", "o", "x" }, "<C-space>", function()
  require("flash").treesitter({
    actions = {
      ["<c-space>"] = "next",
      ["<BS>"] = "prev",
    },
  })
end, { desc = "Treesitter Incremental Seelction" })
