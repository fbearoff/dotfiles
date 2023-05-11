local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local c = ls.choice_node
local i = ls.insert_node

ls.add_snippets(nil, {
  r = {
    s({
      trig = ">>",
      name = "mpipe",
      dscr = "Magrittr Pipe (%>%)",
      snippetType = "autosnippet",
    }, {
      t({ "%>% " }),
    }),
    s({
      trig = "<<",
      name = "l_assign",
      dscr = "Left Assign (<-)",
      snippetType = "autosnippet",
    }, {
      t({ "<- " }),
    }),
    s({
      trig = ">i",
      name = "in_operator",
      dscr = "%in% Operator",
      snippetType = "autosnippet",
    }, {
      t({ "%in% " }),
    }),
    s({
      trig = "pipe",
      name = "pipe_sel",
      dscr = "Pipe Selector",
      snippetType = "snippet",
    }, {
      c(1, {
        t("%>% "),
        t("|> "),
        t("%<>% "),
        t("%T>% "),
        t("%$% "),
      }),
      i(0),
    }),
  },
})
