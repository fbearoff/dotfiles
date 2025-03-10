local Util = require("util")

return {
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      { "<leader>so", "<cmd>Telescope vim_options<cr>", desc = "Options" },
    },
    dependencies = {
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    opts = function()
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
          end,
        }):sync()
      end

      -- Search hidden/dot files, but not in `.git`.
      local telescopeConfig = require("telescope.config")
      local vimgrep_arguments = { unpack(telescopeConfig.values.vimgrep_arguments) }
      table.insert(vimgrep_arguments, { "--hidden", "--glob", "!**/.git/*" })

      -- named functions to show action in telescope which_key
      -- show hidden files
      local show_hidden = function(...)
        local action_state = require("telescope.actions.state")
        local line = action_state.get_current_line()
        return Util.telescope("find_files", { hidden = true, default_text = line })(...)
      end
      -- show ignored files
      local show_ignore = function(...)
        local action_state = require("telescope.actions.state")
        local line = action_state.get_current_line()
        return Util.telescope("find_files", { no_ignore = true, default_text = line })(...)
      end
      -- toggle preview
      local toggle_preview = function(...)
        return require("telescope.actions.layout").toggle_preview(...)
      end
      -- cycle history next
      local cycle_history_next = function(...)
        return require("telescope.actions").cycle_history_next(...)
      end
      -- cycle history previous
      local cycle_history_prev = function(...)
        return require("telescope.actions").cycle_history_prev(...)
      end
      -- move selection next
      local move_selection_next = function(...)
        return require("telescope.actions").move_selection_next(...)
      end
      -- move selection previous
      local move_selection_prev = function(...)
        return require("telescope.actions").move_selection_previous(...)
      end
      -- close
      local close = function(...)
        return require("telescope.actions").close(...)
      end

      local function flash(prompt_bufnr)
        require("flash").jump({
          pattern = "^",
          highlight = { label = { after = { 0, 0 } } },
          search = {
            mode = "search",
            exclude = {
              function(win)
                return vim.bo[vim.api.nvim_win_get_buf(win)].filetype ~= "TelescopeResults"
              end,
            },
          },
          action = function(match)
            local picker = require("telescope.actions.state").get_current_picker(prompt_bufnr)
            picker:set_selection(match.pos[1] - 1)
          end,
        })
      end

      return {
        defaults = {
          prompt_prefix = " ",
          selection_caret = " ",
          -- open files in the first window that is an actual file.
          -- use the current window if no other window is available.
          get_selection_window = function()
            local wins = vim.api.nvim_list_wins()
            table.insert(wins, 1, vim.api.nvim_get_current_win())
            for _, win in ipairs(wins) do
              local buf = vim.api.nvim_win_get_buf(win)
              if vim.bo[buf].buftype == "" then
                return win
              end
            end
            return 0
          end,
          buffer_previewer_maker = new_maker, -- don't preview binaries
          vimgrep_arguments = vimgrep_arguments,
          file_ignore_patterns = { ".git/", "node_modules", "/tmp", ".local" },
          winblend = 10,
          dynamic_preview_title = true,
          layout_strategy = "horizontal",
          layout_config = {
            prompt_position = "top",
          },
          sorting_strategy = "ascending",
          mappings = {
            i = {
              ["<M-i>"] = show_ignore,
              ["<M-h>"] = show_hidden,
              ["<C-Down>"] = cycle_history_next,
              ["<C-Up>"] = cycle_history_prev,
              ["<C-j>"] = move_selection_next,
              ["<C-k>"] = move_selection_prev,
              ["<M-p>"] = toggle_preview,
              ["<c-s>"] = flash,
            },
            n = {
              ["p"] = toggle_preview,
              ["q"] = close,
              ["s"] = flash,
            },
          },
          pickers = {
            find_files = {
              find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
            },
          },
        },
      }
    end,
    config = function(_, opts)
      require("telescope").setup(opts)
      require("telescope").load_extension("fzf")
    end,
  },

  -- search snippets
  {
    "benfowler/telescope-luasnip.nvim",
    keys = {
      { "<leader>sl", "<cmd>Telescope luasnip<cr>", desc = "Luasnips" },
    },
    config = function()
      require("telescope").load_extension("luasnip")
    end,
  },
}
