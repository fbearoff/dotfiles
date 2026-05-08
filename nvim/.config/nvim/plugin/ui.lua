vim.pack.add({
  "https://github.com/nvim-tree/nvim-web-devicons",
  "https://github.com/smjonas/inc-rename.nvim",
  "https://github.com/petertriho/nvim-scrollbar",
  "https://github.com/SmiteshP/nvim-navic",
  "https://github.com/kosayoda/nvim-lightbulb",
  "https://github.com/romgrk/barbar.nvim",
})

-- use new ui2 interface
local ui2 = require("vim._core.ui2")
ui2.enable({
  enable = true,
  msg = {
    targets = {
      [""] = "msg",
      empty = "cmd",
      bufwrite = "msg",
      confirm = "cmd",
      emsg = "pager",
      echo = "msg",
      echomsg = "msg",
      echoerr = "pager",
      completion = "cmd",
      list_cmd = "pager",
      lua_error = "pager",
      lua_print = "msg",
      progress = "pager",
      rpc_error = "pager",
      quickfix = "msg",
      search_cmd = "cmd",
      search_count = "cmd",
      shell_cmd = "pager",
      shell_err = "pager",
      shell_out = "pager",
      shell_ret = "msg",
      undo = "msg",
      verbose = "pager",
      wildlist = "cmd",
      wmsg = "msg",
      typed_cmd = "cmd",
    },
    msg = {
      height = 0.3,
      timeout = 3000,
    },
    pager = {
      height = 0.5,
    },
  },
})

-- place messages in top right corner
local msgs = require("vim._core.ui2.messages")
local orig_set_pos = msgs.set_pos
msgs.set_pos = function(tgt)
  orig_set_pos(tgt)
  if (tgt == "msg" or tgt == nil) and vim.api.nvim_win_is_valid(ui2.wins.msg) then
    pcall(vim.api.nvim_win_set_config, ui2.wins.msg, {
      relative = "editor",
      anchor = "NE",
      row = 1,
      col = vim.o.columns - 1,
      border = "rounded",
    })
  end
end

-- UI to rename items incrementally
require("inc_rename").setup()
vim.keymap.set("n", "<leader>cr", function()
  return ":IncRename " .. vim.fn.expand("<cword>")
end, { expr = true, desc = "Rename" })
vim.keymap.set("n", "grn", function()
  return ":IncRename " .. vim.fn.expand("<cword>")
end, { expr = true, desc = "Rename" })
-- Scrollbar
require("scrollbar").setup({
  show_in_active_only = true,
  marks = {
    GitAdd = {
      text = "│",
    },
    GitChange = {
      text = "│",
    },
  },
  excluded_buftypes = {
    "terminal",
    "nofile",
  },
  handlers = {
    gitsigns = true,
  },
})
-- Show code context
require("nvim-navic").setup({
  highlight = true,
  depth_limit = 5,
  icons = require("config.icons").kinds,
  safe_output = true,
  lazy_update_context = true,
  lsp = {
    auto_attach = true,
  },
})

-- Show available code actions as lightbulb character
require("nvim-lightbulb").setup({
  autocmd = {
    enabled = true,
  },
  code_lenses = true,
  sign = {
    enabled = false,
  },
  status_text = {
    enabled = true,
  },
})

-- Bufferline
require("barbar").setup({
  opts = {
    sidebar_filetypes = {
      NvimTree = { text = "NvimTree" },
    },
    tabpages = false,
    icons = {
      buffer_index = true,
    },
    highlight_visible = false,
    maximum_padding = 1,
  },
})

vim.keymap.set("n", "<M-,>", "<cmd>BufferPrevious<CR>", { desc = "Previous Buffer" })
vim.keymap.set("n", "<M-.>", "<cmd>BufferNext<CR>", { desc = "Next Buffer" })
vim.keymap.set("n", "]b", "<cmd>BufferNext<CR>", { desc = "Next Buffer" })
vim.keymap.set("n", "[b", "<cmd>BufferPrevious<CR>", { desc = "Previous Buffer" })
vim.keymap.set("n", "]B", "<cmd>BufferLast<CR>", { desc = "Last Buffer" })
vim.keymap.set("n", "[B", "<cmd>BufferFirst<CR>", { desc = "First Buffer" })
vim.keymap.set("n", "<leader>bc", "<cmd>BufferClose!<CR>", { desc = "Close Buffer" })
vim.keymap.set("n", "<leader>be", "<cmd>BufferCloseAllButCurrent<CR>", { desc = "Close All But Current Buffer" })
vim.keymap.set("n", "<M-<>", "<cmd>BufferMovePrevious<CR>", { desc = "Move Buffer Left" })
vim.keymap.set("n", "<M->>", "<cmd>BufferMoveNext<CR>", { desc = "Move Buffer Right" })
vim.keymap.set("n", "<M-1>", "<cmd>BufferGoto 1<CR>", { desc = "Buffer 1" })
vim.keymap.set("n", "<M-2>", "<cmd>BufferGoto 2<CR>", { desc = "Buffer 2" })
vim.keymap.set("n", "<M-3>", "<cmd>BufferGoto 3<CR>", { desc = "Buffer 3" })
vim.keymap.set("n", "<M-4>", "<cmd>BufferGoto 4<CR>", { desc = "Buffer 4" })
vim.keymap.set("n", "<M-5>", "<cmd>BufferGoto 5<CR>", { desc = "Buffer 5" })
vim.keymap.set("n", "<M-6>", "<cmd>BufferGoto 6<CR>", { desc = "Buffer 6" })
vim.keymap.set("n", "<M-7>", "<cmd>BufferGoto 7<CR>", { desc = "Buffer 7" })
vim.keymap.set("n", "<M-8>", "<cmd>BufferGoto 8<CR>", { desc = "Buffer 8" })
vim.keymap.set("n", "<M-9>", "<cmd>BufferGoto 9<CR>", { desc = "Buffer 9" })
vim.keymap.set("n", "<M-0>", "<cmd>BufferLast<CR>", { desc = "Last Buffer" })
vim.keymap.set("n", "<M-c>", "<cmd>BufferClose<CR>", { desc = "Close Buffer" })
