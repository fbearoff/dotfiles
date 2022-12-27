local status_ok, noice = pcall(require, "noice")
if not status_ok then
  return
end
noice.setup {
  lsp = {
    -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
    override = {
      ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      ["vim.lsp.util.stylize_markdown"] = true,
      ["cmp.entry.get_documentation"] = true,
    },
    progress = {
      enabled = true,
      -- Lsp Progress is formatted using the builtins for lsp_progress. See config.format.builtin
      -- See the section on formatting for more details on how to customize.
      format = "lsp_progress",
      format_done = "lsp_progress_done",
      throttle = 1000 / 30, -- frequency to update lsp progress message
      view = "mini",
    },
  },
  -- you can enable a preset for easier configuration
  presets = {
    bottom_search = true, -- use a classic bottom cmdline for search
    command_palette = true, -- position the cmdline and popupmenu together
    long_message_to_split = true, -- long messages will be sent to a split
    inc_rename = false, -- enables an input dialog for inc-rename.nvim
    lsp_doc_border = false, -- add a border to hover docs and signature help
  },
  routes = {
    {
      filter = {
        event = "msg_show",
        kind = "",
        any = {
          { find = "written" },
          { find = "line less" },
          { find = "fewer lines" },
          { find = "more line" },
          { find = "change; before" },
          { find = "change; after" },
          { find = ">ed" },
          { find = "<ed" },
        },
      },
      opts = { skip = true },
    },
  },
}
