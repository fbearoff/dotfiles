local mason_dap_ok, mason_dap = pcall(require, "mason-nvim-dap")
local dap_ok, dap = pcall(require, "dap")
local dap_ui_ok, ui = pcall(require, "dapui")

if not (dap_ok and dap_ui_ok and mason_dap_ok) then
  require("notify")("nvim-dap, mason-nvim-dap, or dap-ui not installed!", "warning")
  return
end

mason_dap.setup {
  ensure_installed = { "bash" },
  automatic_setup = true,
}
mason_dap.setup_handlers { function(source_name)
  -- all sources with no handler get passed here

  -- Keep original functionality of `automatic_setup = true`
  require('mason-nvim-dap.automatic_setup')(source_name)
end, }

ui.setup {
  expand_lines = true,
  icons = { expanded = "", collapsed = "", circular = "" },
  mappings = {
    -- Use a table to apply multiple mappings
    expand = { "<CR>", "<2-LeftMouse>" },
    open = "o",
    remove = "d",
    edit = "e",
    repl = "r",
    toggle = "t",
  },
  layouts = {
    {
      elements = {
        { id = "scopes", size = 0.33 },
        { id = "breakpoints", size = 0.17 },
        { id = "stacks", size = 0.25 },
        { id = "watches", size = 0.25 },
      },
      size = 0.33,
      position = "right",
    },
    {
      elements = {
        { id = "repl", size = 0.45 },
        { id = "console", size = 0.55 },
      },
      size = 0.27,
      position = "bottom",
    },
  },
  controls = {
    -- Requires Neovim nightly (or 0.8 when released)
    enabled = true,
    -- Display controls in this element
    element = "repl",
    icons = {
      pause = "",
      play = "▶",
      step_into = "",
      step_over = "淪",
      step_out = "",
      step_back = "倫",
      run_last = "漏",
      terminate = "栗",
    },
    floating = {
      max_height = 0.9,
      max_width = 0.5, -- Floats will be treated as percentage of your screen.
      border = vim.g.border_chars, -- Border style. Can be 'single', 'double' or 'rounded'
      mappings = {
        close = { "q", "<Esc>" },
      },
    },
  },
}

vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DiagnosticSignError", linehl = "", numhl = "" })

dap.listeners.after.event_initialized["dapui_config"] = function()
  ui.open()
end

dap.listeners.before.event_terminated["dapui_config"] = function()
  ui.close()
end

dap.listeners.before.event_exited["dapui_config"] = function()
  ui.close()
end

-- Keymaps
local opts = { noremap = true, silent = true }
local keymap = vim.keymap.set

keymap("n", "<leader>db", require 'dap'.toggle_breakpoint, opts)
keymap("n", "<leader>dc", require 'dap'.continue, opts)
keymap("n", "<leader>di", require 'dap'.step_into, opts)
keymap("n", "<leader>do", require 'dap'.step_over, opts)
keymap("n", "<leader>dO", require 'dap'.step_out, opts)
keymap("n", "<leader>dr", require 'dap'.repl.toggle, opts)
keymap("n", "<leader>dl", require 'dap'.run_last, opts)
keymap("n", "<leader>du", require 'dapui'.toggle, opts)
keymap("n", "<leader>dt", require 'dap'.terminate, opts)
