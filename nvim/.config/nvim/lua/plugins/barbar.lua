local M = {
  "romgrk/barbar.nvim",
  dependencies = "nvim-tree/nvim-web-devicons",
  event = "VeryLazy",
}

function M.config()
  local bufferline = require("bufferline")

  bufferline.setup({
    animation = true,
    auto_hide = false,
    tabpages = true,
    closable = true,
    clickable = true,
    diagnostics = {
      [vim.diagnostic.severity.ERROR] = { enabled = true, icon = ' ' },
      [vim.diagnostic.severity.WARN] = { enabled = false },
      [vim.diagnostic.severity.INFO] = { enabled = false },
      [vim.diagnostic.severity.HINT] = { enabled = true },
    },
    exclude_ft = { 'javascript' },
    exclude_name = { 'package.json' },
    icons = 'both',
    icon_custom_colors = false,
    icon_separator_active = '▎',
    icon_separator_inactive = '▎',
    icon_close_tab = '',
    icon_close_tab_modified = '●',
    icon_pinned = '車',
    insert_at_end = false,
    insert_at_start = false,
    maximum_padding = 1,
    maximum_length = 30,
    semantic_letters = true,
    letters = 'asdfjkl;ghnmxcvbziowerutyqpASDFJKLGHNMXCVBZIOWERUTYQP',
    no_name_title = nil,
  })
end

function M.init()

  -- Keymaps
  local keymap = require('util').keymap

  -- Move to previous/next
  keymap('n', '<A-,>', '<cmd>BufferPrevious<CR>')
  keymap('n', '<A-.>', '<cmd>BufferNext<CR>')
  keymap("n", "<C-l>", "<cmd>bnext<CR>")
  keymap("n", "<C-h>", "<cmd>bprevious<CR>")
  keymap("n", "]b", "<cmd>bnext<CR>", {desc = "Next Buffer"})
  keymap("n", "[b", "<cmd>bprevious<CR>", {desc = "Previous Buffer"})
  keymap("n", "<leader>bc", "<cmd>BufferClose!<CR>", {desc = "Close Buffer"})
  keymap("n", "<leader>be", "<cmd>BufferCloseAllButCurrent<CR>", {desc = "Close All But Current Buffer"})

  -- Re-order to previous/next
  keymap('n', '<A-<>', '<cmd>BufferMovePrevious<CR>')
  keymap('n', '<A->>', '<cmd>BufferMoveNext<CR>')

  -- Goto buffer in position...
  keymap('n', '<A-1>', '<cmd>BufferGoto 1<CR>')
  keymap('n', '<A-2>', '<cmd>BufferGoto 2<CR>')
  keymap('n', '<A-3>', '<cmd>BufferGoto 3<CR>')
  keymap('n', '<A-4>', '<cmd>BufferGoto 4<CR>')
  keymap('n', '<A-5>', '<cmd>BufferGoto 5<CR>')
  keymap('n', '<A-6>', '<cmd>BufferGoto 6<CR>')
  keymap('n', '<A-7>', '<cmd>BufferGoto 7<CR>')
  keymap('n', '<A-8>', '<cmd>BufferGoto 8<CR>')
  keymap('n', '<A-9>', '<cmd>BufferGoto 9<CR>')
  keymap('n', '<A-0>', '<cmd>BufferLast<CR>')

  -- Close buffer
  keymap('n', '<A-c>', '<cmd>BufferClose<CR>')
end

return M
