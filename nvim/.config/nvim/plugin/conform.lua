vim.pack.add({
  "https://github.com/stevearc/conform.nvim",
})

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
  formatters = {
    topiary = {
      command = "topiary",
      args = { "format", "$FILENAME" },
    },
  },
  formatters_by_ft = {
    lua = { "stylua" },
    r = { "air" },
    sh = { "shfmt" },
    zsh = { "shfmt" },
    markdown = { "mdformat", "markdown-toc" },
    openscad = { "topiary" },
    ["_"] = { "trim_whitespace", "trim_newlines" },
  },
})

vim.keymap.set("n", "<leader>cf", function()
  require("conform").format({ async = true })
end, { desc = "Format Buffer" })
vim.keymap.set("n", "=", function()
  require("conform").format({ async = true })
end, { desc = "Format buffer" })

-- toggle
Snacks.toggle
  .new({
    name = "Autoformat",
    get = function()
      return not vim.g.disable_autoformat
    end,
    set = function(state)
      vim.g.disable_autoformat = not state
    end,
  })
  :map("<leader>uf")
