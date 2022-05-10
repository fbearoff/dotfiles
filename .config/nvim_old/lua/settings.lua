--set split bottom/righ
vim.o.splitright = true
vim.o.splitbelow = true
--set cursorline
vim.wo.cursorline = true

--Set highlight on search
vim.o.hlsearch = true
--clear highlight on insert mode
vim.keymap.set('n', 'i', ':noh<cr>i')

--Make line numbers default
vim.wo.number = true
vim.wo.rnu = true

--Enable mouse mode
vim.o.mouse = 'a'

--Enable break indent
vim.o.breakindent = true

--Save undo history
vim.opt.undofile = true

--Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.ttimeoutlen = 0
vim.o.ttimeout = 500

--Decrease update time
vim.o.updatetime = 250
vim.wo.signcolumn = 'yes'

--Set colorscheme
vim.o.termguicolors = true
vim.cmd [[colorscheme gruvbox]]

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,longest,preview'

--scrolloff
vim.o.so = 10

--tabs
vim.o.tabstop = 8
vim.o.softtabstop = 4
vim.o.shiftwidth = 4

--wildmenu
vim.o.wildmode = 'longest,full'

--<F2> for paste toggle
vim.o.pastetoggle = '<F2>'

--show search match
vim.o.showmatch = true

-- Highlight on yank
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})
-- vim: ts=2 sts=2 sw=2 et
