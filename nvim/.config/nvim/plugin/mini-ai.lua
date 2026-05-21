vim.pack.add({ "https://github.com/nvim-mini/mini.ai" })

local ai = require("mini.ai")

ai.setup({
  silent = false,
  custom_textobjects = {
    f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }), -- function
    A = ai.gen_spec.treesitter({ a = "@assignment.outer", i = "@assignment.inner" }), -- assignment
    C = ai.gen_spec.treesitter({ a = "@comment.outer", i = "@comment.inner" }), -- comment
    o = ai.gen_spec.treesitter({ --blocks
      a = { "@loop.outer", "@block.outer", "@conditional.outer" },
      i = { "@loop.inner", "@block.inner", "@conditional.inner" },
    }),
    a = false,
  },
})
