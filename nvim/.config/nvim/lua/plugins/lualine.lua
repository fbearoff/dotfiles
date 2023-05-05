return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  opts = function()
    local icons = require("config.icons")
    local colors = require("kanagawa.colors").setup()

    local diagnostics = {
      "diagnostics",
      sources = { "nvim_diagnostic" },
      symbols = {
        error = icons.diagnostics.Error,
        warn = icons.diagnostics.Warn,
        info = icons.diagnostics.Info,
        hint = icons.diagnostics.Hint,
      },
      colored = true,
      update_in_insert = false,
      always_visible = false,
      on_click = function()
        vim.cmd("TroubleToggle document_diagnostics")
      end,
    }

    local diff = {
      "diff",
      colored = true,
      symbols = {
        added = icons.git.added,
        modified = icons.git.modified,
        removed = icons.git.removed,
      },
      cond = function()
        return vim.fn.winwidth(0) > 80
      end,
      on_click = function()
        package.loaded.gitsigns.diffthis()
      end,
    }

    local filetype = {
      "filetype",
      icons_enabled = true,
    }

    local location = {
      "location",
      padding = 0,
    }

    local filename = {
      "filename",
      path = 1,
      symbols = {
        modified = "[+]",
        readonly = "[-]",
        unnamed = "[No Name]",
      },
      on_click = function()
        print("cwd:" .. vim.loop.cwd())
      end,
    }

    -- Lsp server name .
    local lsp_server = {
      function()
        local msg = "No Active Lsp"
        local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
        local clients = vim.lsp.get_active_clients()
        if next(clients) == nil then
          return msg
        end
        for _, client in ipairs(clients) do
          local filetypes = client.config.filetypes
          if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
            return client.name
          end
        end
        return msg
      end,
      icon = " :",
      on_click = function()
        require("lspconfig.ui.lspinfo")()
      end,
    }

    local macro = {
      function()
        return require("NeoComposer.ui").status_recording()
      end,
    }

    local grapple = {
      function()
        local key = require("grapple").key()
        return " [" .. key .. "]"
      end,
      cond = require("grapple").exists,
      color = { fg = colors.theme.syn.fun },
      on_click = function()
        vim.cmd("GrapplePopup tags")
      end,
    }
    local navic = {
      "navic",
      navic_opts = {
        click = true,
      },
      color_correction = "static",
      padding = { left = 1, right = 0 },
    }

    local lazy = {
      function()
        return require("lazy.status").updates()
      end,
      cond = require("lazy.status").has_updates,
      on_click = function()
        vim.cmd("Lazy")
      end,
    }
    local lightbulb = {
      function()
        return require("nvim-lightbulb").get_status_text()
      end,
      on_click = function()
        vim.lsp.buf.code_action()
      end,
    }

    local escape_status = {
      function()
        return require("better_escape").waiting and "󰠚" or ""
      end,
    }

    return {
      options = {
        icons_enabled = true,
        theme = "auto",
        component_separators = { left = "|", right = "|" },
        section_separators = { left = "", right = "" },
        disabled_filetypes = {
          statusline = {
            "alpha",
            "dashboard",
          },
        },
        always_divide_middle = true,
        globalstatus = true,
        refresh = {
          statusline = 1000,
          tabline = 1000,
          winbar = 1000,
        },
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", diff },
        lualine_c = { diagnostics, lightbulb, grapple, filename, navic },
        lualine_x = { escape_status, macro, lsp_server, "fileformat", "encoding", filetype },
        lualine_y = { location },
        lualine_z = { "searchcount", lazy },
      },
      extensions = {
        "nvim-tree",
        "symbols-outline",
        "toggleterm",
        "trouble",
        "lazy",
      },
    }
  end,
}
