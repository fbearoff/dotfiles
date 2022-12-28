local M = {
  "jose-elias-alvarez/null-ls.nvim",
}

function M.setup(options)
  local nls = require("null-ls")
  nls.setup({
    debounce = 150,
    save_after_format = false,
    sources = {
      nls.builtins.formatting.shfmt,
      nls.builtins.formatting.black.with { extra_args = { "--fast" } },
    },
    on_attach = options.on_attach,
    root_dir = require("null-ls.utils").root_pattern(".null-ls-root", ".neoconf.json", ".git"),
  })
end

return M
