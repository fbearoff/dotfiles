local M = {}

M.root_patterns = { ".git", "lua" }

-- Return options
function M.opts(name)
  local plugin = require("lazy.core.config").plugins[name]
  if not plugin then
    return {}
  end
  local Plugin = require("lazy.core.plugin")
  return Plugin.values(plugin, "opts", false)
end

-- Check for plugin presence
function M.has(plugin)
  return require("lazy.core.config").spec.plugins[plugin] ~= nil
end

-- Execute code on plugin load
function M.on_load(name, fn)
  local Config = require("lazy.core.config")
  if Config.plugins[name] and Config.plugins[name]._.loaded then
    vim.schedule(function()
      fn(name)
    end)
  else
    vim.api.nvim_create_autocmd("User", {
      pattern = "LazyLoad",
      callback = function(event)
        if event.data == name then
          fn(name)
          return true
        end
      end,
    })
  end
end

-- Toggle diagnostics
local enabled = true
function M.toggle_diagnostics()
  enabled = not enabled
  if enabled then
    vim.diagnostic.enable()
    require("lazy.core.util").info("Enabled diagnostics", { title = "Diagnostics" })
  else
    vim.diagnostic.enable(false)
    require("lazy.core.util").warn("Disabled diagnostics", { title = "Diagnostics" })
  end
end

local nu = { number = true, relativenumber = true }
function M.toggle_number()
  if vim.opt_local.number:get() or vim.opt_local.relativenumber:get() then
    nu = { number = vim.opt_local.number:get(), relativenumber = vim.opt_local.relativenumber:get() }
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    require("lazy.core.util").warn("Disabled line numbers", { title = "Option" })
  else
    vim.opt_local.number = nu.number
    vim.opt_local.relativenumber = nu.relativenumber
    require("lazy.core.util").info("Enabled line numbers", { title = "Option" })
  end
end

-- LSP on_attach
function M.on_attach(on_attach)
  vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
      local buffer = args.buf
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      on_attach(client, buffer)
    end,
  })
end

-- Toggle opts
function M.toggle(option, silent, values)
  if values then
    if vim.opt_local[option]:get() == values[1] then
      vim.opt_local[option] = values[2]
    else
      vim.opt_local[option] = values[1]
    end
    return vim.notify(
      "Set " .. option .. " to " .. vim.opt_local[option]:get(),
      vim.log.levels.INFO,
      { title = "Option" }
    )
  end
  vim.opt_local[option] = not vim.opt_local[option]:get()
  if not silent then
    vim.notify(
      (vim.opt_local[option]:get() and "Enabled" or "Disabled") .. " " .. option,
      vim.log.levels.INFO,
      { title = "Option" }
    )
  end
end

-- returns the root directory based on:
-- * lsp workspace folders
-- * lsp root_dir
-- * root pattern of filename of the current buffer
-- * root pattern of cwd
function M.get_root()
  local path = vim.api.nvim_buf_get_name(0)
  path = path ~= "" and vim.uv.fs_realpath(path) or nil
  local roots = {}
  if path then
    for _, client in pairs(vim.lsp.get_clients({ bufnr = 0 })) do
      local workspace = client.config.workspace_folders
      local paths = workspace and vim.tbl_map(function(ws)
        return vim.uri_to_fname(ws.uri)
      end, workspace) or client.config.root_dir and { client.config.root_dir } or {}
      for _, p in ipairs(paths) do
        local r = vim.uv.fs_realpath(p)
        if path:find(r, 1, true) then
          roots[#roots + 1] = r
        end
      end
    end
  end
  table.sort(roots, function(a, b)
    return #a > #b
  end)
  local root = roots[1]
  if not root then
    path = path and vim.fs.dirname(path) or vim.uv.cwd()
    root = vim.fs.find(M.root_patterns, { path = path, upward = true })[1]
    root = root and vim.fs.dirname(root) or vim.uv.cwd()
  end
  return root
end

function M.inlay_hints(bufnr)
  bufnr = bufnr or 0
  local inlay_hint = vim.lsp.buf.inlay_hint or vim.lsp.inlay_hint
  if inlay_hint.enable then
    vim.lsp.inlay_hint.enable(bufnr, not inlay_hint.is_enabled())
  else
    vim.lsp.inlay_hint(bufnr, nil)
  end
end

return M
