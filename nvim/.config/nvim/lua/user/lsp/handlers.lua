local M = {}

local status_cmp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_cmp_ok then
  return
end

M.capabilities = vim.lsp.protocol.make_client_capabilities()
M.capabilities.textDocument.completion.completionItem.snippetSupport = true
M.capabilities = cmp_nvim_lsp.default_capabilities(M.capabilities)

M.setup = function()
  local signs = {
    { name = "DiagnosticSignError", text = "" },
    { name = "DiagnosticSignWarn", text = "" },
    { name = "DiagnosticSignHint", text = "" },
    { name = "DiagnosticSignInfo", text = "" },
  }

  for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
  end

  local config = {
    virtual_text = {
      source = 'always',
      prefix = '■',
      -- Only show virtual text matching the given severity
      severity = {
        -- Specify a range of severities
        min = vim.diagnostic.severity.ERROR,
      },
    },
    -- show signs
    signs = {
      active = signs,
      priority = 50,
    },
    update_in_insert = false,
    underline = true,
    severity_sort = true,
    float = {
      focusable = true,
      style = "minimal",
      border = "rounded",
      source = "always",
      header = "",
      prefix = "",
    },
  }

  vim.diagnostic.config(config)

  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "rounded",
  })

  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = "rounded",
  })
end

-- LSP format a selection
function format_range_operator()
  local old_func = vim.go.operatorfunc
  _G.op_func_formatting = function()
    local start = vim.api.nvim_buf_get_mark(0, '[')
    local finish = vim.api.nvim_buf_get_mark(0, ']')
    vim.lsp.buf.format({}, start, finish)
    vim.go.operatorfunc = old_func
    _G.op_func_formatting = nil
  end
  vim.go.operatorfunc = 'v:lua.op_func_formatting'
  vim.api.nvim_feedkeys('g@', 'n', false)
end

-- Mappings
local opts = { noremap = true, silent = true }
local keymap = vim.keymap.set

keymap("n", "gl", vim.diagnostic.open_float, opts)
keymap("n", "<leader>lj", vim.diagnostic.goto_next, opts)
keymap("n", "<leader>lk", vim.diagnostic.goto_prev, opts)
keymap("n", "<leader>lq", vim.diagnostic.setloclist, opts)

local function lsp_keymaps(bufnr)
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  keymap("n", "gD", vim.lsp.buf.declaration, bufopts)
  keymap("n", "gd", vim.lsp.buf.definition, bufopts)
  keymap("n", "K", vim.lsp.buf.hover, bufopts)
  keymap("n", "gi", vim.lsp.buf.implementation, bufopts)
  keymap("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
  keymap("n", "gr", vim.lsp.buf.references, bufopts)
  keymap('n', '<leader>lf', function() vim.lsp.buf.format { async = true } end, bufopts)
  keymap("n", "<leader>la", vim.lsp.buf.code_action, bufopts)
  keymap("n", "<leader>lr", vim.lsp.buf.rename, bufopts)
  keymap("n", "<leader>ls", vim.lsp.buf.signature_help, bufopts)
  vim.api.nvim_buf_create_user_command(bufnr, "Format", vim.lsp.buf.format, {})
  keymap({ "n", "v" }, "gm", format_range_operator, bufopts)
end

local navic = require("nvim-navic")

M.on_attach = function(client, bufnr)

  lsp_keymaps(bufnr)
  local status_ok, illuminate = pcall(require, "illuminate")
  if not status_ok then
    return
  end
  illuminate.on_attach(client)

  if client.server_capabilities.documentSymbolProvider then
    navic.attach(client, bufnr)
  end
end

return M
