local null_ls_ok, null_ls = pcall(require, "null-ls")
local mason_null_ls_ok, mason_null_ls = pcall(require, "mason-null-ls")

if not (null_ls_ok and mason_null_ls_ok) then
  return
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/code_actions
local code_actions = null_ls.builtins.code_actions

null_ls.setup {
  sources = {
    formatting.shfmt, -- shell script formatting
  },
}

mason_null_ls.setup {
  ensure_installed = { "shfmt" }
}
