local Util = require("util")

return {
  "nvim-telescope/telescope.nvim",
  keys = {
    { "<leader>/", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Search Buffer" },
    { "<leader>:", "<cmd>Telescope command_history<cr>", desc = "Command History" },
    { "<leader>fu", "<cmd>Telescope undo<cr>", desc = "Undo" },
    { "<leader>ff", Util.telescope("files"), desc = "Find Files (Root)" },
    { "<leader>fF", Util.telescope("files", { cwd = false }), desc = "Find Files (CWD)" },
    { "<leader>fg", "<cmd>Telescope live_grep theme=ivy<cr>", desc = "Live Grep" },
    { "<leader>bb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
    { "<leader>sc", Util.telescope("colorscheme", { enable_preview = true }), desc = "Colorscheme" },
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
    { "<leader>sr", "<cmd>Telescope registers<cr>", desc = "Registers" },
    { "<leader>sR", "<cmd>Telescope resume<cr>", desc = "Resume" },
    { "<leader>sl", "<cmd>Telescope luasnip<cr>", desc = "Luasnips" },
    { "<leader>sb", "<cmd>Telescope bibtex<cr>", desc = "Bibtex" },
    { "<localleader>mh", "<cmd>Telescope heading<cr>", desc = "Heading" },
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
    "nvim-telescope/telescope-symbols.nvim",
    "benfowler/telescope-luasnip.nvim",
    "nvim-telescope/telescope-bibtex.nvim",
    "crispgm/telescope-heading.nvim",
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
          "lsp",
          "pattern",
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
  config = function()
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

    local telescope = require("telescope")
    local undo = require("telescope-undo.actions")

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
            ["<c-t>"] = function(...)
              return require("trouble.providers.telescope").open_with_trouble(...)
            end,
            ["<M-t>"] = function(...)
              return require("trouble.providers.telescope").open_selected_with_trouble(...)
            end,
            ["<M-i>"] = function()
              Util.telescope("find_files", { no_ignore = true })()
            end,
            ["<M-h>"] = function()
              Util.telescope("find_files", { hidden = true })()
            end,
            ["<C-Down>"] = function(...)
              return require("telescope.actions").cycle_history_next(...)
            end,
            ["<C-Up>"] = function(...)
              return require("telescope.actions").cycle_history_prev(...)
            end,
            ["<C-j>"] = function(...)
              return require("telescope.actions").move_selection_next(...)
            end,
            ["<C-k>"] = function(...)
              return require("telescope.actions").move_selection_previous(...)
            end,
            ["<M-p>"] = function(...)
              return require("telescope.actions.layout").toggle_preview(...)
            end,
          },
          n = {
            ["<M-p>"] = function(...)
              return require("telescope.actions.layout").toggle_preview(...)
            end,
            ["q"] = function(...)
              return require("telescope.actions").close(...)
            end,
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
    telescope.load_extension("luasnip")
    telescope.load_extension("bibtex")
    telescope.load_extension("heading")
  end,
}
