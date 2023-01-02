local M = {
  "folke/noice.nvim",
  event = "VeryLazy",
}

function M.config()

  require("noice").setup({
    lsp = {
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
        ["cmp.entry.get_documentation"] = true,
      },
    },
    routes = {
      {
        filter = {
          event = "msg_show",
          find = "%d+L, %d+B",
        },
        view = "mini",
      },
      {
        {
          filter = {
            event = "msg_show",
            kind = "search_count",
          },
          opts = { skip = true },
        },
        filter = {
          event = "msg_show",
          kind = "search_count",
        },
        opts = { skip = true },
      },
      {
        filter = {
          event = "msg_show",
          kind = "",
        },
        opts = { skip = true },
      },
    },
    presets = {
      bottom_search = true,
      command_palette = true,
      long_message_to_split = true,
      inc_rename = true,
      cmdline_output_to_split = false,
    },
    commands = {
      all = {
        -- options for the message history that you get with `:Noice`
        view = "split",
        opts = { enter = true, format = "details" },
        filter = {},
      },
    },
  })

  vim.keymap.set("c", "<S-Enter>", function()
    require("noice").redirect(vim.fn.getcmdline())
  end, { desc = "Redirect Cmdline" })

  vim.keymap.set("n", "<c-f>", function()
    if not require("noice.lsp").scroll(4) then
      return "<c-f>"
    end
  end, { silent = true, expr = true })

  vim.keymap.set("n", "<c-b>", function()
    if not require("noice.lsp").scroll(-4) then
      return "<c-b>"
    end
  end, { silent = true, expr = true })

  vim.api.nvim_create_autocmd("FileType", {
    pattern = "markdown",
    callback = function(event)
      vim.schedule(function()
        require("noice.text.markdown").keys(event.buf)
      end)
    end,
  })
end

return M
