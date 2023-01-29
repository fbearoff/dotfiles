return {
  {
    "ellisonleao/glow.nvim",
    cmd = "Glow",
    keys = {
      { "<localleader>mg", "<cmd>Glow<cr>", desc = "Glow" }
    },
    opts = {
      pager = true,
    },
    config = true,
  },
  -- Markdown live preview, needs `webkit2gtk`
  {
    "toppair/peek.nvim",
    build = "deno task --quiet build:fast",
    keys = {
      {
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
    config = true,
  },

  -- Edit fenced language in popup
  { "AckslD/nvim-FeMaco.lua",
    cmd = "FeMaco",
    keys = {
      { "<localleader>mf", "<cmd>FeMaco<cr>", desc = "FeMaco" }
    },
    opts = {
      ---@diagnostic disable-next-line: unused-local
      ensure_newline = function(base_filetype)
        return true
      end,
    }
  },

  { 'quarto-dev/quarto-nvim',
    dependencies = {
      'jmbuhr/otter.nvim',
      -- 'neovim/nvim-lspconfig'
    },
    ft = "quarto",
    opts = {
      lspFeatures = {
        enabled = true,
        languages = { 'r', 'python', 'julia' },
        diagnostics = {
          enabled = false,
          triggers = { "BufWrite" }
        },
        completion = {
          enabled = false
        },
      },
    },
    config = function(_, opts)
      require("quarto").setup(opts)
      require("which-key").register({ ["<localleader>q"] = { name = "+Quarto" } })
      vim.keymap.set("n", "<localleader>qp", function() require 'quarto'.quartoPreview() end, { desc = 'Quarto Preview' })
      vim.keymap.set("n", "<localleader>qq", function() require 'quarto'.quartoClosePreview() end,
        { desc = 'Quarto Quit' })
    end
  },

  { "jakewvincent/mkdnflow.nvim",
    ft = { "markdown", "qmd" },
    keys = {
      { mode = { "n", "x" }, "<localleader><CR>", desc = "MD Enter" },

    },
    opts = {
      filetypes = {
        md = true,
        markdown = true,
        qmd = true,
      },
      mappings = {
        MkdnEnter = { { 'n', 'v' }, '<localleader><CR>' },
        MkdnTab = { 'i', '<Tab>' },
        MkdnSTab = { 'i', '<S-Tab>' },
        MkdnNextLink = { 'n', ']l' },
        MkdnPrevLink = { 'n', '[l' },
        MkdnNextHeading = { 'n', ']h' },
        MkdnPrevHeading = { 'n', '[h' },
        MkdnGoBack = false,
        MkdnGoForward = false,
        MkdnCreateLink = false, -- see MkdnEnter
        MkdnCreateLinkFromClipboard = { { 'n', 'v' }, '<localleader>ml' }, -- see MkdnEnter
        MkdnFollowLink = false, -- see MkdnEnter
        MkdnDestroyLink = { 'n', '<localleader>md' },
        MkdnTagSpan = { 'v', '<localleader>ms' },
        MkdnMoveSource = { 'n', '<localleader>mm' },
        MkdnYankAnchorLink = { 'n', '<localleader>my' },
        MkdnYankFileAnchorLink = { 'n', '<localleader>mY' },
        MkdnIncreaseHeading = { 'n', '<localleader>m+' },
        MkdnDecreaseHeading = { 'n', '<localleader>m-' },
        MkdnToggleToDo = { { 'n', 'x' }, '<localleader><localleader>' },
        MkdnNewListItem = { 'i', '<CR>' },
        MkdnNewListItemBelowInsert = { 'n', 'o' },
        MkdnNewListItemAboveInsert = { 'n', 'O' },
        MkdnExtendList = false,
        MkdnUpdateNumbering = { 'n', '<localleader>mn' },
        MkdnTableNextCell = false,
        MkdnTablePrevCell = false,
        MkdnTableNextRow = false,
        MkdnTablePrevRow = false,
        MkdnTableNewRowBelow = { 'n', '<localleader>mtr' },
        MkdnTableNewRowAbove = { 'n', '<localleader>mtR' },
        MkdnTableNewColAfter = { 'n', '<localleader>mtc' },
        MkdnTableNewColBefore = { 'n', '<localleader>mtC' },
        MkdnFoldSection = { 'n', '<localleader>mf' },
        MkdnUnfoldSection = { 'n', '<localleader>mF' },
      },
    },
    config = function(_, opts)
      require("mkdnflow").setup(opts)
      require("which-key").register(
        {
          ["<localleader>m"] = { mode = { "n", "v" }, name = "+Markdown" },
          ["<localleader>mt"] = { name = "+Table" },
        }
      )
      vim.keymap.set("n", "<localleader>mb", 'o```{r}<cr>```<esc>O', { desc = "Insert R Code Block" })
      vim.keymap.set("n", "<localleader>mB", 'o```{python}<cr>```<esc>O', { desc = "Insert Python Code Block" })
      vim.keymap.set("n", "<localleader>mh", 'O# ', { desc = "Insert MD Header" })
      vim.keymap.set("n", "<localleader>mP", '""p', { desc = "Paste Heading Reference" })
      vim.keymap.set("n", "<localleader>mtn", ':MkdnTable ', { desc = "New Table (col row)" })
    end
  },
}
