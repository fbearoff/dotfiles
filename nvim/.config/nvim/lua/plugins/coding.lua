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
      local objects = {
        { " ", desc = "Whitespace" },
        { '"', desc = 'Balanced "' },
        { "'", desc = "Balanced '" },
        { "`", desc = "Balanced `" },
        { "(", desc = "Balanced (" },
        { ")", desc = "Balanced ) with ws" },
        { ">", desc = "Balanced > with ws" },
        { "<lt>", desc = "Balanced <" },
        { "", desc = "Balanced ] with ws" },
        { "[", desc = "Balanced [" },
        { "}", desc = "Balanced } with ws" },
        { "{", desc = "Balanced {" },
        { "?", desc = "User Prompt" },
        { "a", desc = "Assignment" },
        { "A", desc = "Assignment LHS, RHS" },
        { "b", desc = "Balanced ), ], }" },
        { "c", desc = "Call, Class" },
        { "f", desc = "Function" },
        { "#", desc = "Number" },
        { "C", desc = "Comment" },
        { "o", desc = "Block, conditional, loop" },
        { "q", desc = "Quote `\"'" },
        { "t", desc = "Tag" },
        { "|", desc = "Pipe, Command" },
        { "g", desc = "Entire Buffer" },
      }
      local ret = { mode = { "o", "x" } }
      local mappings = vim.tbl_extend("force", {}, {
        around = "a",
        inside = "i",
        around_next = "an",
        inside_next = "in",
        around_last = "al",
        inside_last = "il",
      }, opts.mappings or {})
      mappings.goto_left = nil
      mappings.goto_right = nil

      for name, prefix in pairs(mappings) do
        name = name:gsub("^around_", ""):gsub("^inside_", "")
        ret[#ret + 1] = { prefix, group = name }
        for _, obj in ipairs(objects) do
          local desc = obj.desc
          if prefix:sub(1, 1) == "i" then
            desc = desc:gsub(" with ws", "")
          end
          ret[#ret + 1] = { prefix .. obj[1], desc = obj.desc }
        end
      end
      require("which-key").add(ret)
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
