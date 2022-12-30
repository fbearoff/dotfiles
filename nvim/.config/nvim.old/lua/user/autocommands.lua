vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "qf", "help", "man", "lspinfo", "spectre_panel" },
  callback = function()
    vim.cmd([[
      nnoremap <silent> <buffer> q :close<CR>
      set nobuflisted
    ]])
  end,
})

vim.api.nvim_create_autocmd({ "TextYankPost" }, {
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 200 })
  end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "gitcommit", "markdown" },
  callback = function()
    vim.opt_local.spell = true
  end,
})

vim.api.nvim_create_autocmd({ "TermOpen" }, {
  pattern = '',
  callback = function()
    vim.cmd([[
      startinsert
      setlocal listchars= nonumber norelativenumber nocursorline signcolumn=no
      ]])
  end,
})
