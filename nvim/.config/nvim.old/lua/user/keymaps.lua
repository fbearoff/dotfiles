-- Keymap helper function
local function keymap(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    if opts['desc'] then
      opts['desc'] = 'keymaps.lua: ' .. opts['desc']
    end
    options = vim.tbl_extend('force', options, opts)
  end
  vim.keymap.set(mode, lhs, rhs, options)
end

--Remap space as leader key
keymap("", "<Space>", "<Nop>", { desc = 'Remove delay on leader press' })
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
keymap('i', '<A-h>', '<C-\\><C-N><C-w>h', { desc = 'Select left window' })
keymap('i', '<A-j>', '<C-\\><C-N><C-w>j', { desc = 'Select lower window' })
keymap('i', '<A-k>', '<C-\\><C-N><C-w>k', { desc = 'Select upper window' })
keymap('i', '<A-l>', '<C-\\><C-N><C-w>l', { desc = 'Select right window' })

-- Home row navigation
keymap('i', '<C-h>', '<left>', { desc = 'Move cursor left' })
keymap('i', '<C-l>', require('user.functions').EscapePair, { desc = 'Move cursor right, escape pair' })
keymap('i', '<C-j>', '<down>', { desc = 'Move cursor down' })
keymap('i', '<C-k>', '<up>', { desc = 'Move cursor up' })

-- Normal --
-- Remap for dealing with word wrap
keymap('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
keymap('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- H and L go to begining/end of line
keymap('n', 'H', '^', { desc = 'Go to beginning of line' })
keymap('n', 'L', '$', { desc = 'Go to end of line' })

-- Keep cursor in place when joing lines
keymap("n", "J", "mzJ`z", { desc = 'Keep cursor in place when joing lines' })

-- Center cursor when scrolling page
keymap("n", "<C-d>", "<C-d>zz", { desc = 'Scroll down and center page' })
keymap("n", "<C-u>", "<C-u>zz", { desc = 'Scroll up and center page' })

-- Keep search term in the middle of screen
keymap("n", "n", "nzzzv", { desc = 'Next search item' })
keymap("n", "N", "Nzzzv", { desc = 'Previous search item' })

--turn off Q (ex mode)
keymap('n', 'Q', '<nop>')
keymap("c", "Q", "q", { noremap = true, silent = false })

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
  { "c", "C", "s", "S", "d", "D", "x", "X" }) do
  keymap({ "n", "x" }, lhs, '"_' .. lhs)
end

-- Map "cut" action to d key
local cut_key = "x"

keymap({ "n", "x" }, cut_key, "d")
keymap("n", cut_key .. cut_key, "dd")
keymap("n", string.upper(cut_key), "D")
