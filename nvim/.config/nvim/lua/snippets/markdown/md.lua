local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node

local date = function()
  return { os.date("%Y-%m-%d") }
end

ls.add_snippets(nil, {
  markdown = {
    s({
      trig = "meta",
      name = "Metadata",
      dscr = "Yaml metadata format for markdown",
    }, {
      t({ "---", "title: " }),
      i(1, "note_title"),
      t({ "", "author: " }),
      i(2, "author"),
      t({ "", "date: " }),
      f(date, {}),
      t({ "", "categories: [" }),
      i(3, ""),
      t({ "]", "lastmod: " }),
      f(date, {}),
      t({ "", "tags: [" }),
      i(4),
      t({ "]", "comments: true", "---", "" }),
      i(0),
    }),
    s({
      trig = "link2",
      name = "markdown_link",
      dscr = "Create markdown link [txt](url)",
    }, {
      t("["),
      f(function(_, snip)
        return snip.env.TM_SELECTED_TEXT[1] or {}
      end, {}),
      t("]("),
      i(1),
      t(")"),
      i(0),
    }),
    s({
      trig = "codewrap",
      name = "markdown_code_wrap",
      dscr = "Create markdown code block from existing text",
    }, {
      t("``` "),
      i(1, "Language"),
      t({ "", "" }),
      f(function(_, snip)
        local tmp = {}
        tmp = snip.env.TM_SELECTED_TEXT
        tmp[0] = nil
        return tmp or {}
      end, {}),
      t({ "", "```", "" }),
      i(0),
    }),
  },
})
