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

return {
  -- UI to rename items incrementally
  {
    "smjonas/inc-rename.nvim",
    cmd = "IncRename",
    keys = {
      {
        "<leader>cr",
        function()
          return ":IncRename " .. vim.fn.expand("<cword>")
        end,
        expr = true,
        desc = "Rename",
      },
      {
        "grn",
        function()
          return ":IncRename " .. vim.fn.expand("<cword>")
        end,
        expr = true,
        desc = "Rename",
      },
    },
    opts = {},
  },

  -- Scrollbar
  {
    "petertriho/nvim-scrollbar",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
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
    },
  },

  -- Show code context
  {
    "SmiteshP/nvim-navic",
    opts = {
      highlight = true,
      depth_limit = 5,
      icons = require("config.icons").kinds,
      safe_output = true,
      lazy_update_context = true,
      lsp = {
        auto_attach = true,
      },
    },
  },

  -- Show available code actions as lightbulb character
  {
    "kosayoda/nvim-lightbulb",
    opts = {
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
    },
    event = "BufReadPost",
  },

  -- Bufferline
  {
    "romgrk/barbar.nvim",
    event = "VeryLazy",
    keys = {
      { "<M-,>", "<cmd>BufferPrevious<CR>", desc = "Previous Buffer" },
      { "<M-.>", "<cmd>BufferNext<CR>", desc = "Next Buffer" },
      { "]b", "<cmd>BufferNext<CR>", desc = "Next Buffer" },
      { "[b", "<cmd>BufferPrevious<CR>", desc = "Previous Buffer" },
      { "]B", "<cmd>BufferLast<CR>", desc = "Last Buffer" },
      { "[B", "<cmd>BufferFirst<CR>", desc = "First Buffer" },
      { "<leader>bc", "<cmd>BufferClose!<CR>", desc = "Close Buffer" },
      { "<leader>be", "<cmd>BufferCloseAllButCurrent<CR>", desc = "Close All But Current Buffer" },
      { "<M-<>", "<cmd>BufferMovePrevious<CR>", desc = "Move Buffer Left" },
      { "<M->>", "<cmd>BufferMoveNext<CR>", desc = "Move Buffer Right" },
      { "<M-1>", "<cmd>BufferGoto 1<CR>", desc = "Buffer 1" },
      { "<M-2>", "<cmd>BufferGoto 2<CR>", desc = "Buffer 2" },
      { "<M-3>", "<cmd>BufferGoto 3<CR>", desc = "Buffer 3" },
      { "<M-4>", "<cmd>BufferGoto 4<CR>", desc = "Buffer 4" },
      { "<M-5>", "<cmd>BufferGoto 5<CR>", desc = "Buffer 5" },
      { "<M-6>", "<cmd>BufferGoto 6<CR>", desc = "Buffer 6" },
      { "<M-7>", "<cmd>BufferGoto 7<CR>", desc = "Buffer 7" },
      { "<M-8>", "<cmd>BufferGoto 8<CR>", desc = "Buffer 8" },
      { "<M-9>", "<cmd>BufferGoto 9<CR>", desc = "Buffer 9" },
      { "<M-0>", "<cmd>BufferLast<CR>", desc = "Last Buffer" },
      { "<M-c>", "<cmd>BufferClose<CR>", desc = "Close Buffer" },
    },
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
  },

  -- icons
  "nvim-tree/nvim-web-devicons",
}
