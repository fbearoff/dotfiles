local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep

local calculate_comment_string = require('Comment.ft').calculate
local utils = require('Comment.utils')

local get_cstring = function(ctype)
  local cstring = calculate_comment_string { ctype = ctype, range = utils.get_region() } or vim.bo.commentstring
  local left, right = utils.unwrap_cstr(cstring)
  return { left, right }
end

local vars = {
  initials = 'fb',
}

--- Options for marks to be used in a TODO comment
local marks = {
  signature = function()
    return fmt('<{}>', i(1, vars.initials))
  end,
  date_signature = function()
    return fmt('<{}{}>', { i(1, os.date '%d-%m-%y'), i(2, ', ' .. vars.initials) })
  end,
  date = function()
    return fmt('<{}>', i(1, os.date '%d-%m-%y'))
  end,
  empty = function()
    return t ''
  end,
}

local todo_snippet_nodes = function(aliases, opts)
  local aliases_nodes = vim.tbl_map(function(alias)
    return i(nil, alias)
  end, aliases)
  local sigmark_nodes = {}
  for _, mark in pairs(marks) do
    table.insert(sigmark_nodes, mark())
  end

  local comment_node = fmta('<> <>: <> <> <><>', {
    f(function()
      return get_cstring(opts.ctype)[1]
    end),
    c(1, aliases_nodes),
    i(3),
    c(2, sigmark_nodes),
    f(function()
      return get_cstring(opts.ctype)[2]
    end),
    i(0),
  })
  return comment_node
end

local todo_snippet = function(context, aliases, opts)
  opts = opts or {}
  aliases = type(aliases) == 'string' and { aliases } or aliases
  context = context or {}
  if not context.trig then
    return error("context doesn't include a `trig` key which is mandatory", 2)
  end
  opts.ctype = opts.ctype or 1
  local alias_string = table.concat(aliases, '|')
  context.name = context.name or (alias_string .. ' comment')
  context.dscr = context.dscr or (alias_string .. ' comment with a signature-mark')
  context.docstring = context.docstring or (' {1:' .. alias_string .. '}: {3} <{2:mark}>{0} ')
  local comment_node = todo_snippet_nodes(aliases, opts)
  return s(context, comment_node, opts)
end

local todo_snippet_specs = {
  { { trig = 'todo' }, 'TODO' },
  { { trig = 'cite' }, { 'CITE', 'PMID' } },
  { { trig = 'fix' }, { 'FIX', 'BUG', 'ISSUE' } },
  { { trig = 'warn' }, { 'WARN', 'WARNING' } },
  { { trig = 'note' }, { 'NOTE', 'INFO' } },
  { { trig = 'todob' }, 'TODO', { ctype = 2 } },
  { { trig = 'citeb' }, { 'CITE', 'PMID' }, { ctype = 2 } },
  { { trig = 'fixb' }, { 'FIX', 'BUG', 'ISSUE' }, { ctype = 2 } },
  { { trig = 'warnb' }, { 'WARN', 'WARNING' }, { ctype = 2 } },
  { { trig = 'noteb' }, { 'NOTE', 'INFO' }, { ctype = 2 } },
}

local todo_comment_snippets = {}
for _, v in ipairs(todo_snippet_specs) do
  table.insert(todo_comment_snippets, todo_snippet(v[1], v[2], v[3]))
end

ls.add_snippets('all', todo_comment_snippets, { type = 'snippets', key = 'todo_comments' })
