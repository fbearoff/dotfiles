vim.pack.add({
  "https://github.com/neovim/nvim-lspconfig",
  "https://github.com/mason-org/mason.nvim",
  "https://github.com/mason-org/mason-lspconfig.nvim",
})

local servers = {
  ansiblels = {},
  bashls = {},
  dockerls = {},
  docker_compose_language_service = {},
  marksman = {},
  r_language_server = {},
  lua_ls = {
    settings = {
      Lua = {
        runtime = {
          version = "LuaJIT",
        },
        workspace = {
          library = {
            vim.env.VIMRUNTIME,
          },
          checkThirdParty = false,
        },
        completion = {
          callSnippet = "Replace",
        },
        format = {
          enable = false,
        },
      },
    },
  },
}

-- Enable LSPs not in mason
vim.lsp.enable({ "jarl" })

-- Prefer LSP folding if client supports it
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    ---@diagnostic disable-next-line: need-check-nil
    if client:supports_method("textDocument/foldingRange") then
      local win = vim.api.nvim_get_current_win()
      vim.wo[win][0].foldexpr = "v:lua.vim.lsp.foldexpr()"
    end
  end,
})

-- show colors as virtual text
vim.lsp.document_color.enable(true, nil, { style = "virtual" })

for server, settings in pairs(servers) do
  vim.lsp.config(server, settings)
  vim.lsp.enable(server)
end

-- cmdline tools and lsp servers
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

-- get all the servers that are available through mason-lspconfig
local have_mason, mlsp = pcall(require, "mason-lspconfig")

local ensure_installed = vim.tbl_keys(servers or {})
for server, _ in pairs(servers) do
  ensure_installed[#ensure_installed + 1] = server
end

if have_mason then
  mlsp.setup({ ensure_installed = servers })
end

vim.keymap.set("n", "gl", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
vim.keymap.set("n", "grx", vim.lsp.codelens.run, { desc = "Run Codelens" })
vim.keymap.set("n", "<leader>cl", "<cmd>checkhealth vim.lsp<cr>", { desc = "Lsp Info" })
vim.keymap.set("n", "<leader>cD", function()
  Snacks.picker.diagnostics()
end, { desc = "Diagnostics (Workspace)" })
vim.keymap.set("n", "<leader>cd", function()
  Snacks.picker.diagnostics_buffer()
end, { desc = "Diagnostics (Document)" })
vim.keymap.set("n", "gd", function()
  Snacks.picker.lsp_definitions()
end, { desc = "Goto Definition" })
vim.keymap.set("n", "grr", function()
  Snacks.picker.lsp_references()
end, { desc = "Goto References" })
vim.keymap.set("n", "gD", function()
  Snacks.picker.lsp_declarations()
end, { desc = "Goto Declaration" })
vim.keymap.set("n", "gri", function()
  Snacks.picker.lsp_implementations()
end, { desc = "Goto Implementation" })
vim.keymap.set("n", "grt", function()
  Snacks.picker.lsp_type_definitions()
end, { desc = "Goto Type Definition" })
vim.keymap.set("n", "gO", function()
  Snacks.picker.lsp_symbols()
end, { desc = "Goto Document Symbols" })
vim.keymap.set("n", "<leader>cs", function()
  Snacks.picker.lsp_symbols()
end, { desc = "LSP Symbols" })
vim.keymap.set("n", "<leader>cS", function()
  Snacks.picker.lsp_workspace_symbols()
end, { desc = "LSP Workspace Symbols" })
vim.keymap.set("n", "gK", vim.lsp.buf.signature_help, { desc = "Signature Help" })
vim.keymap.set({ "n", "v" }, "gra", vim.lsp.buf.code_action, { desc = "Code Action" })
vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action" })
