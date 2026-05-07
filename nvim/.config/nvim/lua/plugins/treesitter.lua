-- TS keymaps
-- Incremental Selection

vim.keymap.set({ "x", "o" }, "aa", function()
  if vim.treesitter.get_parser(nil, nil, { error = false }) then
    require("vim.treesitter._select").select_parent(vim.v.count1)
  else
    vim.lsp.buf.selection_range(vim.v.count1)
  end
end, { desc = "Select parent treesitter node or outer incremental lsp selections" })

vim.keymap.set({ "x", "o" }, "ii", function()
  if vim.treesitter.get_parser(nil, nil, { error = false }) then
    require("vim.treesitter._select").select_child(vim.v.count1)
  else
    vim.lsp.buf.selection_range(-vim.v.count1)
  end
end, { desc = "Select child treesitter node or inner incremental lsp selections" })

-- View Code Tree
vim.keymap.set("n", "<leader>si", "<cmd>InspectTree<cr>", { desc = "Inspect Tree" })

return {
  -- Code tree based highlighting and other features
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    build = function()
      local TS = require("nvim-treesitter")
      TS.update(nil, { summary = true })
    end,
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      ensure_installed = {
        "bash",
        "dockerfile",
        "diff",
        "git_rebase",
        "gitignore",
        "html",
        "ini",
        "json",
        "lua",
        "luadoc",
        "luap",
        "markdown",
        "markdown_inline",
        "python",
        "query",
        "r",
        "regex",
        "rnoweb",
        "toml",
        "vim",
        "vimdoc",
        "xml",
        "yaml",
        "zsh",
      },
    },
    config = function(_, opts)
      require("nvim-treesitter").install(opts.ensure_installed)
      local function treesitter_try_attach(buf, language)
        -- Check if a parser exists and load it
        if not vim.treesitter.language.add(language) then
          return
        end
        -- Enable syntax highlighting and other treesitter features
        vim.treesitter.start(buf, language)

        -- Enable treesitter based folds
        -- LSP overrides this
        vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
        vim.wo.foldmethod = "expr"

        -- Enable treesitter based indentation if available
        if vim.treesitter.query.get(language, "indents") ~= nil then
          vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
      end

      local available_parsers = require("nvim-treesitter").get_available()
      vim.api.nvim_create_autocmd("FileType", {
        callback = function(args)
          local buf, filetype = args.buf, args.match

          local language = vim.treesitter.language.get_lang(filetype)
          if not language then
            return
          end

          local installed_parsers = require("nvim-treesitter").get_installed("parsers")

          if vim.tbl_contains(installed_parsers, language) then
            -- Enable the parser if it is already installed
            treesitter_try_attach(buf, language)
          elseif vim.tbl_contains(available_parsers, language) then
            -- If a parser is available in `nvim-treesitter`, auto-install it and enable it after the installation is done
            require("nvim-treesitter").install(language):await(function()
              treesitter_try_attach(buf, language)
            end)
          else
            -- Try to enable treesitter features in case the parser exists but is not available from `nvim-treesitter`
            treesitter_try_attach(buf, language)
          end
        end,
      })
    end,
  },
  -- Show code context as top line
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = "BufReadPre",
    keys = {
      {
        "gC",
        function()
          require("treesitter-context").go_to_context()
        end,
        desc = "Goto Context",
      },
    },
    opts = function()
      local tsc = require("treesitter-context")
      Snacks.toggle({
        name = "Treesitter Context",
        get = tsc.enabled,
        set = function(state)
          if state then
            tsc.enable()
          else
            tsc.disable()
          end
        end,
      }):map("<leader>uT")
      return {
        max_lines = 2,
        line_numbers = true,
      }
    end,
  },
  -- extended textobjects
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    event = "BufReadPost",
    init = function()
      vim.g.no_plugin_maps = true
    end,
    opts = {
      select = {
        lookahead = true,
      },
    },
    keys = {
      {
        mode = { "x", "o" },
        "aq",
        function()
          require("nvim-treesitter-textobjects.select").select_textobject("@string.outer")
        end,
        desc = "Quote",
      },
      {
        mode = { "x", "o" },
        "iq",
        function()
          require("nvim-treesitter-textobjects.select").select_textobject("@string.inner")
        end,
        desc = "Quote",
      },
      -- define new textobjects
      {
        mode = { "x", "o" },
        "af",
        function()
          require("nvim-treesitter-textobjects.select").select_textobject("@function.outer")
        end,
        desc = "Function",
      },
      {
        mode = { "x", "o" },
        "if",
        function()
          require("nvim-treesitter-textobjects.select").select_textobject("@function.inner")
        end,
        desc = "Function",
      },
      {
        mode = { "x", "o" },
        "iC",
        function()
          require("nvim-treesitter-textobjects.select").select_textobject("@comment.inner")
        end,
        desc = "Comment",
      },
      {
        mode = { "x", "o" },
        "aC",
        function()
          require("nvim-treesitter-textobjects.select").select_textobject("@comment.outer")
        end,
        desc = "Comment",
      },
      {
        mode = { "x", "o" },
        "#",
        function()
          require("nvim-treesitter-textobjects.select").select_textobject("@number.inner")
        end,
        desc = "Number",
      },
      -- next/previous textobject
      {
        "]C",
        function()
          require("nvim-treesitter-textobjects.move").goto_next_start("@comment.outer")
        end,
        desc = "Next Comment",
      },
      {
        "[C",
        function()
          require("nvim-treesitter-textobjects.move").goto_previous_start("@comment.outer")
        end,
        desc = "Previous Comment",
      },
      {
        "]#",
        function()
          require("nvim-treesitter-textobjects.move").goto_next_start("@number.inner")
        end,
        desc = "Next Number",
      },
      {
        "[#",
        function()
          require("nvim-treesitter-textobjects.move").goto_previous_start("@number.inner")
        end,
        desc = "Previous Number",
      },
      {
        "<C-S-l>",
        function()
          require("nvim-treesitter-textobjects.swap").swap_next("@parameter.inner")
        end,
        desc = "Swap Next Sibling",
      },
      {
        "<C-S-h>",
        function()
          require("nvim-treesitter-textobjects.swap").swap_previous("@parameter.inner")
        end,
        desc = "Swap Previous Sibling",
      },
    },
  },
}
