local status_ok, surround = pcall(require, "surround")
if not status_ok then
  return
end

surround.setup {
  mappings_style = 'sandwich',
  space_on_closing_char = true
}
