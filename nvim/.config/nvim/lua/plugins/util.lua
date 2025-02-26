return {
  "nvim-lua/plenary.nvim",

  -- needed for properly setting project root
  {
    "ahmedkhalf/project.nvim",
    event = "VeryLazy",
    opts = {
      detection_methods = {
        "pattern",
        "lsp",
      },
      patterns = {
        ".git",
        "Makefile",
        "package.json",
        "DESCRIPTION",
      },
    },
    config = function(_, opts)
      require("project_nvim").setup(opts)
    end,
  },

  -- collection of util plugins
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    keys = {
      -- core
      {
        "<leader>/",
        function()
          Snacks.picker.smart()
        end,
        desc = "Smart Find Files",
      },
      {
        "<leader>:",
        function()
          Snacks.picker.command_history()
        end,
        desc = "Command History",
      },
      -- Files
      {
        "<leader>fc",
        function()
          Snacks.picker.files({ cwd = vim.fn.stdpath("config"), title = "Config Files" })
        end,
        desc = "Find Config File",
      },
      {
        "<leader>ff",
        function()
          Snacks.picker.files({ hidden = true })
        end,
        desc = "Find Files",
      },
      {
        "<leader>fF",
        function()
          Snacks.picker.files({ cwd = vim.fn.expand("%:h") })
        end,
        desc = "Find Files (CWD)",
      },
      {
        "<leader>fg",
        function()
          Snacks.picker.grep({ hidden = true, layout = { preset = "ivy" } })
        end,
        desc = "Grep",
      },
      {
        "<leader>fr",
        function()
          Snacks.picker.recent()
        end,
        desc = "Recent",
      },
      {
        "<leader>fu",
        function()
          Snacks.picker.undo()
        end,
        desc = "Undo History",
      },
      -- Buffers
      {
        "<leader>bb",
        function()
          Snacks.picker.buffers()
        end,
        desc = "Buffers",
      },
      -- search
      {
        "<leader>ss",
        function()
          Snacks.picker.lsp_symbols()
        end,
        desc = "LSP Symbols",
      },
      {
        "<leader>sS",
        function()
          Snacks.picker.lsp_workspace_symbols()
        end,
        desc = "LSP Workspace Symbols",
      },
      {
        "<leader>sk",
        function()
          Snacks.picker.keymaps()
        end,
        desc = "Keymaps",
      },
      {
        "<leader>sc",
        function()
          Snacks.picker.colorschemes()
        end,
        desc = "Colorscheme",
      },
      {
        "<leader>sC",
        function()
          Snacks.picker.commands()
        end,
        desc = "Commands",
      },
      {
        "<leader>sh",
        function()
          Snacks.picker.help()
        end,
        desc = "Help Pages",
      },
      {
        "<leader>sp",
        function()
          Snacks.picker.projects()
        end,
        desc = "Projects",
      },
      {
        "<leader>se",
        function()
          Snacks.picker.icons()
        end,
        desc = "Emoji/Icons",
      },
      {
        "<leader>sm",
        function()
          Snacks.picker.man()
        end,
        desc = "Man Pages",
      },
      {
        "<leader>sr",
        function()
          Snacks.picker.registers()
        end,
        desc = "Registers",
      },
      {
        "<leader>r",
        function()
          Snacks.picker.resume()
        end,
        desc = "Resume Picker",
      },
      {
        "<leader>sw",
        function()
          Snacks.picker.grep_word()
        end,
        desc = "Visual selection or word",
        mode = { "n", "x" },
      },
    },
    opts = {
      bigfile = { enabled = false },
      dashboard = {
        preset = {
          header = [[
       ___       __   ___  ___  ________  _________       ___  ___  ________  ___  ___  ___
      |\  \     |\  \|\  \|\  \|\   __  \|\___   ___\    |\  \|\  \|\   __  \|\  \|\  \|\  \
      \ \  \    \ \  \ \  \\\  \ \  \|\  \|___ \  \_|    \ \  \\\  \ \  \|\  \ \  \ \  \ \  \
       \ \  \  __\ \  \ \   __  \ \   __  \   \ \  \      \ \  \\\  \ \   ____\ \  \ \  \ \  \
        \ \  \|\__\_\  \ \  \ \  \ \  \ \  \   \ \  \      \ \  \\\  \ \  \___|\ \__\ \__\ \__\
         \ \____________\ \__\ \__\ \__\ \__\   \ \__\      \ \_______\ \__\    \|__|\|__|\|__|
          \|____________|\|__|\|__|\|__|\|__|    \|__|       \|_______|\|__|        ___  ___  ___
                                                                                   |\__\|\__\|\__\
                                                                                   \|__|\|__|\|__|
   ]],
          keys = {
            {
              icon = " ",
              key = "f",
              desc = "Find File",
              action = ":lua Snacks.dashboard.pick('files')",
            },
            { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
            { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
            { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
            {
              icon = " ",
              key = "c",
              desc = "Config",
              action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
            },
            { icon = " ", key = "p", desc = "Projects", action = ":lua Snacks.dashboard.pick('projects')" },
            { icon = "󰒲 ", key = "L", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
            { icon = " ", key = "q", desc = "Quit", action = ":qa" },
          },
        },
        sections = {
          { section = "header" },
          { section = "keys", gap = 1, padding = 1 },
          { section = "startup", icon = "💪 " },
        },
      },
      indent = { enabled = true },
      input = { enabled = true },
      picker = {
        win = {
          input = {
            keys = {
              ["<a-s>"] = { "flash_jump", mode = { "n", "i" } },
              ["s"] = { "flash_jump" },
            },
          },
        },
        actions = {
          flash_jump = function(picker)
            require("flash").jump({
              pattern = "^",
              label = { after = { 0, 0 } },
              search = {
                mode = "search",
                exclude = {
                  function(win)
                    return vim.bo[vim.api.nvim_win_get_buf(win)].filetype ~= "snacks_picker_list"
                  end,
                },
              },
              action = function(match)
                local idx = picker.list:row2idx(match.pos[1])
                picker.list:_move(idx, true, true)
              end,
            })
          end,
        },
      },
      notifier = { enabled = false },
      quickfile = { enabled = false },
      scope = { enabled = false },
      scroll = { enabled = false },
      statuscolumn = {
        left = { "git" },
        right = { "sign", "mark", "fold" },
        folds = {
          open = true,
          git_hl = false,
        },
        git = {
          patterns = { "GitSign", "MiniDiffSign" },
        },
        refresh = 50,
      },
      words = { enabled = false },
    },
  },
  -- Easy terminal access
  {
    "akinsho/toggleterm.nvim",
    keys = {
      {
        [[<c-\>]],
        function()
          local count = vim.v.count1
          local dir = vim.api.nvim_buf_get_name(0)
          require("toggleterm").toggle(count, 15, vim.fs.dirname(dir), "horizontal")
        end,
        desc = "ToggleTerm (CWD)",
      },
      { "<leader>tf", "<cmd>ToggleTerm direction=float<CR>", desc = "Float" },
      { "<leader>t-", "<cmd>ToggleTerm size=10 direction=horizontal<CR>", desc = "Horizontal" },
      { "<leader>t\\", "<cmd>ToggleTerm size=80 direction=vertical<CR>", desc = "Vertical" },
      { "<leader>ts", "<cmd>ToggleTermSendCurrentLine<CR>", desc = "Send Line" },
      { mode = "x", "<leader>s", ":ToggleTermSendVisualLines<CR>", desc = "Send Lines to Terminal" },
    },
    cmd = { "ToggleTerm", "TermExec" },
    opts = function()
      function _G.set_terminal_keymaps()
        local opts = { buffer = 0 }
        vim.keymap.set("t", "jk", [[<C-\><C-n>]], opts)
        vim.keymap.set("t", [[<c-\>]], [[<C-\><C-n>]], opts)
        vim.keymap.set("t", "<C-h>", [[<C-\><C-n><C-W>h]], opts)
        vim.keymap.set("t", "<C-j>", [[<C-\><C-n><C-W>j]], opts)
        vim.keymap.set("t", "<C-k>", [[<C-\><C-n><C-W>k]], opts)
        vim.keymap.set("t", "<C-l>", [[<C-\><C-n><C-W>l]], opts)
      end

      vim.api.nvim_create_autocmd({ "TermOpen" }, {
        pattern = "term://*",
        callback = set_terminal_keymaps,
      })
      return {
        autochdir = false,
        shading_factor = 2,
        direction = "horizontal",
        float_opts = {
          border = "curved",
          winblend = 5,
        },
      }
    end,
  },

  -- Visualize startup time
  {
    "dstein64/vim-startuptime",
    cmd = "StartupTime",
    config = function()
      vim.g.startuptime_tries = 10
    end,
  },

  -- Quicker escape from insert mode with jj/jk
  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    opts = {},
  },

  -- makes some plugins dot-repeatable
  { "tpope/vim-repeat", event = "VeryLazy" },

  -- URL opening
  {
    "axieax/urlview.nvim",
    cmd = "UrlView",
    opts = {},
    keys = {
      { "[u", desc = "Previous URL" },
      { "]u", desc = "Next URL" },
      { "<leader>su", "<cmd>UrlView buffer bufnr=0<cr>", desc = "URLs" },
      { "<leader>sU", "<cmd>UrlView lazy<cr>", desc = "Plugin URLs" },
    },
  },

  -- Highlight undo
  {
    "tzachar/highlight-undo.nvim",
    keys = { "u", "<C-r>" },
    opts = {},
  },
}
