local servers = {
  "sumneko_lua",
  "r_language_server",
  "bashls",
  "marksman",
  "ansiblels"
}

local status_mason_ok, mason = pcall(require, "mason")
if not status_mason_ok then
  return
end

local status_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if not status_ok then
  return
end

local lspconfig = require("lspconfig")

mason.setup {
  ui = {
    border = "none",
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗"
    }
  },
  log_level = vim.log.levels.INFO,
  max_concurrent_installers = 4,
  check_outdated_packages_on_open = true,
}
mason_lspconfig.setup {
  ensure_installed = servers,
  automatic_installation = true
}

for _, server in pairs(servers) do
  local opts = {
    on_attach = require("user.lsp.handlers").on_attach,
    capabilities = require("user.lsp.handlers").capabilities,
  }
  local has_custom_opts, server_custom_opts = pcall(require, "user.lsp.settings." .. server)
  if has_custom_opts then
    opts = vim.tbl_deep_extend("force", opts, server_custom_opts)
  end
  lspconfig[server].setup(opts)
end
