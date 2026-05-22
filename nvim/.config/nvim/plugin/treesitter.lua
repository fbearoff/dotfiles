vim.pack.add({
  { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
  "https://github.com/nvim-treesitter/nvim-treesitter-context",
  { src = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects", version = "main" },
})

local parsers = {
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
}
require("nvim-treesitter").install(parsers)
local function treesitter_try_attach(buf, language)
  -- Check if a parser exists and load it
  if not vim.treesitter.language.add(language) then
    return
  end
  -- Enable syntax highlighting and other treesitter features
  vim.treesitter.start(buf, language)

  -- Enable treesitter based folds
  vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
  vim.wo.foldmethod = "expr"

  local has_indent_query = vim.treesitter.query.get(language, "indents") ~= nil

  -- Enable treesitter based indentation
  if has_indent_query then
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

-- Show code context as top line
local tsc = require("treesitter-context")
tsc.setup({
  max_lines = 2,
  line_numbers = true,
})

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

-- treesitter-textobjects
vim.g.no_plugin_maps = true
require("nvim-treesitter-textobjects").setup({
  select = {
    lookahead = true,
  },
})

-- select is handled by mini.ai

-- next/previous textobject
vim.keymap.set("n", "]C", function()
  require("nvim-treesitter-textobjects.move").goto_next_start("@comment.outer")
end, { desc = "Next Comment" })
vim.keymap.set("n", "[C", function()
  require("nvim-treesitter-textobjects.move").goto_previous_start("@comment.outer")
end, { desc = "Previous Comment" })
vim.keymap.set("n", "]#", function()
  require("nvim-treesitter-textobjects.move").goto_next_start("@number.inner")
end, { desc = "Next Number" })
vim.keymap.set("n", "[#", function()
  require("nvim-treesitter-textobjects.move").goto_previous_start("@number.inner")
end, { desc = "Previous Number" })

-- swap
vim.keymap.set("n", "<C-S-l>", function()
  require("nvim-treesitter-textobjects.swap").swap_next("@parameter.inner")
end, { desc = "Swap Next Sibling" })
vim.keymap.set("n", "<C-S-h>", function()
  require("nvim-treesitter-textobjects.swap").swap_previous("@parameter.inner")
end, { desc = "Swap Previous Sibling" })
