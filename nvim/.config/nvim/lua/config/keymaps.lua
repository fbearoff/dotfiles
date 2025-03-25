local function keymap(mode, lhs, rhs, opts)
  local keys = require("lazy.core.handler").handlers.keys
  local modes = type(mode) == "string" and { mode } or mode

  modes = vim.tbl_filter(function(mode)
    return not (keys.have and keys:have(lhs, mode))
  end, modes)

  -- do not create the keymap if a lazy keys handler exists
  if #modes > 0 then
    opts = opts or {}
    opts.silent = opts.silent ~= false
    vim.keymap.set(modes, lhs, rhs, opts)
  end
end

-- Insert --
keymap("i", "<M-BS>", "<Esc>cvb", { desc = "Delete Word Before Cursor" })
-- Add undo break-points
keymap("i", ",", ",<c-g>u")
keymap("i", ".", ".<c-g>u")
keymap("i", ";", ";<c-g>u")

-- Home row navigation
keymap("i", "<C-h>", "<left>", { desc = "Move Cursor Left" })
keymap("i", "<C-l>", "<right>", { desc = "Move Cursor Right" })
keymap("i", "<C-j>", "<down>", { desc = "Move Cursor Down" })
keymap("i", "<C-k>", "<up>", { desc = "Move Cursor Up" })

-- Normal --
-- movement between buffers
keymap("n", "<s-tab>", function()
  vim.cmd("bn")
end, { desc = "Buffer Next" })
keymap("n", "<tab>", "<C-w>w", { desc = "Next window" })

-- Remap for dealing with word wrap
keymap({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
keymap({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Insert newline without leaving Normal mode
keymap("n", "gO", "<Cmd>call append(line('.') - 1, repeat([''], v:count1))<CR>", { desc = "Insert Newline Above" })
keymap("n", "go", "<Cmd>call append(line('.'),     repeat([''], v:count1))<CR>", { desc = "Insert Newline Below" })

-- Change word with <c-c>
keymap("n", "<C-c>", "<cmd>normal! ciw<cr>a", { desc = "Change Inner Word" })

-- H and L go to begining/end of line
keymap("n", "H", "^", { desc = "Go to Beginning of Line" })
keymap("n", "L", "$", { desc = "Go to End of Line" })

-- Keep cursor in place when joining lines
keymap("n", "J", "m`J``", { desc = "Keep Cursor in Place When Joining Lines" })

-- Center cursor when scrolling page
keymap("n", "<C-d>", "<C-d>zz", { desc = "Scroll Down and Center Page" })
keymap("n", "<C-u>", "<C-u>zz", { desc = "Scroll Up and Center Page" })

-- Reselect latest changed, put, or yanked text
keymap("n", "gV", '"`[" . strpart(getregtype(), 0, 1) . "`]"', { expr = true, desc = "Visually Select Changed Text" })

-- Correct latest misspelled word by taking first suggestion
keymap("n", "<C-z>", "[s1z=", { desc = "Correct Latest Misspelled Word" })
keymap("i", "<C-z>", "<C-g>u<Esc>[s1z=`]a<C-g>u", { desc = "Correct Latest Misspelled Word" })

-- Keep search term in the middle of screen
keymap("n", "n", "nzzzv", { desc = "Next Search Item" })
keymap("n", "N", "Nzzzv", { desc = "Previous Search Item" })

-- Select whole line
keymap("n", "vv", "V", { desc = "Select Whole Line" })

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv^", { desc = "Shift Selection Left" })
keymap("v", ">", ">gv^", { desc = "Shift Selection Right" })

-- Better paste
keymap("v", "p", '"_dP', { desc = "Paste Over Selection" })

-- Send deletions to blackhole register
for _, lhs in ipairs({ "c", "C", "d", "D", "x", "X" }) do
  keymap({ "n", "x" }, lhs, '"_' .. lhs, { desc = "which_key_ignore" })
end

-- Map "d" cut action to cut key
local cut_key = "m"

keymap({ "n", "x" }, cut_key, "d", { desc = "Cut Operator" })
keymap("n", cut_key .. cut_key, "dd", { desc = "Cut Line" })
keymap("n", string.upper(cut_key), "D", { desc = "Cut To EOL" })

-- Clear search with <esc>
keymap({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and Clear Hlsearch" })

-- Leader Mappings
-- Splits
keymap("n", "<leader>-", "<cmd>split<CR>", { desc = "Split" })
keymap("n", "<leader>\\", "<cmd>vsplit<CR>", { desc = "VSplit" })

-- Core file commands
keymap("n", "<leader>fn", "<cmd>enew<CR>", { desc = "New File" })
keymap("n", "<leader>q", "<cmd>q<CR>", { desc = "Quit" })
keymap("n", "<leader>w", "<cmd>w!<CR>", { desc = "Save" })

-- Quickfix/Location list
keymap("n", "<leader>dl", "<cmd>lopen<cr>", { desc = "Location List" })
keymap("n", "<leader>dq", "<cmd>copen<cr>", { desc = "Quickfix List" })

-- Lazy
keymap("n", "<leader>L", "<cmd>Lazy<CR>", { desc = "Lazy" })

-- highlights under cursor
keymap("n", "<leader>sH", vim.show_pos, { desc = "Highlight Groups" })

-- View Code Tree
keymap("n", "<leader>si", "<cmd>InspectTree<cr>", { desc = "Inspect Tree" })
