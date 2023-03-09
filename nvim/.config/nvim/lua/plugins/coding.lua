return {

  -- Code block joing/splitting
  {
    "Wansmer/treesj",
    keys = {
      { "<leader>J", "<cmd>TSJJoin<CR>", desc = "Join Line" },
      { "<leader>S", "<cmd>TSJSplit<CR>", desc = "Split Line" },
    },
    cmd = { "TSJSplit", "TSJJoin" },
    opts = {
      use_default_keymaps = false,
      max_join_length = 150,
    },
  },

  -- Better text-objects
  {
    "echasnovski/mini.ai",
    event = "VeryLazy",
    dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
    opts = function()
      local ai = require("mini.ai")
      return {
        n_lines = 500,
        custom_textobjects = {
          o = ai.gen_spec.treesitter({
            a = { "@block.outer", "@conditional.outer", "@loop.outer" },
            i = { "@block.inner", "@conditional.inner", "@loop.inner" },
          }, {}),
          f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }, {}),
          c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }, {}),
          ["#"] = ai.gen_spec.treesitter({ a = "@number.inner", i = "@number.inner" }, {}),
          C = ai.gen_spec.treesitter({ a = "@comment.outer", i = "@comment.outer" }, {}), -- TODO: update when @comment.inner is added <09-03-23>
        },
      }
    end,
    config = function(_, opts)
      -- register all text objects with which-key
      require("mini.ai").setup(opts)
      local i = {
        [" "] = "Whitespace",
        ['"'] = 'Balanced "',
        ["'"] = "Balanced '",
        ["`"] = "Balanced `",
        ["("] = "Balanced (",
        [")"] = "Balanced ) including white-space",
        [">"] = "Balanced > including white-space",
        ["<lt>"] = "Balanced <",
        ["]"] = "Balanced ] including white-space",
        ["["] = "Balanced [",
        ["}"] = "Balanced } including white-space",
        ["{"] = "Balanced {",
        ["?"] = "User Prompt",
        _ = "Underscore",
        a = "Argument",
        b = "Balanced ), ], }",
        c = "Class",
        f = "Function",
        ["#"] = "Number",
        C = "Comment",
        o = "Block, conditional, loop",
        q = "Quote `, \", '",
        t = "Tag",
      }
      local a = vim.deepcopy(i)
      for k, v in pairs(a) do
        a[k] = v:gsub(" including.*", "")
      end

      local ic = vim.deepcopy(i)
      local ac = vim.deepcopy(a)
      for key, name in pairs({ n = "Next", l = "Last" }) do
        ---@diagnostic disable-next-line: assign-type-mismatch
        i[key] = vim.tbl_extend("force", { name = "Inside " .. name .. " textobject" }, ic)
        ---@diagnostic disable-next-line: assign-type-mismatch
        a[key] = vim.tbl_extend("force", { name = "Around " .. name .. " textobject" }, ac)
      end
      require("which-key").register({
        mode = { "o", "x" },
        i = i,
        a = a,
      })
    end,
  },

  -- More textobjects
  {
    "chrisgrieser/nvim-various-textobjs",
    event = "BufReadPost",
    keys = {
      {
        mode = { "o", "x" },
        "!",
        function()
          require("various-textobjs").diagnostic()
        end,
        desc = "Diagnostic",
      },
      {
        mode = { "o", "x" },
        "aS",
        function()
          require("various-textobjs").subword(false)
        end,
        desc = "Subword",
      },
      {
        mode = { "o", "x" },
        "iS",
        function()
          require("various-textobjs").subword(true)
        end,
        desc = "Subword",
      },
      {
        mode = { "x", "o" },
        "gG",
        function()
          require("various-textobjs").entireBuffer()
        end,
        desc = "Entire Buffer",
      },
      {
        mode = "o",
        "L",
        function()
          require("various-textobjs").url()
        end,
        desc = "Link",
      },
      {
        mode = { "o", "x" },
        "iE",
        function()
          require("various-textobjs").mdFencedCodeBlock(true)
        end,
        desc = "MD Codeblock",
      },
      {
        mode = { "o", "x" },
        "aE",
        function()
          require("various-textobjs").mdFencedCodeBlock(false)
        end,
        desc = "MD Codeblock",
      },
      {
        mode = { "o", "x" },
        "E",
        function()
          require("various-textobjs").nearEoL()
        end,
        desc = "Near EOL",
      },
      {
        "gx",
        function()
          require("various-textobjs").url() -- select URL
          local foundURL = vim.fn.mode():find("v") -- only switches to visual mode if found
          local url
          if foundURL then
            vim.cmd.normal({ '"zy', bang = true }) -- retrieve URL with "z as intermediary
            url = vim.fn.getreg("z")
            os.execute("xdg-open '" .. url .. "'")
          else
            -- if not found in proximity, search whole buffer via urlview.nvim instead
            vim.cmd.UrlView("buffer")
          end
        end,
        desc = "Smart URL Opener",
      },
    },
    opts = {
      lookForwardLines = 500,
    },
  },

  -- Show outline of document symbols
  {
    "simrat39/symbols-outline.nvim",
    cmd = "SymbolsOutline",
    init = function()
      vim.keymap.set("n", "<leader>cs", "<cmd>SymbolsOutline<cr>", { desc = "Symbols Outline" })
    end,
    opts = {},
  },

  -- Dim everything button current context
  { "folke/twilight.nvim" },

  -- Hide distraction
  {
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
    opts = {
      window = {
        width = 1,
      },
      plugins = {
        gitsigns = true,
        tmux = true,
      },
    },
    keys = { { "<leader>z", "<cmd>ZenMode<cr>", desc = "Zen Mode" } },
  },
}
