local Util = require("util")

return {
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      { "<leader>/", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Search Buffer" },
      { "<leader>:", "<cmd>Telescope command_history<cr>", desc = "Command History" },
      { "<leader>fu", "<cmd>Telescope undo<cr>", desc = "Undo" },
      { "<leader>ff", Util.telescope("files"), desc = "Find Files (Root)" },
      { "<leader>fF", Util.telescope("files", { cwd = false }), desc = "Find Files (CWD)" },
      { "<leader>fg", "<cmd>Telescope live_grep theme=ivy<cr>", desc = "Live Grep" },
      { "<leader>bb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
      {
        "<leader>sc",
        function()
          pcall(vim.api.nvim_command, "doautocmd User LoadColorSchemes")
          pcall(require("telescope.builtin").colorscheme, { enable_preview = true })
        end,
        desc = "Colorscheme",
      },
      { "<leader>sw", Util.telescope("grep_string"), desc = "Word (Root)" },
      { "<leader>sW", Util.telescope("grep_string", { cwd = false }), desc = "Word (CWD)" },
      { "<leader>so", "<cmd>Telescope vim_options<cr>", desc = "Options" },
      { "<leader>sC", "<cmd>Telescope commands<cr>", desc = "Commands" },
      {
        "<leader>sh",
        function()
          require("telescope.builtin").help_tags({ default_text = vim.call("expand", "<cword>") })
        end,
        desc = "Help",
      },
      { "<leader>sk", "<cmd>Telescope keymaps<cr>", desc = "Keymaps" },
      { "<leader>mm", "<cmd>Telescope marks<cr>", desc = "Search Marks" },
      { "<leader>sM", "<cmd>Telescope man_pages<cr>", desc = "Man Pages" },
      { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent" },
      { "<leader>fR", Util.telescope("oldfiles", { cwd = vim.uv.cwd() }), desc = "Recent (CWD)" },
      { "<leader>sr", "<cmd>Telescope registers<cr>", desc = "Registers" },
      { "<leader>sR", "<cmd>Telescope resume<cr>", desc = "Resume" },
      {
        "<leader>ss",
        Util.telescope("lsp_document_symbols", {
          symbols = {
            "Class",
            "Function",
            "Method",
            "Constructor",
            "Interface",
            "Module",
            "Struct",
            "Trait",
            "Field",
            "Property",
          },
        }),
        desc = "Goto Symbol",
      },
      {
        "<leader>sS",
        Util.telescope("lsp_dynamic_workspace_symbols", {
          symbols = {
            "Class",
            "Function",
            "Method",
            "Constructor",
            "Interface",
            "Module",
            "Struct",
            "Trait",
            "Field",
            "Property",
          },
        }),
        desc = "Goto Symbol (Workspace)",
      },
    },
    dependencies = {
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      "debugloop/telescope-undo.nvim",
      {
        "ahmedkhalf/project.nvim",
        event = "VeryLazy",
        keys = {
          { "<leader>sp", "<cmd>Telescope projects<cr>", desc = "Projects" },
        },
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
          require("telescope").load_extension("projects")
        end,
      },
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

      local undo = require("telescope-undo.actions")
      return {
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
            },
          },
          bibtex = {
            global_files = { "~/onedrive/Documents/papers/bibfile.bib" },
            context = true,
            context_fallback = true,
            wrap = true,
          },
          heading = {
            treesitter = true,
          },
        },
        defaults = {
          prompt_prefix = " ",
          selection_caret = " ",
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
      require("telescope").load_extension("undo")
    end,
  },

  -- heading search for markdown and help
  {
    "crispgm/telescope-heading.nvim",
    keys = { { "<localleader>mh", "<cmd>Telescope heading<cr>", desc = "Heading" } },
    config = function()
      require("telescope").load_extension("heading")
    end,
  },

  -- search and insert bibtext entries
  {
    "nvim-telescope/telescope-bibtex.nvim",
    keys = {
      { "<leader>sb", "<cmd>Telescope bibtex<cr>", desc = "Bibtex" },
    },
    config = function()
      require("telescope").load_extension("bibtex")
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

  -- search emojis
  {
    "nvim-telescope/telescope-symbols.nvim",
    keys = {
      { "<leader>se", "<cmd>Telescope symbols<cr>", desc = "Emoji" },
    },
  },
}
