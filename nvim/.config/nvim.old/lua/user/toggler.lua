local status_ok, nvim_toggler = pcall(require, "nvim-toggler")
if not status_ok then
  return
end

nvim_toggler.setup({
  -- your own inverses
  inverses = {
    ['TRUE'] = 'FALSE'
  },
  -- removes the default <leader>i keymap
  remove_default_keybinds = false,
  -- removes the default set of inverses
  remove_default_inverses = false,
})
