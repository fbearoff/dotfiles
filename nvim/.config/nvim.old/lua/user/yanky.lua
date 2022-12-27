local status_ok, yanky = pcall(require, "yanky")
if not status_ok then
  return
end

yanky.setup {
  ring = {
    history_length = 100,
    storage = "shada",
    sync_with_numbered_registers = true,
    cancel_event = "update",
  },
  picker = {
    select = {
      action = nil, -- nil to use default put action
    },
    telescope = {
      mappings = nil, -- nil to use default mappings
    },
  },
  system_clipboard = {
    sync_with_ring = true,
  },
  highlight = {
    on_put = false,
    on_yank = false,
    timer = 500,
  },
  preserve_cursor_position = {
    enabled = true,
  },
}

require("telescope").load_extension("yank_history")

vim.keymap.set({"n","x"}, "p", "<Plug>(YankyPutAfter)")
vim.keymap.set({"n","x"}, "P", "<Plug>(YankyPutBefore)")
vim.keymap.set("n", "<c-n>", "<Plug>(YankyCycleForward)")
vim.keymap.set("n", "<c-p>", "<Plug>(YankyCycleBackward)")
