local status_ok, sniprun = pcall(require, "sniprun")
if not status_ok then
  return
end

local colors = require("kanagawa.colors").setup()

sniprun.setup {
  selected_interpreters = {}, --# use those instead of the default for the current filetype
  repl_enable = {}, --# enable REPL-like behavior for the given interpreters
  repl_disable = {}, --# disable REPL-like behavior for the given interpreters

  interpreter_options = { --# interpreter-specific options, see docs / :SnipInfo <name>

    --# use the interpreter name as key
    GFM_original = {
      use_on_filetypes = { "markdown.pandoc" } --# the 'use_on_filetypes' configuration key is
      --# available for every interpreter
    },
    Python3_original = {
      error_truncate = "auto" --# Truncate runtime errors 'long', 'short' or 'auto'
      --# the hint is available for every interpreter
      --# but may not be always respected
    }
  },

  --# you can combo different display modes as desired and with the 'Ok' or 'Err' suffix
  --# to filter only sucessful runs (or errored-out runs respectively)
  display = {
    -- "Classic", --# display results in the command-line  area
    "VirtualTextOK", --# display ok results as virtual text (multiline is shortened)

    -- "VirtualText",             --# display results as virtual text
    -- "TempFloatingWindow",      --# display results in a floating window
    -- "LongTempFloatingWindow",  --# same as above, but only long results. To use with VirtualText[Ok/Err]
    -- "Terminal",                --# display results in a vertical split
    "TerminalWithCode", --# display results and code history in a vertical split
    -- "NvimNotify",              --# display with the nvim-notify plugin
    -- "Api"                      --# return output to a programming interface
  },

  live_display = { "VirtualTextOk" }, --# display mode used in live_mode

  display_options = {
    terminal_width = 45, --# change the terminal display option width
    notification_timeout = 5 --# timeout for nvim_notify output
  },

  --# You can use the same keys to customize whether a sniprun producing
  --# no output should display nothing or '(no output)'
  show_no_output = {
    "Classic",
    "TempFloatingWindow", --# implies LongTempFloatingWindow, which has no effect on its own
  },

  --# customize highlight groups (setting this overrides colorscheme)

  snipruncolors = {
    SniprunVirtualTextOk  = { bg = colors.diag.hint, fg = colors.bg_dark, ctermbg = "Cyan", cterfg = "Black" },
    SniprunFloatingWinOk  = { fg = "#66eeff", ctermfg = "Cyan" },
    SniprunVirtualTextErr = { bg = colors.diag.error, fg = colors.bg.dark, ctermbg = "DarkRed", cterfg = "Black" },
    SniprunFloatingWinErr = { fg = "#881515", ctermfg = "DarkRed" },
  },

  --# miscellaneous compatibility/adjustement settings
  inline_messages = 0, --# inline_message (0/1) is a one-line way to display messages
  --# to workaround sniprun not being able to display anything

  borders = 'single', --# display borders around floating windows
  --# possible values are 'none', 'single', 'double', or 'shadow'
  live_mode_toggle = 'off' --# live mode toggle, see Usage - Running for more info

}
