return {

  -- Code block joing/splitting
  {
    "Wansmer/treesj",
    keys = {
      {
        mode = { "n", "x" },
        "gj",
        function()
          require("treesj").join()
        end,
        desc = "Join Line",
      },
      {
        mode = { "n", "x" },
        "gk",
        function()
          require("treesj").split()
        end,
        desc = "Split Line",
      },
    },
    cmd = { "TSJSplit", "TSJJoin", "TSJToggle" },
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
          c = ai.gen_spec.treesitter({
            a = { "@call.outer", "@class.outer" },
            i = { "@call.inner", "@class.inner" },
          }, {}),
          ["#"] = ai.gen_spec.treesitter({ a = "@number.inner", i = "@number.inner" }, {}),
          C = ai.gen_spec.treesitter({ a = "@comment.outer", i = "@comment.inner" }, {}),
          ["|"] = ai.gen_spec.treesitter({
            a = { "@pipe.outer", "@command.outer" },
            i = { "@pipe.inner", "@command.inner" },
          }, {}),
          a = ai.gen_spec.treesitter({ a = "@assignment.outer", i = "@assignment.inner" }, {}),
          A = ai.gen_spec.treesitter({ a = "@assignment.lhs", i = "@assignment.rhs" }, {}),
          -- Whole buffer
          g = function(ai_type)
            local n_lines = vim.fn.line("$")
            local start_line, end_line = 1, n_lines
            if ai_type == "i" then
              local first_nonblank, last_nonblank = vim.fn.nextnonblank(1), vim.fn.prevnonblank(n_lines)
              start_line = first_nonblank == 0 and 1 or first_nonblank
              end_line = last_nonblank == 0 and n_lines or last_nonblank
            end

            local to_col = math.max(vim.fn.getline(end_line):len(), 1)
            return { from = { line = start_line, col = 1 }, to = { line = end_line, col = to_col } }
          end,
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
        a = "Assignment",
        A = "Assignment LHS, RHS",
        b = "Balanced ), ], }",
        c = "Call, Class",
        f = "Function",
        ["#"] = "Number",
        C = "Comment",
        o = "Block, conditional, loop",
        q = "Quote `, \", '",
        t = "Tag",
        ["|"] = "Pipe, Command",
        g = "Entire Buffer",
      }
      local a = vim.deepcopy(i)
      for k, v in pairs(a) do
        a[k] = v:gsub(" including.*", "")
      end

      local ic = vim.deepcopy(i)
      local ac = vim.deepcopy(a)
      for key, name in pairs({ n = "Next", l = "Last" }) do
        ---@diagnostic disable-next-line: assign-type-mismatch
        i[key] = vim.tbl_extend("force", { name = "Inside " .. name .. " Textobject" }, ic)
        ---@diagnostic disable-next-line: assign-type-mismatch
        a[key] = vim.tbl_extend("force", { name = "Around " .. name .. " Textobject" }, ac)
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
        mode = { "o", "x" },
        "a_",
        "<cmd>lua require('various-textobjs').lineCharacterwise(false)<cr>",
        desc = "Line (CharWise)",
      },
      {
        mode = { "o", "x" },
        "i_",
        "<cmd>lua require('various-textobjs').lineCharacterwise(true)<cr>",
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
}
