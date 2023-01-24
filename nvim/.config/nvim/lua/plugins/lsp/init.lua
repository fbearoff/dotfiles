return {
  -- lspconfig
  {
    "neovim/nvim-lspconfig",
    event = "BufReadPre",
    dependencies = {
      "mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      {
        "hrsh7th/cmp-nvim-lsp",
        cond = function()
          require("util").has("nvim-cmp")
        end,
      }
    },
    opts = {
      signs = {
        Error = " ",
        Warn = " ",
        Hint = " ",
        Info = " ",
      },
      capabilities = {
        textDocument = {
          foldingRange = {
            dynamicRegistration = false,
            lineFoldingOnly = true,
          },
        },
      },
      -- Automatically format on save
      autoformat = true,
      -- options for vim.lsp.buf.format
      -- `bufnr` and `filter` is handled by the LazyVim formatter,
      -- but can be also overriden when specified
      format = {
        formatting_options = nil,
        timeout_ms = nil,
      },
      diagnostics = {
        virtual_text = {
          source = 'always',
          prefix = '■',
          severity = {
            min = vim.diagnostic.severity.ERROR,
          },
        },
        underline = {
          severity = {
            min = vim.diagnostic.severity.HINT,
          },
        },
        update_in_insert = false,
        severity_sort = true,
        float = {
          focusable = true,
          style = "minimal",
          border = "rounded",
          source = "always",
          header = "",
          prefix = "",
        },
      },
      servers = {
        -- mason = false, -- set to false if you don't want this server to be installed with mason
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
                rich_documentation = false,
              },
            },
          },
        },
        sumneko_lua = {
          settings = {
            Lua = {
              runtime = {
                version = "LuaJIT"
              },
              workspace = {
                library = {
                  [vim.fn.expand "$VIMRUNTIME/lua"] = true,
                },
                checkThirdParty = false,
                diagnostics = {
                  globals = { "vim" },
                },
              },
              completion = {
                callSnippet = "Replace",
              },
            },
          },
        },
      },
      setup = {
        -- example to setup with typescript.nvim
        -- tsserver = function(_, opts)
        --   require("typescript").setup({ server = opts })
        --   return true
        -- end,
        -- Specify * to use this function as a fallback for any server
        -- ["*"] = function(server, opts) end,
      },
    },
    config = function(plugin, opts)
      if plugin.servers then
        require("lspconfig.opts.servers")
      end
      if plugin.setup_server then
        require("lspconfig.opts.setup[SERVER]")
      end

      -- setup autoformat
      require("plugins.lsp.format").autoformat = opts.autoformat
      -- setup  keymaps
      require("util").on_attach(function(client, buffer)
        require("nvim-navic").attach(client, buffer)
        require("plugins.lsp.format").on_attach(client, buffer)
        require("plugins.lsp.keymaps").on_attach(client, buffer)
      end)

      -- diagnostics
      for name, icon in pairs(opts.signs) do
        name = "DiagnosticSign" .. name
        vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
      end
      vim.diagnostic.config(opts.diagnostics)

      local servers = opts.servers
      local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

      local function setup(server)
        local server_opts = servers[server] or {}
        server_opts.capabilities = capabilities
        if opts.setup[server] then
          if opts.setup[server](server, server_opts) then
            return
          end
        elseif opts.setup["*"] then
          if opts.setup["*"](server, server_opts) then
            return
          end
        end
        require("lspconfig")[server].setup(server_opts)
      end

      local mlsp = require("mason-lspconfig")
      local available = mlsp.get_available_servers()

      local ensure_installed = {}
      for server, server_opts in pairs(servers) do
        if server_opts then
          server_opts = server_opts == true and {} or server_opts
          -- run manual setup if mason=false or if this is a server that cannot be installed with mason-lspconfig
          if server_opts.mason == false or not vim.tbl_contains(available, server) then
            setup(server)
          else
            ensure_installed[#ensure_installed + 1] = server
          end
        end
      end

      require("mason-lspconfig").setup({ ensure_installed = ensure_installed })
      require("mason-lspconfig").setup_handlers({ setup })
    end,
  },

  -- formatters
  {
    "jose-elias-alvarez/null-ls.nvim",
    event = "BufReadPre",
    dependencies = { "mason.nvim" },
    keys = { { "<leader>cN", "<cmd>NullLsInfo<cr>", desc = "Null-LS Info" } },
    opts = function()
      local nls = require("null-ls")
      return {
        sources = {
          nls.builtins.formatting.black.with { extra_args = { "--fast" } },
          nls.builtins.formatting.shfmt,
          nls.builtins.formatting.deno_fmt,
          nls.builtins.diagnostics.proselint,
        },
        nls.register({
          name = "more_actions",
          method = { nls.methods.CODE_ACTION },
          filetypes = { "_all" },
          generator = {
            fn = require("ts-node-action").available_actions
          }
        })
      }
    end,
  },

  -- cmdline tools and lsp servers
  {

    "williamboman/mason.nvim",
    cmd = "Mason",
    keys = { { "<leader>cM", "<cmd>Mason<cr>", desc = "Mason" } },
    opts = {
      ensure_installed = {
        "shfmt",
        "deno",
        "black",
        "proselint",
      },
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗"
        }
      },
    },
    config = function(plugin, opts)
      if plugin.ensure_installed then
        require("treesitter.opts.ensure_installed")
      end
      require("mason").setup(opts)
      local mr = require("mason-registry")
      for _, tool in ipairs(opts.ensure_installed) do
        local p = mr.get_package(tool)
        if not p:is_installed() then
          p:install()
        end
      end
    end,
  },
}
