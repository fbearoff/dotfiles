local wk = require("which-key")

local M = {}

function M.setup(client, buffer)


  -- LSP range formatter
  local function format_range_operator()
    local old_func = vim.go.operatorfunc
    _G.op_func_formatting = function()
      local start = vim.api.nvim_buf_get_mark(0, '[')
      local finish = vim.api.nvim_buf_get_mark(0, ']')
      vim.lsp.buf.format({}, start, finish)
      vim.go.operatorfunc = old_func
      _G.op_func_formatting = nil
    end
    vim.go.operatorfunc = 'v:lua.op_func_formatting'
    vim.api.nvim_feedkeys('g@', 'n', false)
  end

  local cap = client.server_capabilities

  local keymap = {
    buffer = buffer,
    ["<leader>"] = {
      c = {
        name = "Code",
        {
          cond  = client.name == "r_language_server",
          [":"] = { ":RSend ", "RSend" },
          b     = { "<Plug>RSPlot", "Plot and Summary" },
          e     = { "<Plug>RShowEx", "Show Example" },
          f     = { "<Plug>RStart", "Start R" },
          H     = { "<cmd>:RHelp<cr>", "Online Help" },
          h     = { "<Plug>RHelp", "Help" },
          I     = { "<cmd>lua require 'util'.R_install()<CR>", "Install Package" },
          k     = { "<cmd>call RAction('levels')<CR>", "View Levels" },
          l     = { "<Plug>RListSpace", "List Space" },
          n     = { "<Plug>RObjectNames", "Print Names" },
          o     = { "<Plug>RUpdateObjBrowser", "Object Browser" },
          p     = { "<Plug>RObjectPr", "Print Object" },
          q     = { "<Plug>RClose", "Close R" },
          S     = { "<cmd>call RAction('head')<CR>", "View Head" },
          s     = { "<Plug>RSummary", "Summary" },
          t     = { "<Plug>RObjectStr", "View Structure" },
          u     = { "<cmd>RSend update.packages(ask = FALSE)<CR>", "Update Packages" },
          v     = { "<Plug>RViewDF", "View Df" },
          w     = { "<Plug>RSaveClose", "Save and Close R" },
        },
        r = {
          function()
            require("inc_rename")
            return ":IncRename " .. vim.fn.expand("<cword>")
          end,
          "Rename",
          cond = cap.renameProvider,
          expr = true,
        },
        a = {
          { vim.lsp.buf.code_action, "Code Action" },
          { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action", mode = "v" },
        },
        d = { vim.diagnostic.open_float, "Line Diagnostics" },
        l = {
          name = "LSP",
          i = { "<cmd>LspInfo<cr>", "Lsp Info" },
          a = { "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", "Add Folder" },
          r = { "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", "Remove Folder" },
          l = { "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", "List Folders" },
        },
      },
      x = {
        d = { "<cmd>Telescope diagnostics<cr>", "Search Diagnostics" },
      },
    },
    g = {
      name = "Goto",
      d = { "<cmd>Telescope lsp_definitions<cr>", "Goto Definition" },
      r = { "<cmd>Telescope lsp_references<cr>", "References" },
      R = { "<cmd>Trouble lsp_references<cr>", "Trouble References" },
      D = { "<cmd>Telescope lsp_declarations<CR>", "Goto Declaration" },
      I = { "<cmd>Telescope lsp_implementations<CR>", "Goto Implementation" },
      t = { "<cmd>Telescope lsp_type_definitions<cr>", "Goto Type Definition" },
    },
    ["<C-k>"] = { "<cmd>lua vim.lsp.buf.signature_help()<CR>", "Signature Help", mode = { "n", "i" } },
    ["K"] = { "<cmd>lua vim.lsp.buf.hover()<CR>", "Hover" },
    ["[d"] = { "<cmd>lua vim.diagnostic.goto_prev()<CR>", "Prev Diagnostic" },
    ["]d"] = { "<cmd>lua vim.diagnostic.goto_next()<CR>", "Next Diagnostic" },
    ["[e"] = { "<cmd>lua vim.diagnostic.goto_prev({severity = vim.diagnostic.severity.ERROR})<CR>", "Prev Error" },
    ["]e"] = { "<cmd>lua vim.diagnostic.goto_next({severity = vim.diagnostic.severity.ERROR})<CR>", "Next Error" },
    ["[w"] = {
      "<cmd>lua vim.diagnostic.goto_prev({severity = vim.diagnostic.severity.WARNING})<CR>",
      "Prev Warning",
    },
    ["]w"] = {
      "<cmd>lua vim.diagnostic.goto_next({severity = vim.diagnostic.severity.WARNING})<CR>",
      "Next Warning",
    },
    ["="] = { "<cmd> lua vim.lsp.buf.format{async=true}<cr>", "Format" },
    ["gm"] = { format_range_operator, "Format Range", mode = { "n", "v" }, }
  }

  wk.register(keymap)
end

return M
