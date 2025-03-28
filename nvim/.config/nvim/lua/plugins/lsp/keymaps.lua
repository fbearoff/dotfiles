local M = {}

M._keys = nil

function M.get()
  if M._keys then
    return M._keys
  end
    -- stylua: ignore
    M._keys = {
      { "<leader>cd", vim.diagnostic.open_float, desc = "Line Diagnostics" },
      { "gl", vim.diagnostic.open_float, desc = "Line Diagnostics" },
      { "<leader>cl", "<cmd>checkhealth vim.lsp<cr>", desc = "Lsp Info" },
      { "<leader>dd", function() Snacks.picker.diagnostics() end, desc = "Document" },
      { "<leader>dD", function() Snacks.picker.diagnostics_buffer() end, desc = "Workspace" },
      { "gd", function() Snacks.picker.lsp_definitions() end, desc = "Goto Definition", has = "definition" },
      { "grr", function() Snacks.picker.lsp_references() end, nowait = true, desc = "Goto References" },
      { "gD", function() Snacks.picker.lsp_declarations() end, desc = "Goto Declaration" },
      { "gri", function() Snacks.picker.lsp_implementations() end, desc = "Goto Implementation" },
      { "gy", function() Snacks.picker.lsp_type_definitions() end, desc = "Goto Type Definition" },
      { "gO", function() Snacks.picker.lsp_symbols() end, desc = "Goto Document Symbols" },
      { "gK", vim.lsp.buf.signature_help, desc = "Signature Help", has = "signatureHelp" },
      { "gra", vim.lsp.buf.code_action, desc = "Code Action", mode = { "n", "v" }, has = "codeAction" },
      { "<leader>ca", vim.lsp.buf.code_action, desc = "Code Action", mode = { "n", "v" }, has = "codeAction" },
      { "<leader>cc", vim.lsp.codelens.run, desc = "Run Codelens", mode = { "n", "v" }, has = "codeLens" },
      { "<leader>cC", vim.lsp.codelens.refresh, desc = "Refresh & Display Codelens", has = "codeLens" },
    }
  return M._keys
end

function M.has(buffer, method)
  method = method:find("/") and method or "textDocument/" .. method
  local clients = vim.lsp.get_clients({ bufnr = buffer })
  for _, client in ipairs(clients) do
    if client.supports_method(method) then
      return true
    end
  end
  return false
end

function M.resolve(buffer)
  local Keys = require("lazy.core.handler.keys")
  if not Keys.resolve then
    return {}
  end

  local spec = M.get()
  local opts = require("util").opts("nvim-lspconfig")
  local clients = vim.lsp.get_clients({ bufnr = buffer })
  for _, client in ipairs(clients) do
    local maps = opts.servers[client.name] and opts.servers[client.name].keys or {}
    vim.list_extend(spec, maps)
  end
  return Keys.resolve(spec)
end

function M.on_attach(_, buffer)
  local Keys = require("lazy.core.handler.keys")
  local keymaps = M.resolve(buffer)

  for _, keys in pairs(keymaps) do
    if not keys.has or M.has(buffer, keys.has) then
      local opts = Keys.opts(keys)
      ---@diagnostic disable-next-line: no-unknown
      opts.has = nil
      opts.silent = opts.silent ~= false
      opts.buffer = buffer
      vim.keymap.set(keys.mode or "n", keys.lhs, keys.rhs, opts)
    end
  end
end

return M
