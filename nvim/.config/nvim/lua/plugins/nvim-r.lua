local M = {
  "jalvesaq/Nvim-R",
  ft = { "r", "rmd", },
  event = "BufReadPost"
}

function M.config()

  local options = {
    R_bracketed_paste = true,
    R_esc_term = false,
    R_commented_lines = true,
    R_args = { '--quiet', '--no-save' },
    R_source_args = 'echo = TRUE, spaced = TRUE',
    R_term_title = 'R',
    R_hl_term = false,
    R_editing_mode = 'vi',
    R_clear_console = false,
    R_clear_line = true,
    R_specialplot = true,
    R_assign = 0,
    R_csv_app = ':TermExec cmd="vd %s"',
    R_auto_omni = {},
    R_hi_fun = false,
    rmd_fenced_languages = {'r'}
  }

  for k, v in pairs(options) do
    vim.g[k] = v
  end

  -- Keymaps
  local keymap = require('util').keymap

  keymap('n', '<leader><Space>', '<Plug>RDSendLine')
  keymap('v', '<leader><Space>', '<Plug>RDSendSelection')
  keymap('n', '<LocalLeader>:', ':RSend ')

end

return M
