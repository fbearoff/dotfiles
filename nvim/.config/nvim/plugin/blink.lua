vim.pack.add({
  "https://github.com/saghen/blink.lib",
  { src = "https://github.com/saghen/blink.cmp", version = vim.version.range("1.*") },
  "https://github.com/rafamadriz/friendly-snippets",
  { src = "https://github.com/saghen/blink.pairs", version = vim.version.range("*") },
})

-- use mini.icons for kinds
local get_mini_icon = function(ctx)
  if vim.tbl_contains({ "Path" }, ctx.source_name) then
    local is_unknown_type =
      vim.tbl_contains({ "link", "socket", "fifo", "char", "block", "unknown" }, ctx.item.data.type)
    local mini_icon, mini_hl, _ =
      require("mini.icons").get(is_unknown_type and "os" or ctx.item.data.type, is_unknown_type and "" or ctx.label)
    if mini_icon then
      return mini_icon, mini_hl
    end
  end
  local mini_icon, mini_hl, _ = require("mini.icons").get("lsp", ctx.kind)
  return mini_icon, mini_hl
end

-- needed for blink 2.0
-- require("blink.cmp").build():wait(60000)
require("blink.cmp").setup({
  signature = { enabled = true },
  keymap = {
    preset = "enter",
    ["<TAB>"] = { "select_next", "snippet_forward", "fallback" },
    ["<S-TAB>"] = { "select_prev", "snippet_backward", "fallback" },
        -- stylua: ignore start
        ['<A-1>'] = { function(cmp) cmp.accept({ index = 1 }) end },
        ['<A-2>'] = { function(cmp) cmp.accept({ index = 2 }) end },
        ['<A-3>'] = { function(cmp) cmp.accept({ index = 3 }) end },
        ['<A-4>'] = { function(cmp) cmp.accept({ index = 4 }) end },
        ['<A-5>'] = { function(cmp) cmp.accept({ index = 5 }) end },
        ['<A-6>'] = { function(cmp) cmp.accept({ index = 6 }) end },
        ['<A-7>'] = { function(cmp) cmp.accept({ index = 7 }) end },
        ['<A-8>'] = { function(cmp) cmp.accept({ index = 8 }) end },
        ['<A-9>'] = { function(cmp) cmp.accept({ index = 9 }) end },
        ['<A-0>'] = { function(cmp) cmp.accept({ index = 10 }) end },
    -- stylua: ignore end
  },
  completion = {
    documentation = { auto_show = true },
    ghost_text = {
      enabled = true,
      show_with_menu = false,
    },
    menu = {
      auto_show = false,
      auto_show_delay_ms = 500,
      draw = {
        columns = {
          { "item_idx" },
          { "kind_icon" },
          { "label" },
          { "source_name" },
        },
        components = {
          kind_icon = {
            text = function(ctx)
              local mini_icon, _mini_hl = get_mini_icon(ctx)
              return mini_icon
            end,
            highlight = function(ctx)
              local _mini_icon, mini_hl = get_mini_icon(ctx)
              return mini_hl
            end,
          },
          kind = {
            --  use highlights from mini.icons
            highlight = function(ctx)
              local _mini_icon, mini_hl = get_mini_icon(ctx)
              return mini_hl
            end,
          },
          item_idx = {
            text = function(ctx)
              return ctx.idx == 10 and "0" or ctx.idx >= 10 and " " or tostring(ctx.idx)
            end,
          },
        },
      },
    },
  },
  cmdline = {
    keymap = {
      preset = "inherit",
      ["<Tab>"] = { "show_and_insert_or_accept_single", "select_next" },
      ["<S-Tab>"] = { "show_and_insert_or_accept_single", "select_prev" },
      ["<CR>"] = { "accept", "fallback" },
    },
    completion = {
      menu = {
        auto_show = function()
          return vim.fn.getcmdtype() == ":"
        end,
      },
    },
  },
})

-- autopairs
require("blink.pairs").setup({
  mappings = {
    pairs = {
      ["<"] = { ">", languages = { "lua" } },
    },
  },
  highlights = {
    matchparen = {
      include_surrounding = true,
    },
  },
})
