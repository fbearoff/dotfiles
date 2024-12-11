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
    "jakewvincent/mkdnflow.nvim",
    enabled = true,
    keys = {
      { ft = "markdown", "<localleader>m", "", desc = "+Markdown" },
      { ft = "markdown", mode = { "n", "x" }, "<localleader><CR>", desc = "MD Enter" },
      { ft = "markdown", "<localleader>mP", '""p', desc = "Paste Heading Reference" },
      { ft = "markdown", "<localleader>mtn", ":MkdnTable ", desc = "New Table (col row)" },
    },
    opts = {
      filetypes = {
        md = true,
        markdown = true,
      },
      mappings = {
        MkdnEnter = { { "n", "v", "i" }, "<CR>" },
        MkdnTab = { "i", "<Tab>" },
        MkdnSTab = { "i", "<S-Tab>" },
        MkdnNextLink = { "n", "]l" },
        MkdnPrevLink = { "n", "[l" },
        MkdnNextHeading = { "n", "]h" },
        MkdnPrevHeading = { "n", "[h" },
        MkdnGoBack = false,
        MkdnGoForward = false,
        MkdnCreateLink = false, -- see MkdnEnter
        MkdnCreateLinkFromClipboard = { { "n", "v" }, "<localleader>ml" }, -- see MkdnEnter
        MkdnFollowLink = false, -- see MkdnEnter
        MkdnDestroyLink = { "n", "<localleader>md" },
        MkdnTagSpan = { "v", "<localleader>ms" },
        MkdnMoveSource = { "n", "<localleader>mm" },
        MkdnYankAnchorLink = { "n", "<localleader>my" },
        MkdnYankFileAnchorLink = { "n", "<localleader>mY" },
        MkdnIncreaseHeading = { "n", "<localleader>m+" },
        MkdnDecreaseHeading = { "n", "<localleader>m-" },
        MkdnToggleToDo = { { "n", "x" }, "<localleader><localleader>" },
        MkdnNewListItem = false,
        MkdnNewListItemBelowInsert = { "n", "o" },
        MkdnNewListItemAboveInsert = { "n", "O" },
        MkdnExtendList = false,
        MkdnUpdateNumbering = { "n", "<localleader>mn" },
        MkdnTableNextCell = false,
        MkdnTablePrevCell = false,
        MkdnTableNextRow = false,
        MkdnTablePrevRow = false,
        MkdnTableNewRowBelow = { "n", "<localleader>mtr" },
        MkdnTableNewRowAbove = { "n", "<localleader>mtR" },
        MkdnTableNewColAfter = { "n", "<localleader>mtc" },
        MkdnTableNewColBefore = { "n", "<localleader>mtC" },
        MkdnFoldSection = { "n", "<localleader>mf" },
        MkdnUnfoldSection = { "n", "<localleader>mF" },
      },
    },
  },
}
