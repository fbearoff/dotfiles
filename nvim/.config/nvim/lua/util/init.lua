local M = {}

-- Return options
function M.opts(name)
  local plugin = require("lazy.core.config").plugins[name]
  if not plugin then
    return {}
  end
  local Plugin = require("lazy.core.plugin")
  return Plugin.values(plugin, "opts", false)
end

-- Toggle diagnostics
local enabled = true
function M.toggle_diagnostics()
  enabled = not enabled
  if enabled then
    vim.diagnostic.enable()
    require("lazy.core.util").info("Enabled diagnostics", { title = "Diagnostics" })
  else
    vim.diagnostic.disable()
    require("lazy.core.util").warn("Disabled diagnostics", { title = "Diagnostics" })
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

-- For creating new Terminal Instance
function M.open_term(cmd, opts)
  local TERMINAL = require("toggleterm.terminal").Terminal
  opts           = opts or {}
  opts.size      = opts.size or vim.o.columns * 0.5
  opts.direction = opts.direction or "vertical"
  opts.on_open   = opts.on_open
  opts.on_exit   = opts.on_exit or nil

  local new_term = TERMINAL:new {
    cmd             = cmd,
    dir             = "git_dir",
    auto_scroll     = false,
    close_on_exit   = false,
    start_in_insert = false,
    on_open         = opts.on_open,
    on_exit         = opts.on_exit
  }
  new_term:open(opts.size, opts.direction)
end

-- For StackOverflow Assistance
function M.so_input()
  local buf = vim.api.nvim_get_current_buf()
  local file_type = vim.api.nvim_buf_get_option(buf, "filetype")
  local current_word = vim.call('expand', '<cword>')
  vim.ui.input({ prompt = "StackOverflow input: ", default = file_type .. " " .. current_word },
    function(input)
      local cmd = ""
      if input == "" or not input then
        return
      elseif input == "h" then
        cmd = "-h"
      else
        cmd = input
      end
      M.open_term("so " .. cmd, { direction = 'float' })
    end)
end

-- Installs the package under cursor via Nvim-R
function M.R_install()
  local current_word = vim.call('expand', '<cword>')
  local rsend_command = string.format(':RSend install.packages("' .. current_word .. '")')
  vim.api.nvim_command(rsend_command)
end

-- Sort operator
function M.sort(lines, _)
  local utils = require('yop.utils')
  local sort_without_leading_space = function(a, b)
    local pattern = [[^%W*]]
    return string.gsub(a, pattern, "") < string.gsub(b, pattern, "")
  end
  if #lines == 1 then
    local delimeter = ","
    local split = vim.split(lines[1], delimeter, { trimempty = true })
    table.sort(split, sort_without_leading_space)
    return { utils.join(split, delimeter) }
  else
    table.sort(lines, sort_without_leading_space)
    return lines
  end
end

return M
