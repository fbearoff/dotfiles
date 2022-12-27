local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
  return
end

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

telescope.setup {
  defaults = {
    prompt_prefix = " ",
    selection_caret = " ",
    path_display = { "smart" },
    file_ignore_patterns = { ".git/", "node_modules" },
    initial_mode = "insert",
    winblend = 5,
    buffer_previewer_maker = new_maker, -- don't preview binaries
    vimgrep_arguments = vimgrep_arguments,
    mappings = {
      i = {
        ["<M-p>"] = action_layout.toggle_preview,
      },
      n = {
        ["<M-p>"] = action_layout.toggle_preview,
      },
    },
  },
  pickers = {
    find_files = {
      -- `hidden = true` will still show the inside of `.git/` as it's not `.gitignore`d.
      find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
    },
    noice = {
      initial_mode = "normal"
    },
    git_status = {
      initial_mode = "normal"
    },
  },
  extensions = {
    fzf = {
      fuzzy = true, -- false will only do exact matching
      override_generic_sorter = true, -- override the generic sorter
      override_file_sorter = true, -- override the file sorter
      case_mode = "smart_case", -- or "ignore_case" or "respect_case"
    },
    undo = {
      -- prompt_prefix = "?",
      -- initial_mode = "normal",
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
  }
}

pcall(require('telescope').load_extension, 'fzf')
pcall(require('telescope').load_extension, 'notify')
pcall(require('telescope').load_extension, 'noice')
pcall(require('telescope').load_extension, "undo")

local M = {}

-- fallback to find files if not git repo
M.project_files = function()
  local opts = {} -- define here if you want to define something
  vim.fn.system('git rev-parse --is-inside-work-tree')
  if vim.v.shell_error == 0 then
    require "telescope.builtin".git_files(opts)
  else
    require "telescope.builtin".find_files(opts)
  end
end

return M
