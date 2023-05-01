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
        n_lines = 100,
        custom_textobjects = {
          o = ai.gen_spec.treesitter({
            a = { "@block.outer", "@conditional.outer", "@loop.outer" },
            i = { "@block.inner", "@conditional.inner", "@loop.inner" },
          }, {}),
          f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }, {}),
          c = ai.gen_spec.treesitter({ a = "@call.outer", i = "@call.inner" }, {}),
          ["#"] = ai.gen_spec.treesitter({ a = "@number.inner", i = "@number.inner" }, {}),
          C = ai.gen_spec.treesitter({ a = "@comment.outer", i = "@comment.inner" }, {}),
          P = ai.gen_spec.treesitter({ a = "@pipe.outer", i = "@pipe.inner" }, {}),
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
        c = "Call",
        f = "Function",
        ["#"] = "Number",
        C = "Comment",
        o = "Block, conditional, loop",
        q = "Quote `, \", '",
        t = "Tag",
        P = "Pipe",
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
        "<cmd>lua require('various-textobjs').diagnostic()<cr>",
        desc = "Diagnostic",
      },
      {
        mode = { "o", "x" },
        "aS",
        "<cmd>lua require('various-textobjs').subword(false)<cr>",
        desc = "Subword",
      },
      {
        mode = { "o", "x" },
        "iS",
        "<cmd>lua require('various-textobjs').subword(true)<cr>",
        desc = "Subword",
      },
      {
        mode = { "x", "o" },
        "gG",
        "<cmd>lua require('various-textobjs').entireBuffer()<cr>",
        desc = "Entire Buffer",
      },
      {
        mode = "o",
        "L",
        "<cmd>lua require('various-textobjs').url()<cr>",
        desc = "Link",
      },
      {
        mode = { "o", "x" },
        "E",
        "<cmd>lua require('various-textobjs').nearEoL()<cr>",
        desc = "Near EOL",
      },
      {
        mode = "o",
        "_",
        "<cmd>lua require('various-textobjs').lineCharacterwise()<cr>",
        desc = "Line (CharWise)",
      },
      {
        mode = { "o", "x" },
        "|",
        "<cmd>lua require('various-textobjs').column()<cr>",
        desc = "Column",
      },
      {
        mode = { "o", "x" },
        "ak",
        "<cmd>lua require('various-textobjs').key(false)<cr>",
        desc = "Key",
      },
      {
        mode = { "o", "x" },
        "ik",
        "<cmd>lua require('various-textobjs').key(true)<cr>",
        desc = "Key",
      },
      {
        mode = { "o", "x" },
        "av",
        "<cmd>lua require('various-textobjs').value(false)<cr>",
        desc = "Value",
      },
      {
        mode = { "o", "x" },
        "iv",
        "<cmd>lua require('various-textobjs').value(true)<cr>",
        desc = "Value",
      },
      {
        "gx",
        function()
          require("various-textobjs").url() -- select URL
          local foundURL = vim.fn.mode():find("v")
          if not foundURL then
            vim.cmd.UrlView("buffer")
            return
          end
          vim.cmd.normal({ '"zy', bang = true })
          local url = vim.fn.getreg("z")
          local opener = "xdg-open"
          local openCommand = string.format("%s '%s' &>/dev/null", opener, url)
          os.execute(openCommand)
        end,
        desc = "Smart URL Opener",
      },
    },
    opts = {},
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

  {
    "jackMort/ChatGPT.nvim",
    cmd = {
      "ChatGPT",
      "ChatGPTActAs",
      "ChatGPTEditWithInstructions",
      "ChatGPTRun",
    },
    keys = {
      {
        mode = { "n", "x" },
        "<leader>ae",
        function()
          require("chatgpt").edit_with_instructions()
        end,
        desc = "ChatGTP Edit",
      },
      { mode = { "n", "x" }, "<leader>ar", ":ChatGPTRun ", desc = "ChatGTP Run" },
      {
        "<leader>aa",
        function()
          require("chatgpt").selectAwesomePrompt()
        end,
        desc = "ChatGTP Act As",
      },
      {
        "<leader>ac",
        function()
          require("chatgpt").openChat()
        end,
        desc = "ChatGTP Prompt",
      },
    },
    opts = {
      edit_with_instructions = {
        keymaps = {
          accept = "<C-cr>",
          use_output_as_input = "<S-cr>",
        },
      },
      popup_layout = {
        size = {
          height = "50%",
          width = "50%",
        },
      },
      popup_window = {
        filetype = "markdown",
      },
      popup_input = {
        submit = "<cr>",
      },
    },
  },
}
