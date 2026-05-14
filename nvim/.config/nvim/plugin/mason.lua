vim.pack.add({ "https://github.com/mason-org/mason.nvim" })

require("mason").setup({
  ui = {
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗",
    },
  },
})

local tools = {
  -- lsps
  "ansible-language-server",
  "bash-language-server",
  "docker-compose-language-service",
  "dockerfile-language-server",
  "marksman",
  "r-languageserver",
  "emmylua_ls",
  -- tools
  "air",
  "shfmt",
  "stylua",
  "ansible-lint",
  "mdformat",
  "markdown-toc",
  "tree-sitter-cli",
}

local mr = require("mason-registry")
local function install_tools()
  for _, tool in ipairs(tools) do
    local p = mr.get_package(tool)
    if not p:is_installed() then
      p:install()
    end
  end
end
if mr.refresh then
  mr.refresh(install_tools)
else
  install_tools()
end

vim.keymap.set("n", "<leader>cm", "<cmd>Mason<cr>", { desc = "Mason" })
