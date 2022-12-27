local wk = require("which-key")

local M = {}

function M.setup(client, buffer)
  local cap = client.server_capabilities

  local keymap = {
    buffer = buffer,
    ["<leader>"] = {
      c = {
        name = "+code",
        {
          cond = client.name == "r_language_server",
           [":"] = { ":RSend ", "RSend" },
    b     = { "<Plug>RSPlot", "Plot and Summary" },
    e     = { "<Plug>RShowEx", "Show Example" },
    f     = { "<Plug>RStart", "Start R" },
    H     = { "<cmd>:RHelp<cr>", "Online Help" },
    h     = { "<Plug>RHelp", "Help" },
    -- I     = { "<cmd>lua require 'user.functions'.R_install()<CR>", "Install Package" },
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
        f = {
          {
            require("config.plugins.lsp.formatting").format,
            "Format Document",
            cond = cap.documentFormatting,
          },
          {
            require("config.plugins.lsp.formatting").format,
            "Format Range",
            cond = cap.documentRangeFormatting,
            mode = "v",
          },
        },
        d = { vim.diagnostic.open_float, "Line Diagnostics" },
        l = {
          name = "+lsp",
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
      name = "+goto",
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
  }

  wk.register(keymap)
end

return M
