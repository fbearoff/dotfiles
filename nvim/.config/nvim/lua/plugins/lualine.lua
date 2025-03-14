return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  opts = function()
    local icons = require("config.icons")

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
        vim.cmd("Trouble diagnostics toggle")
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
        ---@diagnostic disable-next-line: undefined-field
        print("cwd:" .. vim.uv.cwd())
      end,
    }

    -- Lsp server name .
    local lsp_status = {
      "lsp_status",
      on_click = function()
        vim.cmd("check lspconfig")
      end,
    }

    local macro = {
      function()
        return require("NeoComposer.ui").status_recording()
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
            "snacks_dashboard",
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
        lualine_c = { diagnostics, lightbulb, filename, navic },
        lualine_x = {
          escape_status,
          macro,
          lsp_status,
          "fileformat",
          "encoding",
          filetype,
        },
        lualine_y = { location },
        lualine_z = { "searchcount", lazy },
      },
      extensions = {
        "nvim-tree",
        "trouble",
        "lazy",
      },
    }
  end,
}
