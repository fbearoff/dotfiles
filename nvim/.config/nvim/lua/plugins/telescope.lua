local M = {
  "nvim-telescope/telescope.nvim",
  event = "VeryLazy",
  -- cmd = { "Telescope" },
  keys = {
    { "<leader>:", "<cmd>Telescope command_history<cr>", desc = "Command History" },
    { "<leader>su", "<cmd>Telescope undo<cr>", desc = "Undo" },
    { "<leader>f",
      function()
        require 'plugins.telescope'.project_files({ hidden = true })
      end,
      desc = "Find Files" },
    { "<leader>F", "<cmd>Telescope live_grep theme=ivy<cr>", desc = "Find Text" },
    { "<leader>bb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
    { "<leader>sc", "<cmd>Telescope colorscheme<cr>", desc = "Colorscheme" },
    { "<leader>sC", "<cmd>Telescope commands<cr>", desc = "Commands" },
    { "<leader>sg", "<cmd>Telescope grep_string<cr>", desc = "Grep String" },
    { "<leader>sh",
      function()
        require('telescope.builtin').help_tags { default_text = vim.call('expand', '<cword>') }
      end,
      desc = "Help" },
    { "<leader>sk", "<cmd>Telescope keymaps<cr>", desc = "Keymaps" },
    { "<leader>sm", "<cmd>Telescope marks<cr>", desc = "Marks" },
    { "<leader>sM", "<cmd>Telescope man_pages<cr>", desc = "Man Pages" },
    { "<leader>sp", "<cmd>Telescope projects<cr>", desc = "Projects" },
    { "<leader>sr", "<cmd>Telescope oldfiles<cr>", desc = "Recent Files" },
    { "<leader>sR", "<cmd>Telescope registers<cr>", desc = "Registers" },
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope-symbols.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "debugloop/telescope-undo.nvim",
    {
      "ahmedkhalf/project.nvim",
      config = function()
        require("project_nvim").setup({
          detection_methods = {
            "lsp",
            "pattern",
          },
          patterns = {
            ".git",
            "Makefile",
            "package.json",
            "DESCRIPTION",
          },
        })
      end
    },
  },
}

function M.project_files(opts)
  opts = opts or {}
  opts.show_untracked = true
  if vim.loop.fs_stat(".git") then
    require("telescope.builtin").git_files(opts)
  else
    local client = vim.lsp.get_active_clients()[1]
    if client then
      opts.cwd = client.config.root_dir
    end
    require("telescope.builtin").find_files(opts)
  end
end

function M.config()
  local action_layout = require("telescope.actions.layout")

  -- Don't preview binaries
  local previewers = require("telescope.previewers")
  local Job = require("plenary.job")
  local new_maker = function(filepath, bufnr, opts)
    filepath = vim.fn.expand(filepath)
    Job:new({
      command = "file",
      args = { "--mime-type", "-b", filepath },
      on_exit = function(j)
        local mime_type = vim.split(j:result()[1], "/")[1]
        if mime_type == "text" then
          previewers.buffer_previewer_maker(filepath, bufnr, opts)
        else
          -- maybe we want to write something to the buffer here
          vim.schedule(function()
            vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, { "BINARY" })
          end)
        end
      end
    }):sync()
  end

  -- Search hidden/dot files, but not in `.git`.
  local telescopeConfig = require("telescope.config")
  local vimgrep_arguments = { unpack(telescopeConfig.values.vimgrep_arguments) }
  table.insert(vimgrep_arguments, { "--hidden", "--glob", "!**/.git/*" })

  local trouble = require("trouble.providers.telescope")
  local undo = require("telescope-undo.actions")

  local telescope = require("telescope")

  telescope.setup({
    extensions = {
      undo = {
        layout_strategy = "horizontal",
        mappings = {
          i = {
            ["<C-a>"] = undo.yank_additions,
            ["<C-r>"] = undo.yank_deletions,
            ["<cr>"] = undo.restore,
          },
          n = {
            ["<C-a>"] = undo.yank_additions,
            ["<C-r>"] = undo.yank_deletions,
            ["<cr>"] = undo.restore,
          },
        }
      },
    },
    defaults = {
      prompt_prefix = " ",
      selection_caret = " ",
      buffer_previewer_maker = new_maker, -- don't preview binaries
      vimgrep_arguments = vimgrep_arguments,
      file_ignore_patterns = { ".git/", "node_modules", "/tmp", "/usr", ".local" },
      winblend = 10,
      dynamic_preview_title = true,
      layout_strategy = "horizontal",
      layout_config = {
        prompt_position = "top",
      },
      sorting_strategy = "ascending",
      mappings = {
        i = {
          ["<c-t>"] = trouble.open_with_trouble,
          ["<C-Down>"] = require("telescope.actions").cycle_history_next,
          ["<C-Up>"] = require("telescope.actions").cycle_history_prev,
          ["<M-p>"] = action_layout.toggle_preview,
        },
        n = {
          ["<M-p>"] = action_layout.toggle_preview,
        },
      },
      pickers = {
        find_files = {
          find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
        },
      },
    },
  })
  -- load extensions
  telescope.load_extension("fzf")
  telescope.load_extension("undo")
  telescope.load_extension('projects')
end

return M
