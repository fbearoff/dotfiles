local wk = require("which-key")
local keymap = require('util').keymap
local util = require("util")
--Remap space as leader key
-- keymap("", "<Space>", "<Nop>", { desc = 'Remove delay on leader press' })

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Insert --
-- Add undo break-points
keymap("i", ",", ",<c-g>u")
keymap("i", ".", ".<c-g>u")
keymap("i", ";", ";<c-g>u")

-- Home row navigation
keymap('i', '<C-h>', '<left>', { desc = 'Move cursor left' })
keymap('i', '<C-l>', require('util').EscapePair, { desc = 'Move cursor right, escape pair' })
keymap('i', '<C-j>', '<down>', { desc = 'Move cursor down' })
keymap('i', '<C-k>', '<up>', { desc = 'Move cursor up' })

-- Normal --
-- movement between buffers
keymap("n", "<s-tab>", function() vim.cmd("bn") end, { desc = 'Buffer next' })
keymap("n", "<tab>", "<C-w>w", { desc = 'Next window' })
-- Remap for dealing with word wrap
keymap('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
keymap('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Enter inserts newline without leaving Normal mode
-- Need to change keys in windows terminal https://github.com/microsoft/terminal/issues/530#issuecomment-892247092
keymap("n", "<cr>", "o<Esc>", { desc = "Insert newline" })
keymap("n", "<s-cr>", "O<Esc>", { desc = "Insert newline above" })

-- change word with <c-c>
keymap("n", "<C-c>", "<cmd>normal! ciw<cr>a")

-- H and L go to begining/end of line
keymap('n', 'H', '^', { desc = 'Go to beginning of line' })
keymap('n', 'L', '$', { desc = 'Go to end of line' })

-- Keep cursor in place when joing lines
-- keymap("n", "J", "mzJ`z", { desc = 'Keep cursor in place when joing lines' })

-- Center cursor when scrolling page
keymap("n", "<C-d>", "<C-d>zz", { desc = 'Scroll down and center page' })
keymap("n", "<C-u>", "<C-u>zz", { desc = 'Scroll up and center page' })

-- Keep search term in the middle of screen
keymap("n", "n", "nzzzv", { desc = 'Next search item' })
keymap("n", "N", "Nzzzv", { desc = 'Previous search item' })

--turn off Q (ex mode)
keymap('n', 'Q', '<nop>')
keymap("c", "Q", "q", { noremap = true, silent = false })
keymap('n', 'q:', '<nop>')

-- Select whole line
keymap('n', "vv", "V", { desc = 'Select whole line' })

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv^", { desc = 'Shift selection left' })
keymap("v", ">", ">gv^", { desc = 'Shift selection right' })

-- Move text up and down
keymap("v", "J", ":m '>+1<CR>gv=gv", { desc = 'Move selected text up' })
keymap("v", "K", ":m '<-2<CR>gv=gv", { desc = 'Move selected text down' })

-- Better paste
keymap("v", "p", '"_dP', { desc = 'Paste over selection' })

-- Open link under cursor
keymap("", "gx", '<Cmd>call jobstart(["xdg-open", expand("<cfile>")], {"detach": v:true})<CR>',
  { desc = 'Open link under cursor' })

-- Send deletions to blackhole register
for _, lhs in ipairs(
  { "c", "C", "d", "D", "x", "X" }) do
  keymap({ "n", "x" }, lhs, '"_' .. lhs)
end

-- Map "d" cut action to cut key
local cut_key = "<A-d>"

keymap({ "n", "x" }, cut_key, "d")
keymap("n", cut_key .. cut_key, "dd")
keymap("n", string.upper(cut_key), "D")
--
-- Clear search with <esc>
keymap({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>")
keymap("n", "gw", "*N")
keymap("x", "gw", "*N")

-- WhichKey bindings
wk.setup({
  plugins = {
    marks = false, -- shows a list of your marks on ' and `
    registers = false, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
    spelling = {
      enabled = true,
      suggestions = 20,
    },
    presets = {
      operators = false,
      motions = false,
      text_objects = false,
      windows = true, -- default bindings on <c-w>
      nav = true, -- misc bindings to work with windows
      z = false, -- bindings for folds, spelling and others prefixed with z
      g = false, -- bindings for prefixed with g
    },
  },
  -- operators = {
  --   gc = "Comments",
  -- },
  -- add operators that will trigger motion and text object completion
  -- to enable all native operators, set the preset / operators plugin above
  key_labels = {

    ["<Tab>"] = "TAB",
    ["<leader>"] = "SPC"
  },
  icons = {
    breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
    separator = "➜", -- symbol used between a key and it's label
    group = "+", -- symbol prepended to a group
  },
  popup_mappings = {
    scroll_down = "<c-d>", -- binding to scroll down inside the popup
    scroll_up = "<c-u>", -- binding to scroll up inside the popup
  },
  window = {
    border = "none", -- none, single, double, shadow
    position = "bottom", -- bottom, top
    margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
    padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
    winblend = 5,
  },
  layout = {
    height = { min = 4, max = 25 }, -- min and max height of the columns
    width = { min = 20, max = 50 }, -- min and max width of the columns
    spacing = 3, -- spacing between columns
    align = "center", -- align columns left, center or right
  },
  ignore_missing = true, -- enable this to hide mappings for which you didn't specify a label
  hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
  show_help = false, -- show help message on the command line when the popup is visible
  show_keys = true, -- show the currently pressed key and its label as a message in the command line
  triggers = "auto", -- automatically setup triggers
})

local v_opts = {
  mode = "v", -- VISUAL mode
  prefix = "<leader>",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true, -- use `nowait` when creating keymaps
}

local v_mappings = {
  g = { name = "Comments",
    c = { "<Plug>(comment_toggle_linewise_visual)<CR>", "Line Comment" },
    b = { "<Plug>(comment_toggle_blockwise_visual)<CR>", "Block Comment" }
  },

  o = { ":'<,'>sort i<CR>", "Sort" },
  r = { ":'<,'>SnipRun<CR>", "SnipRun" },
  S = { "<Plug>(nvim-surround-visual)", "Surround" },
}

local n_opts = {
  mode = "n", -- NORMAL mode
  prefix = "<leader>",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true, -- use `nowait` when creating keymaps
}

local n_mappings = {
  ["!"] = { "<cmd>lua require('grapple').toggle()<cr>", "Grapple Toggle" },
  ["-"] = { "<cmd>:split<CR>", "Split" },
  ["<TAB>"] = { "<cmd>lua require('grapple').cycle_backward()<cr>", "Grapple Cycle" },
  ["\\"] = { "<cmd>:vsplit<CR>", "VSplit" },
  [":"] = { "<cmd>Telescop command_history<cr>", "Command History" },
  ["e"] = { "<cmd>NvimTreeToggle<cr>", "Explorer" },
  ["E"] = { "<cmd>enew<cr>", "New File" },
  ["f"] = { "<cmd>lua require 'plugins.telescope'.project_files({hidden=true})<CR>", "Find Files" },
  ["F"] = { "<cmd>Telescope live_grep theme=ivy<cr>", "Find Text" },
  ["l"] = { "<cmd>:Lazy<CR>", "Lazy" },
  ["q"] = { "<cmd>q!<CR>", "Quit" },
  ["r"] = { "<cmd>SnipRun<cr>", "Sniprun" },
  ["u"] = { "<cmd>Telescope undo<cr>", "Undo" },
  ["v"] = { "<cmd>Telescope yank_history<cr>", "Clipboard" },
  ["w"] = { "<cmd>w!<CR>", "Save" },

  b = { name = "Buffers",
    b = { "<cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown{previewer = false})<cr>",
      "Buffers" },
    c = { "<cmd>BufferClose!<CR>", "Close Buffer" },
    e = { "<cmd>BufferCloseAllButCurrent<cr>", "Close All But Current" },
    g = { "<cmd>lua require('grapple').popup_tags(scope)<cr>", "Grapple Tags" },
  },

  d = { name = "DAP",
    b = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "Toggle Breakpoint" },
    C = { "<cmd>lua require'dap'.clear_breakpoints()<cr>", "Clear Breakpoints" },
    c = { "<cmd>lua require'dap'.continue()<cr>", "Continue" },
    i = { "<cmd>lua require'dap'.step_into()<cr>", "Step Into" },
    l = { "<cmd>lua require'dap'.run_last()<cr>", "Run Last" },
    n = { "<cmd>lua require'dap'.step_over()<cr>", "Step Over" },
    o = { "<cmd>lua require'dap'.step_out()<cr>", "Step Out" },
    r = { "<cmd>lua require'dap'.repl.toggle()<cr>", "REPL" },
    t = { "<cmd>lua require'dap'.terminate()<cr>", "Terminate" },
    u = { "<cmd>lua require'dapui'.toggle()<cr>", "DAP UI" },
    w = { "<cmd>lua require'dap.ui.widgets'.hover()<cr>", "Widgets" },
  },

  n = { name = "Notifications",
    a = { "<cmd>lua require'noice'.cmd('all')<cr>", "Noice All" },
    c = { "<cmd>lua require'notify'.dismiss({silent = true, pending = true})<cr>", "Clear Notifcations" },
    h = { "<cmd>lua require'noice'.cmd('history')<cr>", "Noice History" },
    l = { "<cmd>lua require'noice'.cmd('last')<cr>", "Noice Last Message" },
  },

  o = { name = "Options",
    C = { "<cmd>ColorizerToggle<CR>", "Toggle Colorizer" },
    c = { function()
      local conceallevel = vim.o.conceallevel > 0 and vim.o.conceallevel or 3
      util.toggle("conceallevel", false, { 0, conceallevel })
    end, "Toggle Conceal" },
    n = { function() util.toggle("relativenumber", true) util.toggle("number") end, "Toggle Line Number" },
    s = { function() util.toggle("spell") end, "Toggle Spell" },
    w = { function() util.toggle("wrap") end, "Toggle Word Wrap" },
  },

  s = { name = "Search",
    c = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
    C = { "<cmd>Telescope commands<cr>", "Commands" },
    g = { "<cmd>Telescope grep_string<cr>", "Grep String" },
    h = { "<cmd>lua require('telescope.builtin').help_tags {default_text = vim.call('expand', '<cword>')}<cr>",
      "Find Help" },
    k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
    m = { "<cmd>Telescope marks<cr>", "Marks" },
    M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
    p = { "<cmd>Telescope projects<cr>", "Projects" },
    r = { "<cmd>Telescope oldfiles<cr>", "Recent File" },
    R = { "<cmd>Telescope registers<cr>", "Registers" },
    s = { "<cmd>lua require 'util'.so_input()<CR>", "StackOverflow" },
  },

  T = { name = "Terminal",
    ["-"] = { "<cmd>ToggleTerm size=10 direction=horizontal<cr>", "Horizontal" },
    ["\\"] = { "<cmd>ToggleTerm size=80 direction=vertical<cr>", "Vertical" },
  },
}

wk.register(n_mappings, n_opts)
wk.register(v_mappings, v_opts)
