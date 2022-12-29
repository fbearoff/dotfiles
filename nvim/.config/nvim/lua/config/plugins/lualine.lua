local M = {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
}

function M.config()
  local colors = require("kanagawa.colors").setup()

  local hide_in_width = function()
    return vim.fn.winwidth(0) > 80
  end

  local diagnostics = {
    "diagnostics",
    sources = { "nvim_diagnostic" },
    symbols = { error = " ", warn = " " },
    colored = true,
    update_in_insert = false,
    always_visible = true,
    on_click = function()
      vim.cmd('TroubleToggle document_diagnostics')
    end
  }

  local diff = {
    "diff",
    colored = true,
    symbols = { added = " ", modified = " ", removed = " " },
    cond = hide_in_width,
    on_click = function()
      package.loaded.gitsigns.diffthis()
    end
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
    symbols = {
      modified = '[+]',
      readonly = '[-]',
      unnamed = '[No Name]',
    },
  }
  -- Lsp server name .
  local lsp_server = {
    function()
      local msg = 'No Active Lsp'
      local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
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
    icon = ' :',
    on_click = function()
      require 'lspconfig.ui.lspinfo' ()
    end
  }

  local spaces = function()
    return "spaces: " .. vim.api.nvim_buf_get_option(0, "shiftwidth")
  end

  local macro = {
    require("noice").api.statusline.mode.get,
    cond = require("noice").api.statusline.mode.has,
    color = { fg = colors.co },
  }

  require("lualine").setup({
    options = {
      icons_enabled = true,
      theme = "auto",
      component_separators = { left = "|", right = "|" },
      section_separators = { left = "", right = "" },
      disabled_filetypes = {
        statusline = {
          'alpha',
          'dashboard',
          'NvimTree',
          'Outline',
          "lazy",
        },
      },
      always_divide_middle = true,
      globalstatus = true,
      refresh = {
        statusline = 1000,
        tabline = 1000,
        winbar = 1000,
      }
    },
    sections = {
      lualine_a = { "mode" },
      lualine_b = { "branch", diff, diagnostics },
      lualine_c = {
        { function()
          local key = require("grapple").key()
          return " [" .. key .. "]"
        end,
          cond = require("grapple").exists,
          color = { fg = colors.fn },
        },
        filename,
        {
          function()
            local navic = require("nvim-navic")
            local ret = navic.get_location()
            return ret:len() > 2000 and "navic error" or ret
          end,
          cond = function()
            if package.loaded["nvim-navic"] then
              local navic = require("nvim-navic")
              return navic.is_available()
            end
          end,
          color = { fg = colors.fg },
        },
      },
      lualine_x = { macro, lsp_server, spaces, "fileformat", "encoding", filetype },
      lualine_y = { location },
      lualine_z = {
        {
          function()
            return require("noice").api.status.command.get()
          end,
          cond = function()
            if package.loaded["noice"] then
              return require("noice").api.status.command.has()
            end
          end,
        },
        {
          function()
            return require("noice").api.status.mode.get()
          end,
          cond = function()
            if package.loaded["noice"] then
              return require("noice").api.status.mode.has()
            end
          end,
        },
        {
          function()
            return require("noice").api.status.search.get()
          end,
          cond = function()
            if package.loaded["noice"] then
              return require("noice").api.status.search.has()
            end
          end,
        },
        {
          function()
            return require("lazy.status").updates()
          end,
          cond = require("lazy.status").has_updates,
          on_click = function()
            vim.cmd('Lazy')
          end
        },
      },
    },

    extensions = { "nvim-tree",
      "nvim-dap-ui",
      "symbols-outline",
      "toggleterm" },
  })
end

return M
