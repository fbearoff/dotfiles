local M = {
  "nvim-telescope/telescope.nvim",
  cmd = { "Telescope" },

  dependencies = {
    { "nvim-telescope/telescope-project.nvim" },
    { "nvim-telescope/telescope-symbols.nvim" },
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    { "debugloop/telescope-undo.nvim" },
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

  local telescopeConfig = require("telescope.config")

  -- Clone the default Telescope configuration
  local vimgrep_arguments = { unpack(telescopeConfig.values.vimgrep_arguments) }

  -- I want to search in hidden/dot files.
  table.insert(vimgrep_arguments, "--hidden")
  -- I don't want to search in the `.git` directory.
  table.insert(vimgrep_arguments, "--glob")
  table.insert(vimgrep_arguments, "!**/.git/*")

  local trouble = require("trouble.providers.telescope")

  local telescope = require("telescope")
  local borderless = true

  telescope.setup({
    defaults = {
      prompt_prefix = " ",
      selection_caret = " ",
      buffer_previewer_maker = new_maker, -- don't preview binaries
      vimgrep_arguments = vimgrep_arguments,
      file_ignore_patterns = { ".git/", "node_modules" },
      winblend = borderless and 0 or 10,
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
      extensions = {
        undo = {
          side_by_side = true,
          layout_strategy = "vertical",
          layout_config = {
            preview_height = 0.8,
          },
          mappings = {
            i = {
              ["<C-a>"] = require("telescope-undo.actions").yank_additions,
              ["<C-r>"] = require("telescope-undo.actions").yank_deletions,
              ["<cr>"] = require("telescope-undo.actions").restore,
            },
            n = {
              ["<C-a>"] = require("telescope-undo.actions").yank_additions,
              ["<C-r>"] = require("telescope-undo.actions").yank_deletions,
              ["<cr>"] = require("telescope-undo.actions").restore,
            },
          }
        },
      },
    },
  })

  telescope.load_extension("fzf")
  telescope.load_extension("project")
  telescope.load_extension("undo")
end

return M
