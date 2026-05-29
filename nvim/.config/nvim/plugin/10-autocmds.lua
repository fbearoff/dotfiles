-- Check if we need to reload the file when it changed
vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
  callback = function()
    if vim.o.buftype ~= "nofile" then
      vim.cmd("checktime")
    end
  end,
})

-- Resize splits if window got resized
vim.api.nvim_create_autocmd({ "VimResized" }, {
  callback = function()
    local current_tab = vim.fn.tabpagenr()
    vim.cmd("tabdo wincmd =")
    vim.cmd("tabnext " .. current_tab)
  end,
})

-- Create directories when needed, when saving a file
vim.api.nvim_create_autocmd("BufWritePre", {
  group = vim.api.nvim_create_augroup("auto_create_dir", { clear = true }),
  callback = function(event)
    if event.match:match("^%w%w+://") then
      return
    end
    local file = vim.uv.fs_realpath(event.match) or event.match

    vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
    local backup = vim.fn.fnamemodify(file, ":p:~:h")
    backup = backup:gsub("[/\\]", "%%")
    vim.go.backupext = backup
  end,
})

-- Go to last loc when opening a buffer
vim.api.nvim_create_autocmd("BufReadPost", {
  callback = function()
    local exclude = { "gitcommit" }
    local buf = vim.api.nvim_get_current_buf()
    if vim.tbl_contains(exclude, vim.bo[buf].filetype) then
      return
    end
    local mark = vim.api.nvim_buf_get_mark(buf, '"')
    local lcount = vim.api.nvim_buf_line_count(buf)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- q to quit these filetypes
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = {
    "checkhealth",
    "help",
    "lspinfo",
    "man",
    "notify",
    "qf",
    "gitsigns-blame",
    "nvim-pack",
    "nvim-undotree",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
  end,
})

-- Terminal options
vim.api.nvim_create_autocmd({ "TermOpen" }, {
  pattern = "",
  callback = function()
    vim.api.nvim_command("startinsert")
    vim.opt_local.listchars = {}
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.opt_local.cursorline = false
    vim.opt_local.signcolumn = "no"
  end,
})

-- turn on spelling
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "gitcommit", "markdown" },
  callback = function()
    vim.opt_local.spell = true
  end,
})

-- open help in vertical split
vim.api.nvim_create_autocmd("FileType", {
  pattern = "help",
  command = "wincmd L",
})

-- show cursor line only in active window
local cursorline_augroup = vim.api.nvim_create_augroup("cursorline-active-window", { clear = true })
vim.api.nvim_create_autocmd("WinEnter", {
  group = cursorline_augroup,
  callback = function()
    local win = vim.api.nvim_get_current_win()
    -- Schedule to preserve the correct order of events when synchronously
    -- changing between windows a bunch of times (like in `<c-w>t`)
    vim.schedule(function()
      if not vim.api.nvim_win_is_valid(win) then
        return
      end
      if not vim.w[win].cached_cursorline then
        return
      end

      vim.wo[win].cursorline = vim.w[win].cached_cursorline
      vim.w[win].cached_cursorline = nil
    end)
  end,
})
vim.api.nvim_create_autocmd("WinLeave", {
  group = cursorline_augroup,
  callback = function()
    local win = vim.api.nvim_get_current_win()
    -- Copying the current window options seems to be done after `WinLeave`
    -- when opening a new tab. Delay setting `cursorline` to `false` until
    -- after the options are copied
    vim.schedule(function()
      if not vim.api.nvim_win_is_valid(win) then
        return
      end
      vim.w[win].cached_cursorline = vim.wo[win].cursorline
      vim.wo[win].cursorline = false
    end)
  end,
})
