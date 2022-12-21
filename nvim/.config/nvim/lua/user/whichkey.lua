local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
  return
end

local setup = {
  plugins = {
    marks = true, -- shows a list of your marks on ' and `
    registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
    spelling = {
      enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
      suggestions = 20, -- how many suggestions should be shown in the list?
    },
    -- the presets plugin, adds help for a bunch of default keybindings in Neovim
    -- No actual key bindings are created
    presets = {
      operators = false, -- adds help for operators like d, y, ... and registers them for motion / text object completion
      motions = false, -- adds help for motions
      text_objects = false, -- help for text objects triggered after entering an operator
      windows = true, -- default bindings on <c-w>
      nav = true, -- misc bindings to work with windows
      z = true, -- bindings for folds, spelling and others prefixed with z
      g = true, -- bindings for prefixed with g
    },
  },
  -- add operators that will trigger motion and text object completion
  -- to enable all native operators, set the preset / operators plugin above
  operators = { gc = "Comments" },
  key_labels = {
    -- override the label used to display some keys. It doesn't effect WK in any other way.
    -- For example:
    -- ["<space>"] = "SPC",
    -- ["<cr>"] = "ENTER",
    -- ["<tab>"] = "TAB",
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
  show_keys = false, -- show the currently pressed key and its label as a message in the command line
  triggers = "auto", -- automatically setup triggers
  -- triggers = {"<leader>"} -- or specify a list manually
  triggers_blacklist = {
    -- list of mode / prefixes that should never be hooked by WhichKey
    -- this is mostly relevant for key maps that start with a native binding
    -- most people should not need to change this
    i = { "j", "k" },
    v = { "j", "k" },
  },
}

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

  i = { ":'<,'>lua require('nvim-toggler').toggle()<CR>", "Toggle Inverse" },
  o = { ":'<,'>sort i<CR>", "Sort" },
  r = { ":'<,'>SnipRun<CR>", "SnipRun" },
  s = { "<cmd>lua require('substitute').visual()<cr>", "Substitute" },
  S = { "<Plug>(nvim-surround-visual)", "Surround" },
  x = { "d", "Cut" },
  X = { "<cmd>lua require('substitute.exchange').visual()<cr>", "Exchange" }
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
  ["/"] = { "<cmd>HopPattern<cr>", "Hop Pattern" },
  ["<TAB>"] = { "<cmd>lua require('grapple').cycle_backward()<cr>", "Grapple Cycle" },
  ["\\"] = { "<cmd>:vsplit<CR>", "VSplit" },
  ["a"] = { "<cmd>Alpha<cr>", "Alpha" },
  ["e"] = { "<cmd>NvimTreeToggle<cr>", "Explorer" },
  ["f"] = { "<cmd>Telescope find_files<cr>", "Find Files" },
  ["F"] = { "<cmd>Telescope live_grep theme=ivy<cr>", "Find Text" },
  ["i"] = { "<cmd>lua require('nvim-toggler').toggle()<CR>", "Toggle Inverse" },
  ["n"] = { "<cmd>lua require('telescope').extensions.notify.notify(require('telescope.themes').get_dropdown{winblend = 5})<cr>",
    "Notifications" },
  ["q"] = { "<cmd>q!<CR>", "Quit" },
  ["S"] = { "<Plug>SnipRun", "Sniprun" },
  ["u"] = { "<cmd>Telescope undo<cr>", "Undo" },
  ["v"] = { "<cmd>Telescope yank_history<cr>", "Clipboard" },
  ["w"] = { "<cmd>w!<CR>", "Save" },

  b = { name = "Buffers",
    b = { "<cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown{previewer = false})<cr>",
      "Buffers" },
    c = { "<cmd>BufferClose!<CR>", "Close Buffer" },
    e = { "<cmd>BufferCloseAllButCurrent<cr>", "Close all but current buffer" },
    g = { "<cmd>lua require('grapple').popup_tags(scope)<cr>", "Grapple Tags" },
  },

  d = { name = "DAP",
    b = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "Toggle Breakpoint" },
    c = { "<cmd>lua require'dap'.continue()<cr>", "Continue" },
    i = { "<cmd>lua require'dap'.step_into()<cr>", "Step Into" },
    C = { "<cmd>lua require'dap'.clear_breakpoints()<cr>", "Clear Breakpoints" },
    l = { "<cmd>lua require'dap'.run_last()<cr>", "Run Last" },
    o = { "<cmd>lua require'dap'.step_out()<cr>", "Step Out" },
    n = { "<cmd>lua require'dap'.step_over()<cr>", "Step Over" },
    r = { "<cmd>lua require'dap'.repl.toggle()<cr>", "REPL" },
    t = { "<cmd>lua require'dap'.terminate()<cr>", "Terminate" },
    u = { "<cmd>lua require'dapui'.toggle()<cr>", "DAP UI" },
  },

  p = { name = "Packer",
    c = { "<cmd>PackerCompile<cr>", "Compile" },
    i = { "<cmd>PackerInstall<cr>", "Install" },
    S = { "<cmd>PackerStatus<cr>", "Status" },
    s = { "<cmd>PackerSync<cr>", "Sync" },
    u = { "<cmd>PackerUpdate<cr>", "Update" },
  },

  g = { name = "Git",
    b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
    c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
    d = { "<cmd>Telescope git_status<cr>", "Diff Overview", },
    g = { "<cmd>lua _GITUI_TOGGLE()<cr>", "GitUI" },
    j = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
    k = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk" },
    l = { "<cmd>lua require 'gitsigns'.toggle_current_line_blame()<cr>", "Blame" },
    o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
    p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
    R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
    r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
    s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
    u = { "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>", "Undo Stage Hunk" },
    v = { "<cmd>Gitsigns diffthis<cr>", "Diff View" },
  },

  l = { name = "LSP",
    a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
    d = { "<cmd>Telescope diagnostics bufnr=0<cr>", "Document Diagnostics" },
    f = { "<cmd>lua vim.lsp.buf.format{async=true}<cr>", "Format" },
    i = { "<cmd>LspInfo<cr>", "Info" },
    j = { "<cmd>lua vim.diagnostic.goto_next()<CR>", "Next Diagnostic" },
    k = { "<cmd>lua vim.diagnostic.goto_prev()<cr>", "Prev Diagnostic" },
    l = { "<cmd>lua vim.lsp.codelens.run()<cr>", "CodeLens Action" },
    m = { "<cmd>Mason<cr>", "Mason" },
    q = { "<cmd>lua vim.diagnostic.setloclist()<cr>", "Quickfix" },
    r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
    s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
    S = { "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", "Workspace Symbols" },
    w = { "<cmd>Telescope diagnostics<cr>", "Workspace Diagnostics" },
  },

  o = { name = "Options",
    c = { "<cmd>ColorizerToggle<CR>", "Colorize" },
    g = { "<cmd>Glow<CR>", "Glow (Markdown Preview)" },
    h = { "<cmd>set invhlsearch<CR>", "Toggle Highlight" },
    w = { "<cmd>set wrap!<CR>", "Toggle Word Wrap" },
  },

  r = { name = "R",
    [":"] = { ":RSend ", "RSend" },
    b     = { "<Plug>RSPlot", "Plot and Summary" },
    e     = { "<Plug>RShowEx", "Show Example" },
    f     = { "<Plug>RStart", "Start R" },
    H     = { "<cmd>:RHelp<cr>", "Online Help" },
    h     = { "<Plug>RHelp", "Help" },
    I     = { "<cmd>lua require 'user.functions'.R_install()<CR>", "Install Package" },
    k     = { "<cmd>call RAction('levels')<CR>", "View Levels" },
    l     = { "<Plug>RListSpace", "List Space" },
    n     = { "<Plug>RObjectNames", "Print Names" },
    o     = { "<Plug>RUpdateObjBrowser", "Object Browser" },
    p     = { "<Plug>RObjectPr", "Print Object" },
    q     = { "<Plug>RClose", "Close R" },
    S     = { "<cmd>call RAction('head')<CR>", "View Head" },
    s     = { "<Plug>RSummary", "Summary" },
    t     = { "<Plug>RObjectStr", "View Structure" },
    u     = { "<cmd>RSend update.packages(ask = FALSE)<CR>", "Update Packages" },
    v     = { "<Plug>RViewDF", "View Df" },
    w     = { "<Plug>RSaveClose", "Save and Close R" },
  },

  s = { name = "Search",
    b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
    c = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
    C = { "<cmd>Telescope commands<cr>", "Commands" },
    g = { "<cmd>Telescope grep_string<cr>", "Grep String" },
    h = { "<cmd>lua require('telescope.builtin').help_tags {default_text = vim.call('expand', '<cword>')}<cr>",
      "Find Help" },
    k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
    M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
    P = { "<cmd>lua require('telescope').extensions.projects.projects()<cr>", "Projects" },
    r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
    R = { "<cmd>Telescope registers<cr>", "Registers" },
  },

  t = { name = "Terminal",
    f = { "<cmd>ToggleTerm direction=float<cr>", "Float" },
    h = { "<cmd>ToggleTerm size=10 direction=horizontal<cr>", "Horizontal" },
    p = { "<cmd>lua _PYTHON_TOGGLE()<cr>", "Python" },
    s = { "<cmd>lua require 'user.functions'.so_input()<CR>", "  StackOverflow" },
    t = { "<cmd>lua _HTOP_TOGGLE()<cr>", "Htop" },
    u = { "<cmd>lua _NCDU_TOGGLE()<cr>", "NCDU" },
    v = { "<cmd>ToggleTerm size=80 direction=vertical<cr>", "Vertical" },
  },
}

which_key.setup(setup)
which_key.register(n_mappings, n_opts)
which_key.register(v_mappings, v_opts)
