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
  -- Show code context as top line
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = "BufReadPre",
    keys = {
      { "<leader>uT", "<cmd>TSContext toggle<cr>", desc = "Toggle TS Context" },
      {
        "gC",
        function()
          require("treesitter-context").go_to_context()
        end,
        desc = "Goto Context",
      },
    },
    opts = {
      max_lines = 2,
      line_numbers = true,
    },
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
      local TS = require("nvim-treesitter")

      TS.setup(opts)

      UtilTS.get_installed(true) -- initialize the installed langs

      -- install missing parsers
      local install = vim.tbl_filter(function(lang)
        return not UtilTS.have(lang)
      end, opts.ensure_installed or {})
      if #install > 0 then
        TS.install(install, { summary = true }):await(function()
          UtilTS.get_installed(true) -- refresh the installed langs
        end)
      end

      -- treesitter highlighting
      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("treesitter", { clear = true }),
        callback = function(ev)
          if UtilTS.have(ev.match) then
            pcall(vim.treesitter.start)

            -- check if ftplugins changed foldexpr/indentexpr
            for _, option in ipairs({ "foldexpr", "indentexpr" }) do
              local expr = "v:lua.UtilTS." .. option .. "()"
              if vim.opt_global[option]:get() == expr then
                vim.opt_local[option] = expr
              end
            end
          end
        end,
      })
    end,
  },
  -- sort treesitter nodes
  {
    "mtrajano/tssorter.nvim",
    opts = {
      sortables = {
        r = {
          arguments = {
            node = "argument",
          },
        },
      },
    },
    keys = {
      {
        mode = { "n", "x" },
        "<leader>S",
        function()
          require("tssorter").sort()
        end,
        desc = "Sort",
      },
    },
  },
}
