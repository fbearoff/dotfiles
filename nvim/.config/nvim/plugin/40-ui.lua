vim.pack.add({
  "https://github.com/smjonas/inc-rename.nvim",
  "https://github.com/kosayoda/nvim-lightbulb",
  "https://github.com/nvim-mini/mini.icons",
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

-- icon set
require("mini.icons").setup()
require("mini.icons").mock_nvim_web_devicons()

-- UI to rename items incrementally
require("inc_rename").setup()
vim.keymap.set("n", "<leader>cr", function()
  return ":IncRename " .. vim.fn.expand("<cword>")
end, { expr = true, desc = "Rename" })
vim.keymap.set("n", "grn", function()
  return ":IncRename " .. vim.fn.expand("<cword>")
end, { expr = true, desc = "Rename" })

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
