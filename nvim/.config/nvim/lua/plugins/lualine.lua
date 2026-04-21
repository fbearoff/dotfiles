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
    }

    local project = {
      "project",
      enclose_pair = { "<", ">" },
      cond = function()
        return require("project").get_project_root() ~= nil
      end,
    }

    local macro = {
      "macro",
      fmt = function()
        local reg = vim.fn.reg_recording()
        if reg ~= "" then
          return "REC @" .. reg
        end
        return nil
      end,
      color = { fg = "#C34043" },
      draw_empty = false,
    }

    local navic = {
      "navic",
      color_correction = "static",
      padding = { left = 1, right = 0 },
    }

    local lazy = {
      function()
        return require("lazy.status").updates()
      end,
      cond = require("lazy.status").has_updates,
    }

    local lightbulb = {
      function()
        return require("nvim-lightbulb").get_status_text()
      end,
    }

    return {
      options = {
        component_separators = { left = "|", right = "|" },
        section_separators = { left = "", right = "" },
        disabled_filetypes = {
          statusline = {
            "snacks_dashboard",
            "dashboard",
          },
        },
        globalstatus = true,
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", diff },
        lualine_c = {
          diagnostics,
          lightbulb,
          project,
          filename,
          navic,
        },
        lualine_x = {
          macro,
          "lsp_status",
          "fileformat",
          "encoding",
          "filetype",
        },
        lualine_y = { location },
        lualine_z = { "searchcount", lazy },
      },
      extensions = {
        "nvim-tree",
        "lazy",
      },
    }
  end,
}
