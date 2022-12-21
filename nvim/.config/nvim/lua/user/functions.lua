local TERMINAL = require("toggleterm.terminal").Terminal
local M = {}

-- check if a variable is not empty nor nil
M.isNotEmpty = function(s)
  return s ~= nil and s ~= ""
end

-- For creating new Terminal Instance
function M.open_term(cmd, opts)
  opts           = opts or {}
  opts.size      = opts.size or vim.o.columns * 0.5
  opts.direction = opts.direction or "vertical"
  opts.on_open   = opts.on_open or default_on_open
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

return M
