vim.pack.add({
  "https://github.com/smjonas/inc-rename.nvim",
  "https://github.com/petertriho/nvim-scrollbar",
  "https://github.com/SmiteshP/nvim-navic",
  "https://github.com/kosayoda/nvim-lightbulb",
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
  icons = require("icons").kinds,
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
