vim.pack.add({
  "https://github.com/neovim/nvim-lspconfig",
})

local servers = {
  ansiblels = {},
  bashls = {},
  docker_compose_language_service = {},
  dockerls = {},
  marksman = {},
  jarl = {},
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
