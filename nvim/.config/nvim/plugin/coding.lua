vim.pack.add({
  "https://github.com/kylechui/nvim-surround",
  "https://github.com/wansmer/treesj",
  "https://github.com/stevearc/conform.nvim",
})

-- surround
vim.keymap.set("i", "<C-g>s", "<Plug>(nvim-surround-insert)", { desc = "Surround" })
vim.keymap.set("i", "<C-g>S", "<Plug>(nvim-surround-insert-line)", { desc = "Surround Line" })
vim.keymap.set("n", "ys", "<Plug>(nvim-surround-normal)", { desc = "Surround" })
vim.keymap.set("n", "yss", "<Plug>(nvim-surround-normal-cur)", { desc = "Surround Current Line" })
vim.keymap.set("n", "yS", "<Plug>(nvim-surround-normal-line)", { desc = "Surround Around Motion on New Lines" })
vim.keymap.set("n", "ySS", "<Plug>(nvim-surround-normal-cur-line)", { desc = "Surround Around Current Line" })
vim.keymap.set("x", "S", "<Plug>(nvim-surround-visual)", { desc = "Surround" })
vim.keymap.set("x", "gS", "<Plug>(nvim-surround-visual-line)", { desc = "Surround Line" })
vim.keymap.set("n", "ds", "<Plug>(nvim-surround-delete)", { desc = "Delete" })
vim.keymap.set("n", "cs", "<Plug>(nvim-surround-change)", { desc = "Change" })
vim.keymap.set("n", "cS", "<Plug>(nvim-surround-change-line)", { desc = "Change Line" })

-- Code block joing/splitting
-- treesj
require("treesj").setup({ use_default_keymaps = false, max_join_length = 150 })

vim.keymap.set({ "n", "x" }, "gj", function()
  require("treesj").join()
end, { desc = "Join Line" })

vim.keymap.set({ "n", "x" }, "gk", function()
  require("treesj").split()
end, { desc = "Split Line" })

-- conform
-- Autoformat
require("conform").setup({
  default_format_opts = {
    lsp_format = "fallback",
  },
  format_on_save = function(bufnr)
    -- Disable with a global or buffer-local variable
    if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
      return
    end
    return { timeout_ms = 500, lsp_fallback = true }
  end,
  formatters_by_ft = {
    lua = { "stylua" },
    r = { "air" },
    sh = { "shfmt" },
    markdown = { "mdformat", "markdown-toc" },
    ["_"] = { "trim_whitespace", "trim_newlines" },
  },
})

vim.api.nvim_create_user_command("FormatDisable", function(args)
  if args.bang then
    -- FormatDisable! will disable formatting just for this buffer
    vim.b.disable_autoformat = true
  else
    vim.g.disable_autoformat = true
  end
  vim.notify("Autoformat Disabled")
end, {
  desc = "Disable autoformat-on-save",
  bang = true,
})

vim.api.nvim_create_user_command("FormatEnable", function()
  vim.b.disable_autoformat = false
  vim.g.disable_autoformat = false
  vim.notify("Autoformat Enabled")
end, {
  desc = "Re-enable autoformat-on-save",
})
vim.keymap.set("n", "<leader>cf", function()
  require("conform").format({ async = true })
end, { desc = "Format Buffer" })
vim.keymap.set("n", "=", function()
  require("conform").format({ async = true })
end, { desc = "Format buffer" })
