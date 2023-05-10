local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node

ls.add_snippets(nil, {
  r = {
    s({
      trig = ">>",
      namr = "pipe",
      dscr = "Magrittr Pipe (%>%)",
      snippetType = "autosnippet",
    }, {
      t({ "%>% " }),
    }),
    s({
      trig = "<<",
      namr = "l_assign",
      dscr = "Left Assign (<-)",
      snippetType = "autosnippet",
    }, {
      t({ "<- " }),
    }),
    s({
      trig = ">i",
      namr = "in_operator",
      dscr = "%in% Operator",
      snippetType = "autosnippet",
    }, {
      t({ "%in% " }),
    }),
  },
})
