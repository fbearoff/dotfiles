vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.o.backup = false -- creates a backup file
vim.o.breakindent = true -- preserve indent on wrapped lines
vim.o.confirm = true -- menu to confirm changes
vim.o.cursorline = true -- highlight the current line
vim.o.expandtab = true -- convert tabs to spaces
vim.o.foldcolumn = "1"
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldnestmax = 10 -- max fold nesting level
vim.o.ignorecase = true -- ignore case in search patterns
vim.o.laststatus = 0 -- not needed with lualine
vim.o.linebreak = true -- break lines at delimiter chars
vim.o.mouse = "" -- default value of "a", "nv" disables in insert
vim.o.mousemodel = "extend"
vim.o.number = true -- set numbered lines
vim.o.numberwidth = 2 -- set number column width to 2 {default 4}
vim.o.pumheight = 10 -- pop up menu height
vim.o.relativenumber = true -- set relative numbered lines
vim.o.ruler = false
vim.o.scrolloff = 8 -- lines of ceontext
vim.o.shiftround = true -- round indent
vim.o.shiftwidth = 2 -- the number of spaces inserted for each indentation
vim.o.showmatch = true -- show matching paren on creation
vim.o.showmode = false -- shown on statusline
vim.o.showtabline = 0 -- always show tabs
vim.o.sidescrolloff = 8
vim.o.signcolumn = "yes" -- always show the sign column, otherwise it would shift the text each time
vim.o.smartcase = true -- smart case
vim.o.smartindent = true -- make indenting smarter again
vim.o.smoothscroll = true
vim.o.softtabstop = 2 -- how many spaces is a tab press worth
vim.o.splitbelow = true -- force all horizontal splits to go below current window
vim.o.splitkeep = "screen" -- stabilize screen position on split
vim.o.splitright = true -- force all vertical splits to go to the right of current window
vim.o.swapfile = false -- creates a swapfile
vim.o.tabstop = 2 -- insert 2 spaces for a tab
vim.o.termguicolors = true -- set term gui colors (most terminals support this)
vim.o.timeoutlen = 500 -- time to wait for a mapped sequence to complete (in milliseconds)
vim.o.undofile = true -- enable persistent undo
vim.o.updatetime = 300 -- faster completion (4000ms default)
vim.o.whichwrap = "bs<>[]hl" -- which "horizontal" keys are allowed to travel to prev/next line
vim.o.wildmode = "longest:full,full" -- Command-line completion mode
vim.o.writebackup = false -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited

vim.schedule(function() --schedule to speed up start
  vim.o.clipboard = "unnamedplus" -- use system clipboard
  vim.o.cmdheight = 0 -- no cmdline needed with ui2
end)

vim.opt.fillchars = {
  diff = "╱",
  eob = " ",
  fold = " ",
  foldclose = "",
  foldopen = "",
  foldsep = " ",
}

vim.opt.completeopt = { "menu", "menuone", "noselect" } -- mostly just for cmp
vim.opt.shortmess:append({ W = true, I = true, c = true })
vim.opt.iskeyword:append("-") -- hyphenated words recognized by searches
vim.opt.formatoptions:remove({ "c", "r", "o" }) -- don't insert the current comment leader automatically for auto-wrapping comments using 'textwidth', hitting <Enter> in insert mode, or hitting 'o' or 'O' in normal mode.
