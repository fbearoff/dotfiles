local M = {
  "lukas-reineke/indent-blankline.nvim",
}

M.event = "BufReadPre"

function M.config()
  local indent = require("indent_blankline")

  indent.setup({
    buftype_exclude = { "terminal", "nofile" },
    filetype_exclude = {
      "help",
      "startify",
      "dashboard",
      "packer",
      "neogitstatus",
      "NvimTree",
      "neo-tree",
      "Trouble",
    },
    char = "▏",
    space_char_blankline = " ",
    use_treesitter_scope = false,
    show_trailing_blankline_indent = false,
    show_current_context = true,
    show_current_context_start = true,
    show_first_indent_level = true,
    use_treesitter = true,
    context_patterns = {
      "class",
      "return",
      "function",
      "method",
      "^if",
      "^while",
      "jsx_element",
      "^for",
      "^object",
      "^table",
      "block",
      "arguments",
      "if_statement",
      "else_clause",
      "jsx_element",
      "jsx_self_closing_element",
      "try_statement",
      "catch_clause",
      "import_statement",
      "operation_type",
    },
  })
end

return M
