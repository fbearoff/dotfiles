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
    ["<gK>"] = { "<cmd>lua vim.lsp.buf.signature_help()<CR>", "Signature Help", mode = { "n", "i" } },
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
    ["gl"] = { vim.diagnostic.open_float, "Open float" },
    ["gm"] = { format_range_operator, "Format Range", mode = { "n", "v" }, },
    ["<leader>"] = {
      c = { name = "Code",
        { cond = client.name == "r_language_server",
          [":"] = { ":RSend ", "RSend" },
          b     = { "<Plug>RSPlot", "Plot and Summary" },
          e     = { "<Plug>RShowEx", "Show Example" },
          f     = { "<Plug>RStart", "Start R" },
          H     = { "<cmd>:RHelp<cr>", "Online Help" },
          h     = { "<Plug>RHelp", "Help" },
          I     = { "<cmd>lua require 'util'.R_install()<CR>", "Install Package" },
          k     = { "<cmd>call RAction('levels')<CR>", "View Levels" },
          L     = { "<Plug>RListSpace", "List Space" },
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
        { cond = client.name == "marksman",
          b = { 'o```{r}<cr>```<esc>O', "Insert R Code block" },
          B = { 'o```{python}<cr>```<esc>O', "Insert Python Code Block" },
          f = { "<cmd>FeMaco<cr>", "FeMaco" },
          g = { "<cmd>Glow<cr>", "Glow" },
          p = {
            function()
              local peek = require("peek")
              if peek.is_open() then
                peek.close()
              else
                peek.open()
              end
            end, "Peek"
          },
          q = {
            name = 'Quarto',
            p = { ":lua require'quarto'.quartoPreview()<cr>", 'Preview' },
            q = { ":lua require'quarto'.quartoClosePreview()<cr>", 'Close' },
            h = { ":QuartoHelp ", 'Help' },
            e = { ":lua require'otter'.export()<cr>", 'Export' },
            E = { ":lua require'otter'.export(true)<cr>", 'Export Overwrite' },
          },
        },
        m = { "<cmd>lua require('codewindow').toggle_minimap()<cr>", "Toggle Minimap" },
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
        l = { name = "LSP",
          i = { "<cmd>LspInfo<cr>", "Lsp Info" },
          a = { "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", "Add Folder" },
          r = { "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", "Remove Folder" },
          l = { "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", "List Folders" },
          m = { "<cmd>Mason<cr>", "Mason" },
          s = { "<cmd>SymbolsOutline<cr>", "Symbols Outline" },
        },
      },
      s = {
        d = { "<cmd>Telescope diagnostics<cr>", "Search Diagnostics" },
      },
      t = { name = "Trouble",
        t = { "<cmd>TroubleToggle<cr>", "Trouble" },
        w = { "<cmd>TroubleToggle workspace_diagnostics<cr>", "Workspace" },
        d = { "<cmd>TroubleToggle document_diagnostics<cr>", "Document" },
        q = { "<cmd>TroubleToggle quickfix<cr>", "Quickfix" },
        l = { "<cmd>TroubleToggle loclist<cr>", "Loclist" },
        r = { "<cmd>TroubleToggle lsp_references<cr>", "References" },
      },
    },
    g = { name = "Goto",
      d = { "<cmd>Telescope lsp_definitions<cr>", "Goto Definition" },
      r = { "<cmd>Telescope lsp_references<cr>", "References" },
      R = { "<cmd>Trouble lsp_references<cr>", "Trouble References" },
      D = { vim.lsp.buf.declaration, "Goto Declaration" },
      -- D = { "<cmd>Telescope lsp_declarations<CR>", "Goto Declaration" },
      I = { "<cmd>Telescope lsp_implementations<CR>", "Goto Implementation" },
      t = { "<cmd>Telescope lsp_type_definitions<cr>", "Goto Type Definition" },
    },
  }

  wk.register(keymap)
end

return M
