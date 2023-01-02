local M = {
  "goolord/alpha-nvim",
  event = "VimEnter",
  enabled = true,
  lazy = false,
  dependencies = "nvim-tree/nvim-web-devicons"
}

function M.config()

  local dashboard = require("alpha.themes.dashboard")
  local logo = [[
       ___       __   ___  ___  ________  _________        ___  ___  ________  ___  ___  ___
      |\  \     |\  \|\  \|\  \|\   __  \|\___   ___\     |\  \|\  \|\   __  \|\  \|\  \|\  \
      \ \  \    \ \  \ \  \\\  \ \  \|\  \|___ \  \_|     \ \  \\\  \ \  \|\  \ \  \ \  \ \  \
       \ \  \  __\ \  \ \   __  \ \   __  \   \ \  \       \ \  \\\  \ \   ____\ \  \ \  \ \  \
        \ \  \|\__\_\  \ \  \ \  \ \  \ \  \   \ \  \       \ \  \\\  \ \  \___|\ \__\ \__\ \__\
         \ \____________\ \__\ \__\ \__\ \__\   \ \__\       \ \_______\ \__\    \|__|\|__|\|__|
          \|____________|\|__|\|__|\|__|\|__|    \|__|        \|_______|\|__|        ___  ___  ___
                                                                                    |\__\|\__\|\__\
                                                                                    \|__|\|__|\|__|
   ]]

      dashboard.section.header.val = vim.split(logo, "\n")
      dashboard.section.buttons.val = {
        dashboard.button("f", " " .. " Find file", ":Telescope find_files <CR>"),
        dashboard.button("e", " " .. " New file", ":ene <BAR> startinsert <CR>"),
        dashboard.button("r", " " .. " Recent files", ":Telescope oldfiles <CR>"),
        dashboard.button("t", " " .. " Find text", ":Telescope live_grep <CR>"),
        dashboard.button("c", " " .. " Config", ":e $MYVIMRC <CR>"),
        dashboard.button("l", "鈴" .. "  Lazy", ":Lazy<CR>"),
        dashboard.button("q", " " .. " Quit", ":qa<CR>"),
      }
      for _, button in ipairs(dashboard.section.buttons.val) do
        button.opts.hl = "Type"
        button.opts.hl_shortcut = "Constant"
      end
      dashboard.section.footer.opts.hl = "Function"
      dashboard.section.header.opts.hl = "Keyword"
      dashboard.section.buttons.opts.hl = "Type"
      dashboard.opts.layout[1].val = 8

      local alpha = require("alpha")
      if vim.o.filetype == "lazy" then
        -- close and re-open Lazy after showing alpha
        vim.cmd.close()
        alpha.setup(dashboard.opts)
        require("lazy").show()
      else
        alpha.setup(dashboard.opts)
      end

      vim.api.nvim_create_autocmd("User", {
        pattern = "LazyVimStarted",
        callback = function()
          local stats = require("lazy").stats()
          local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
          dashboard.section.footer.val = "💪 Neovim loaded " .. stats.count .. " plugins in " .. ms .. "ms 💪"
          pcall(vim.cmd.AlphaRedraw)
        end,
      })
    end
return M
