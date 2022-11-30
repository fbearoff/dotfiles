local opts = { noremap = true, silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

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

-- Normal --
-- Better window navigation
keymap('i', '<A-h>', '<C-\\><C-N><C-w>h', opts)
keymap('i', '<A-j>', '<C-\\><C-N><C-w>j', opts)
keymap('i', '<A-k>', '<C-\\><C-N><C-w>k', opts)
keymap('i', '<A-l>', '<C-\\><C-N><C-w>l', opts)

-- --Remap for dealing with word wrap CURRENTLY CAUSES FLICKER WHEN 'cmdheight=0'
-- keymap('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
-- keymap('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- H and L go to begining/end of line
keymap('n', 'H', '^', opts)
keymap('n', 'L', '$', opts)

--turn off Q
keymap('n', 'Q', '<nop>', opts)
keymap("c", "Q", "q", { noremap = true, silent = false })

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)
keymap("v", "p", '"_dP', opts)

-- Better paste
keymap("v", "p", '"_dP', opts)

--Barbar
-- Move to previous/next
keymap('n', '<A-,>', ':BufferPrevious<CR>', opts)
keymap('n', '<A-.>', ':BufferNext<CR>', opts)
keymap("n", "<C-l>", ":bnext<CR>", opts)
keymap("n", "<C-h>", ":bprevious<CR>", opts)
-- Re-order to previous/next
keymap('n', '<A-<>', ':BufferMovePrevious<CR>', opts)
keymap('n', '<A->>', ':BufferMoveNext<CR>', opts)
-- Goto buffer in position...
keymap('n', '<A-1>', ':BufferGoto 1<CR>', opts)
keymap('n', '<A-2>', ':BufferGoto 2<CR>', opts)
keymap('n', '<A-3>', ':BufferGoto 3<CR>', opts)
keymap('n', '<A-4>', ':BufferGoto 4<CR>', opts)
keymap('n', '<A-5>', ':BufferGoto 5<CR>', opts)
keymap('n', '<A-6>', ':BufferGoto 6<CR>', opts)
keymap('n', '<A-7>', ':BufferGoto 7<CR>', opts)
keymap('n', '<A-8>', ':BufferGoto 8<CR>', opts)
keymap('n', '<A-9>', ':BufferGoto 9<CR>', opts)
keymap('n', '<A-0>', ':BufferLast<CR>', opts)
-- Close buffer
keymap('n', '<A-c>', ':BufferClose<CR>', opts)

-- --Beacon
-- vim.keymap.set('n', '<leader>b', ':Beacon<CR>')

-- --Nvim-R
keymap('n', '<leader><Space>', '<Plug>RDSendLine', opts)
keymap('v', '<leader><Space>', '<Plug>RDSendSelection', opts)
keymap('n', '<LocalLeader>:', ':RSend ', opts)

-- Open link under cursor
keymap("", "gx", '<Cmd>call jobstart(["xdg-open", expand("<cfile>")], {"detach": v:true})<CR>', {})

-- DAP
keymap("n", "<leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<cr>", opts)
keymap("n", "<leader>dc", "<cmd>lua require'dap'.continue()<cr>", opts)
keymap("n", "<leader>di", "<cmd>lua require'dap'.step_into()<cr>", opts)
keymap("n", "<leader>do", "<cmd>lua require'dap'.step_over()<cr>", opts)
keymap("n", "<leader>dO", "<cmd>lua require'dap'.step_out()<cr>", opts)
keymap("n", "<leader>dr", "<cmd>lua require'dap'.repl.toggle()<cr>", opts)
keymap("n", "<leader>dl", "<cmd>lua require'dap'.run_last()<cr>", opts)
keymap("n", "<leader>du", "<cmd>lua require'dapui'.toggle()<cr>", opts)
keymap("n", "<leader>dt", "<cmd>lua require'dap'.terminate()<cr>", opts)
