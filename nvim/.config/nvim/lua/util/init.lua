local M = {}

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

-- Escape out of pair in insert mode
function M.EscapePair()
  local closers = { ")", "]", "}", ">", "'", '"', "`", "," }
  local line = vim.api.nvim_get_current_line()
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  local after = line:sub(col + 1, -1)
  local closer_col = #after + 1
  local closer_i = nil
  for i, closer in ipairs(closers) do
    local cur_index, _ = after:find(closer)
    if cur_index and (cur_index < closer_col) then
      closer_col = cur_index
      closer_i = i
    end
  end
  if closer_i then
    vim.api.nvim_win_set_cursor(0, { row, col + closer_col })
  else
    vim.api.nvim_win_set_cursor(0, { row, col + 1 })
  end
end

return M
