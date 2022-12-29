local M = {
  "nvim-telescope/telescope.nvim",
  cmd = { "Telescope" },

  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope-symbols.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "debugloop/telescope-undo.nvim",
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
        side_by_side = true,
        layout_strategy = "vertical",
        layout_config = {
          preview_height = 0.8,
        },
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
      file_ignore_patterns = { ".git/", "node_modules" },
      winblend = 10,
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
