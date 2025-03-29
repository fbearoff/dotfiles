local icons = require("config.icons")
return {
  -- lspconfig
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      {
        "hrsh7th/cmp-nvim-lsp",
      },
    },
    keys = function()
      local function jumpWithVirtLineDiags(jumpCount)
        pcall(vim.api.nvim_del_augroup_by_name, "jumpWithVirtLineDiags") -- prevent autocmd for repeated jumps

        vim.diagnostic.jump({ count = jumpCount })

        local initialVirtTextConf = vim.diagnostic.config().virtual_text
        vim.diagnostic.config({
          virtual_text = false,
          virtual_lines = { current_line = true },
        })

        vim.defer_fn(function() -- deferred to not trigger by jump itself
          vim.api.nvim_create_autocmd("CursorMoved", {
            desc = "User(once): Reset diagnostics virtual lines",
            once = true,
            group = vim.api.nvim_create_augroup("jumpWithVirtLineDiags", {}),
            callback = function()
              vim.diagnostic.config({ virtual_lines = false, virtual_text = initialVirtTextConf })
            end,
          })
        end, 1)
      end
      return {
        {
          "]d",
          function()
            jumpWithVirtLineDiags(1)
          end,
          desc = "Next Diagnostic",
        },
        {
          "[d",
          function()
            jumpWithVirtLineDiags(-1)
          end,
          desc = "Prev Diagnostic",
        },
        { "<leader>cd", vim.diagnostic.open_float, desc = "Line Diagnostics" },
        { "gl", vim.diagnostic.open_float, desc = "Line Diagnostics" },
        { "<leader>cl", "<cmd>checkhealth vim.lsp<cr>", desc = "Lsp Info" },
        {
          "<leader>dd",
          function()
            Snacks.picker.diagnostics()
          end,
          desc = "Document",
        },
        {
          "<leader>dD",
          function()
            Snacks.picker.diagnostics_buffer()
          end,
          desc = "Workspace",
        },
        {
          "gd",
          function()
            Snacks.picker.lsp_definitions()
          end,
          desc = "Goto Definition",
        },
        {
          "grr",
          function()
            Snacks.picker.lsp_references()
          end,
          desc = "Goto References",
        },
        {
          "gD",
          function()
            Snacks.picker.lsp_declarations()
          end,
          desc = "Goto Declaration",
        },
        {
          "gri",
          function()
            Snacks.picker.lsp_implementations()
          end,
          desc = "Goto Implementation",
        },
        {
          "gy",
          function()
            Snacks.picker.lsp_type_definitions()
          end,
          desc = "Goto Type Definition",
        },
        {
          "gO",
          function()
            Snacks.picker.lsp_symbols()
          end,
          desc = "Goto Document Symbols",
        },
        { "gK", vim.lsp.buf.signature_help, desc = "Signature Help" },
        { "gra", vim.lsp.buf.code_action, desc = "Code Action", mode = { "n", "v" } },
        { "<leader>ca", vim.lsp.buf.code_action, desc = "Code Action", mode = { "n", "v" } },
        { "<leader>cc", vim.lsp.codelens.run, desc = "Run Codelens", mode = { "n", "v" } },
        { "<leader>cC", vim.lsp.codelens.refresh, desc = "Refresh & Display Codelens" },
      }
    end,
    opts = {
      capabilities = {
        textDocument = {
          foldingRange = {
            dynamicRegistration = false,
            lineFoldingOnly = true,
          },
        },
      },
      diagnostics = {
        virtual_text = {
          source = "if_many",
          prefix = "icons",
          severity = {
            min = vim.diagnostic.severity.ERROR,
          },
        },
        underline = {
          severity = {
            min = vim.diagnostic.severity.HINT,
          },
        },
        severity_sort = true,
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = icons.diagnostics.Error,
            [vim.diagnostic.severity.WARN] = icons.diagnostics.Warn,
            [vim.diagnostic.severity.HINT] = icons.diagnostics.Hint,
            [vim.diagnostic.severity.INFO] = icons.diagnostics.Info,
          },
        },
        float = {
          focusable = true,
          style = "minimal",
          border = "rounded",
          source = "if_many",
          header = "",
          prefix = "",
        },
      },
      servers = {
        ansiblels = {},
        bashls = {},
        html = {},
        marksman = {},
        r_language_server = {
          settings = {
            r = {
              lsp = {
                max_completions = 20,
              },
            },
          },
        },
        lua_ls = {
          settings = {
            Lua = {
              runtime = {
                version = "LuaJIT",
              },
              workspace = {
                library = {
                  [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                },
                checkThirdParty = false,
                diagnostics = {
                  globals = { "vim" },
                },
              },
              completion = {
                callSnippet = "Replace",
              },
              format = {
                enable = false,
              },
              hint = {
                enable = true,
              },
              codeLens = {
                enable = true,
              },
            },
          },
        },
      },
    },
    config = function(_, opts)
      -- Prefer LSP folding if client supports it
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          ---@diagnostic disable-next-line: need-check-nil
          if client:supports_method("textDocument/foldingRange") then
            local win = vim.api.nvim_get_current_win()
            vim.wo[win][0].foldexpr = "v:lua.vim.lsp.foldexpr()"
          end
        end,
      })

      -- diagnostic icons in virtual text
      if type(opts.diagnostics.virtual_text) == "table" and opts.diagnostics.virtual_text.prefix == "icons" then
        opts.diagnostics.virtual_text.prefix = function(diagnostic)
          for d, icon in pairs(icons.diagnostics) do
            if diagnostic.severity == vim.diagnostic.severity[d:upper()] then
              return icon
            end
          end
        end
      end

      vim.diagnostic.config(vim.deepcopy(opts.diagnostics))

      local servers = opts.servers
      local capabilities = vim.tbl_deep_extend(
        "force",
        {},
        vim.lsp.protocol.make_client_capabilities(),
        -- require("blink.cmp").get_lsp_capabilities(),
        require("cmp_nvim_lsp").default_capabilities(),
        opts.capabilities or {}
      )

      local function setup(server)
        local server_opts = vim.tbl_deep_extend("force", {
          capabilities = vim.deepcopy(capabilities),
        }, servers[server] or {})

        require("lspconfig")[server].setup(server_opts)
      end

      -- get all the servers that are available through mason-lspconfig
      local have_mason, mlsp = pcall(require, "mason-lspconfig")

      local ensure_installed = {}
      for server, server_opts in pairs(servers) do
        if server_opts then
          server_opts = server_opts == true and {} or server_opts
          ensure_installed[#ensure_installed + 1] = server
        end
      end

      if have_mason then
        mlsp.setup({ ensure_installed = ensure_installed, handlers = { setup } })
      end
    end,
  },

  -- cmdline tools and lsp servers
  {

    "williamboman/mason.nvim",
    cmd = "Mason",
    keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
    build = ":MasonUpdate",
    opts = {
      ensure_installed = {
        "air",
        "shfmt",
        "stylua",
        "ansible-lint",
        "mdformat",
        "markdown-toc",
      },
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    },
    config = function(_, opts)
      require("mason").setup(opts)
      local mr = require("mason-registry")
      local function ensure_installed()
        for _, tool in ipairs(opts.ensure_installed) do
          local p = mr.get_package(tool)
          if not p:is_installed() then
            p:install()
          end
        end
      end
      if mr.refresh then
        mr.refresh(ensure_installed)
      else
        ensure_installed()
      end
    end,
  },
}
