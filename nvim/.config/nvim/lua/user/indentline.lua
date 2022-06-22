local status_ok, indent_blankline = pcall(require, "indent_blankline")
if not status_ok then
  return
end

indent_blankline.setup({
  space_char_blankline = " ",
  char = '▏',
  show_current_context = true,
  show_current_context_start = true,
  show_trailing_blankline_indent = false,
  indent_blankline_buftype_exclude = { "terminal", "nofile" },
  indent_blankline_filetype_exclude = {
    "help",
    "startify",
    "dashboard",
    "packer",
    "neogitstatus",
    "NvimTree",
    "Trouble",
  }
})
