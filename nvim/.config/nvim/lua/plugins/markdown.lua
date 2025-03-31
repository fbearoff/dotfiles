return {
  -- Markdown live preview, needs `webkit2gtk`
  {
    "toppair/peek.nvim",
    build = "deno task --quiet build:fast",
    keys = {
      {
        ft = "markdown",
        "<localleader>mp",
        function()
          local peek = require("peek")
          if peek.is_open() then
            peek.close()
          else
            peek.open()
          end
        end,
        desc = "Peek",
      },
    },
    opts = {
      filetype = { "markdown" },
    },
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown" },
    keys = {
      {
        ft = "markdown",
        "<localleader>mr",
        function()
          require("render-markdown").buf_toggle()
        end,
        desc = "Toggle Markdown Rendering",
      },
    },
    opts = {
      completions = { blink = { enabled = true } },
      code = {
        sign = false,
        width = "block",
        right_pad = 1,
      },
      checkbox = {
        checked = { scope_highlight = "@markup.strikethrough" },
      },
      heading = {
        sign = false,
        width = "block",
        left_pad = 2,
        right_pad = 4,
      },
    },
  },
}
