local opts = { noremap = true, silent = true }

-- Shorten function name
local keymap = vim.keymap.set

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Insert --
-- Better window navigation
keymap('i', '<A-h>', '<C-\\><C-N><C-w>h', opts)
keymap('i', '<A-j>', '<C-\\><C-N><C-w>j', opts)
keymap('i', '<A-k>', '<C-\\><C-N><C-w>k', opts)
keymap('i', '<A-l>', '<C-\\><C-N><C-w>l', opts)

-- Home row navigation
keymap('i', '<C-h>', '<left>', opts)
keymap('i', '<C-l>', '<right>', opts)
keymap('i', '<C-j>', '<down>', opts)
keymap('i', '<C-k>', '<up>', opts)

-- Normal --
-- Remap for dealing with word wrap
keymap('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
keymap('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- H and L go to begining/end of line
keymap('n', 'H', '^', opts)
keymap('n', 'L', '$', opts)

-- Keep cursor in place when joing lines
keymap("n", "J", "mzJ`z", opts)

-- Center cursor when scrolling page
keymap("n", "<C-d>", "<C-d>zz", opts)
keymap("n", "<C-u>", "<C-u>zz", opts)

-- Keep search term in the middle of screen
keymap("n", "n", "nzzzv", opts)
keymap("n", "N", "Nzzzv", opts)

--turn off Q (ex mode)
keymap('n', 'Q', '<nop>', opts)
keymap("c", "Q", "q", { noremap = true, silent = false })

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv^", opts)
keymap("v", ">", ">gv^", opts)

-- Move text up and down
keymap("v", "J", ":m '>+1<CR>gv=gv", opts)
keymap("v", "K", ":m '<-2<CR>gv=gv", opts)
keymap("v", "p", '"_dP', opts)

-- Better paste
keymap("v", "p", '"_dP', opts)

-- Open link under cursor
keymap("", "gx", '<Cmd>call jobstart(["xdg-open", expand("<cfile>")], {"detach": v:true})<CR>', {})
