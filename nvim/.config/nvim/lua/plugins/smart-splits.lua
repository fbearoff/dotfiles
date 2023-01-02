local M = {
  "mrjones2014/smart-splits.nvim",
  enabled = true,
  event = "BufReadPost",
}

function M.config()
  require('smart-splits').setup({
    ignored_filetypes = {
      'nofile',
      'quickfix',
      'prompt',
    },
    ignored_buftypes = { 'NvimTree' },
    move_cursor_same_row = true,
  })

  vim.keymap.set({ 'n', 'i' }, '<A-h>', require('smart-splits').move_cursor_left)
  vim.keymap.set({ 'n', 'i' }, '<A-j>', require('smart-splits').move_cursor_down)
  vim.keymap.set({ 'n', 'i' }, '<A-k>', require('smart-splits').move_cursor_up)
  vim.keymap.set({ 'n', 'i' }, '<A-l>', require('smart-splits').move_cursor_right)

  -- Resize with arrows
  vim.keymap.set({ 'n', 'i' }, '<C-Left>', require('smart-splits').resize_left)
  vim.keymap.set({ 'n', 'i' }, '<C-Down>', require('smart-splits').resize_down)
  vim.keymap.set({ 'n', 'i' }, '<C-Up>', require('smart-splits').resize_up)
  vim.keymap.set({ 'n', 'i' }, '<C-Right>', require('smart-splits').resize_right)
end

return M
