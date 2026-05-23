-- Insert --
vim.keymap.set("i", "<M-BS>", "<Esc>cvb", { desc = "Delete Word Before Cursor" })
-- Add undo break-points
vim.keymap.set("i", ",", ",<c-g>u")
vim.keymap.set("i", ".", ".<c-g>u")
vim.keymap.set("i", ";", ";<c-g>u")

-- Home row navigation
vim.keymap.set("i", "<C-h>", "<left>", { desc = "Move Cursor Left" })
vim.keymap.set("i", "<C-l>", "<right>", { desc = "Move Cursor Right" })
vim.keymap.set("i", "<C-j>", "<down>", { desc = "Move Cursor Down" })
vim.keymap.set("i", "<C-k>", "<up>", { desc = "Move Cursor Up" })

-- Normal --
-- movement between buffers
vim.keymap.set("n", "<leader>h", "<C-w>h", { desc = "Go to Left Window" })
vim.keymap.set("n", "<leader>j", "<C-w>j", { desc = "Go to Lower Window" })
vim.keymap.set("n", "<leader>k", "<C-w>k", { desc = "Go to Upper Window" })
vim.keymap.set("n", "<leader>l", "<C-w>l", { desc = "Go to Right Window" })

vim.keymap.set("n", "<s-tab>", "<cmd>bn<CR>", { desc = "Buffer Next" })
vim.keymap.set("n", "<tab>", "<C-w>w", { desc = "Next window" })

-- Resize window using <ctrl> arrow keys
vim.keymap.set("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
vim.keymap.set("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
vim.keymap.set("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })
vim.keymap.set("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })

-- Remap for dealing with word wrap
vim.keymap.set({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- H and L go to begining/end of line
vim.keymap.set("n", "H", "^", { desc = "Go to Beginning of Line" })
vim.keymap.set("n", "L", "$", { desc = "Go to End of Line" })

-- Keep cursor in place when joining lines
vim.keymap.set("n", "J", "m`J``", { desc = "Keep Cursor in Place When Joining Lines" })

-- Center cursor when scrolling page
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll Down and Center Page" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll Up and Center Page" })

-- Move lines up and down
vim.keymap.set("n", "<M-j>", function()
  return ":<C-U>m +" .. vim.v.count1 .. "<CR>"
end, { expr = true, desc = "Move Line Down" })

vim.keymap.set("n", "<M-k>", function()
  return ":<C-U>m -" .. vim.v.count1 + 1 .. "<CR>"
end, { expr = true, desc = "Move Line Down" })

vim.keymap.set("v", "<M-j>", function()
  return ":m '>+" .. vim.v.count1 .. "<CR>gv=gv"
end, { expr = true, desc = "Move Selected Lines Down" })
vim.keymap.set("v", "<M-k>", function()
  return ":m '<-" .. vim.v.count1 + 1 .. "<CR>gv=gv"
end, { expr = true, desc = "Move Selected Lines Down" })

-- Substitute word under cursor
vim.keymap.set("n", "gsw", ":%s/<C-r><C-w>//g<left><left>", { desc = "Substitute Word under Cursor" })
vim.keymap.set("n", "gsW", ":s/<C-r><C-w>//g<left><left>", { desc = "Substitute Word under Cursor (Current Line)" })

-- Reselect latest changed, put, or yanked text
vim.keymap.set(
  "n",
  "gV",
  '"`[" . strpart(getregtype(), 0, 1) . "`]"',
  { expr = true, desc = "Visually Select Changed Text" }
)

-- Correct latest misspelled word by taking first suggestion
vim.keymap.set("n", "<C-z>", "[s1z=", { desc = "Correct Latest Misspelled Word" })
vim.keymap.set("i", "<C-z>", "<C-g>u<Esc>[s1z=`]a<C-g>u", { desc = "Correct Latest Misspelled Word" })

-- Keep search term in the middle of screen
vim.keymap.set("n", "n", "nzzzv", { desc = "Next Search Item" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous Search Item" })

-- Select whole line
vim.keymap.set("n", "vv", "V", { desc = "Select Whole Line" })

-- Silence undo/redo
vim.keymap.set("n", "u", ":silent undo<cr>")
vim.keymap.set("n", "U", ":silent redo<cr>")

-- Visual --
-- Stay in indent mode
vim.keymap.set("v", "<", "<gv^", { desc = "Shift Selection Left" })
vim.keymap.set("v", ">", ">gv^", { desc = "Shift Selection Right" })

-- Better paste
vim.keymap.set("v", "p", '"_dP', { desc = "Paste Over Selection" })

-- Remap marks operator
vim.keymap.set("n", "gm", "m", { desc = "Set Mark" })

-- Send deletions to blackhole register
for _, lhs in ipairs({ "c", "C", "d", "D", "x", "X" }) do
  vim.keymap.set({ "n", "x" }, lhs, '"_' .. lhs, { desc = "which_key_ignore" })
end

-- Map "d" cut action to cut key
local cut_key = "m"

vim.keymap.set({ "n", "x" }, cut_key, "d", { desc = "Cut Operator" })
vim.keymap.set("n", cut_key .. cut_key, "dd", { desc = "Cut Line" })
vim.keymap.set("n", string.upper(cut_key), "D", { desc = "Cut To EOL" })

-- Clear search with <esc>
vim.keymap.set({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and Clear Hlsearch" })

-- Leader Mappings --
vim.keymap.set("n", "<leader>p", function()
  vim.pack.update()
end, { desc = "Pack" })
vim.keymap.set("n", "<leader>r", "<cmd>restart<CR>", { desc = "Restart" })
vim.keymap.set("x", "<leader>S", ":sort<CR>", { desc = "Sort" })
vim.keymap.set("x", "<leader>U", ":sort u<CR>", { desc = "Sort Unique" })

-- Splits
vim.keymap.set("n", "<leader>-", "<cmd>split<CR>", { desc = "Split" })
vim.keymap.set("n", "<leader>\\", "<cmd>vsplit<CR>", { desc = "VSplit" })

-- Core file commands
vim.keymap.set("n", "<leader>fn", "<cmd>enew<CR>", { desc = "New File" })
vim.keymap.set("n", "<leader>w", "<cmd>silent w!<CR>", { desc = "Save" })

vim.keymap.set("n", "<leader>bm", "<cmd>delmark!<cr>", { desc = "Delete Marks" })

vim.keymap.set("n", "<leader>U", function()
  vim.cmd("packadd nvim.undotree")
  require("undotree").open({
    command = math.floor(vim.api.nvim_win_get_width(0) / 3) .. "vnew",
  })
end, { desc = "Undotree" })
