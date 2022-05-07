--Remap leader keys
vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'

--Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

--don't lose selection when shfting text
vim.keymap.set('x', '<', '<gv', { noremap = true })
vim.keymap.set('x', '>', '>gv', { noremap = true })

--navigate windows with ALT+{h,j,k,l}
vim.keymap.set('t', '<A-h>', '<C-\\><C-N><C-w>h', { noremap = true })
vim.keymap.set('t', '<A-j>', '<C-\\><C-N><C-w>j', { noremap = true })
vim.keymap.set('t', '<A-k>', '<C-\\><C-N><C-w>k', { noremap = true })
vim.keymap.set('t', '<A-l>', '<C-\\><C-N><C-w>l', { noremap = true })
vim.keymap.set('i', '<A-h>', '<C-\\><C-N><C-w>h', { noremap = true })
vim.keymap.set('i', '<A-j>', '<C-\\><C-N><C-w>j', { noremap = true })
vim.keymap.set('i', '<A-k>', '<C-\\><C-N><C-w>k', { noremap = true })
vim.keymap.set('i', '<A-l>', '<C-\\><C-N><C-w>l', { noremap = true })
vim.keymap.set('n', '<A-h>', '<C-w>h', { noremap = true })
vim.keymap.set('n', '<A-j>', '<C-w>j', { noremap = true })
vim.keymap.set('n', '<A-k>', '<C-w>k', { noremap = true })
vim.keymap.set('n', '<A-l>', '<C-w>l', { noremap = true })

-- H and L go to begining/end of line
vim.keymap.set('n', 'H', '^')
vim.keymap.set('n', 'L', '$')

--better exiting
vim.keymap.set('n', ':Q!', ':quit!')

--easier split creation
vim.keymap.set('n', '<leader>-', ':split<CR>')
vim.keymap.set('n', '<leader>\\', ':vsplit<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)

--Alpha
vim.keymap.set('n', '<leader>a', ':Alpha<CR>')

--Barbar
local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }
-- Move to previous/next
map('n', '<A-,>', ':BufferPrevious<CR>', opts)
map('n', '<A-.>', ':BufferNext<CR>', opts)
-- Re-order to previous/next
map('n', '<A-<>', ':BufferMovePrevious<CR>', opts)
map('n', '<A->>', ' :BufferMoveNext<CR>', opts)
-- Goto buffer in position...
map('n', '<A-1>', ':BufferGoto 1<CR>', opts)
map('n', '<A-2>', ':BufferGoto 2<CR>', opts)
map('n', '<A-3>', ':BufferGoto 3<CR>', opts)
map('n', '<A-4>', ':BufferGoto 4<CR>', opts)
map('n', '<A-5>', ':BufferGoto 5<CR>', opts)
map('n', '<A-6>', ':BufferGoto 6<CR>', opts)
map('n', '<A-7>', ':BufferGoto 7<CR>', opts)
map('n', '<A-8>', ':BufferGoto 8<CR>', opts)
map('n', '<A-9>', ':BufferGoto 9<CR>', opts)
map('n', '<A-0>', ':BufferLast<CR>', opts)
-- Close buffer
map('n', '<A-c>', ':BufferClose<CR>', opts)
-- Wipeout buffer
--                 :BufferWipeout<CR>
-- Magic buffer-picking mode
map('n', '<C-p>', ':BufferPick<CR>', opts)
-- Sort automatically by...
map('n', '<Space>bb', ':BufferOrderByBufferNumber<CR>', opts)
map('n', '<Space>bd', ':BufferOrderByDirectory<CR>', opts)
map('n', '<Space>bl', ':BufferOrderByLanguage<CR>', opts)

--Beacon
vim.keymap.set('n', '<leader>b', ':Beacon<CR>')

--Nvim-R
vim.keymap.set('n', '<leader><Space>', '<Plug>RDSendLine')
vim.keymap.set('v', '<leader><Space>', '<Plug>RDSendSelection')
vim.keymap.set('n', '<LocalLeader>:', ':RSend ')

--Packer
vim.keymap.set('n', '<leader>ps', ':PackerSync<CR>')

--Telescope
vim.keymap.set('n', '<leader>ff', require('telescope.builtin').find_files)
vim.keymap.set('n', '<leader>fb', require('telescope.builtin').current_buffer_fuzzy_find)
vim.keymap.set('n', '<leader>fh', require('telescope.builtin').help_tags)
vim.keymap.set('n', '<leader>fs', require('telescope.builtin').grep_string)
vim.keymap.set('n', '<leader>fg', require('telescope.builtin').live_grep)
vim.keymap.set('n', '<leader>fc', require('telescope.builtin').commands)
vim.keymap.set('n', '<leader>fk', require('telescope.builtin').keymaps)
vim.keymap.set('n', '<leader>ft', function()
  require('telescope.builtin').tags { only_current_buffer = true }
end)
vim.keymap.set('n', '<leader>fr', require('telescope.builtin').oldfiles)

-- vim: ts=2 sts=2 sw=2 et
