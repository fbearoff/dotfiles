local M = {
  "neovim/nvim-lspconfig",
  name = "lsp",
  event = "BufReadPre",
  dependencies = { "hrsh7th/cmp-nvim-lsp" },
}

function M.config()
  require("mason")
  require("config.plugins.lsp.diagnostics").setup()

  local function on_attach(client, bufnr)
    require("nvim-navic").attach(client, bufnr)
    -- require("config.plugins.lsp.formatting").setup(client, bufnr)
    require("config.plugins.lsp.keys").setup(client, bufnr)
  end

  local servers = {
    ansiblels = {},
    bashls = {
      filetypes = { 'sh', 'zsh' },
    },
    html = {},
    marksman = {},
    pyright = {},
    r_language_server = {
      settings = {
        r = {
          lsp = {
            rich_documentation = false
          },
        },
      },
    },
    sumneko_lua = {
      single_file_support = true,
      settings = {
        Lua = {
          workspace = {
            library = {
              [vim.fn.expand "$VIMRUNTIME/lua"] = true,
              [vim.fn.stdpath "config" .. "/lua"] = true,
            },
            diagnostics = {
              globals = { "vim" },
            },
            runtime = {
              version = "LuaJIT"
            },
          },
        },
      },
    },
  }

  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
  capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true,
  }

  local options = {
    on_attach = on_attach,
    capabilities = capabilities,
    flags = {
      debounce_text_changes = 150,
    },
  }

  for server, opts in pairs(servers) do
    opts = vim.tbl_deep_extend("force", {}, options, opts or {})
    require("lspconfig")[server].setup(opts)
  end

  require("config.plugins.null-ls").setup(options)
end

return M
