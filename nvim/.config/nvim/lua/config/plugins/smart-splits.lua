local M = {
  "mrjones2014/smart-splits.nvim",
  enabled = true,
  event = "VeryLazy",
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

  vim.keymap.set('n', '<A-h>', require('smart-splits').move_cursor_left)
  vim.keymap.set('n', '<A-j>', require('smart-splits').move_cursor_down)
  vim.keymap.set('n', '<A-k>', require('smart-splits').move_cursor_up)
  vim.keymap.set('n', '<A-l>', require('smart-splits').move_cursor_right)

  -- Resize with arrows
  vim.keymap.set('n', '<C-Left>', require('smart-splits').resize_left)
  vim.keymap.set('n', '<C-Down>', require('smart-splits').resize_down)
  vim.keymap.set('n', '<C-Up>', require('smart-splits').resize_up)
  vim.keymap.set('n', '<C-Right>', require('smart-splits').resize_right)
end

return M
