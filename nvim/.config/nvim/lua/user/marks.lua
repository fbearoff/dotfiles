local status_ok, marks = pcall(require, "marks")
if not status_ok then
  return
end

marks.setup {
  default_mappings = false,
  builtin_marks = { ".", "<", ">", "^" },
  cyclic = true,
  refresh_interval = 250,
  sign_priority = { lower = 10, upper = 15, builtin = 8, bookmark = 20 },
  excluded_filetypes = { "lspinfo", "toggleterm" },
  mappings = {
    delete_line = "dm"
  }
}
