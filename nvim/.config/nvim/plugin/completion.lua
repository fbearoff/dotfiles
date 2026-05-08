vim.pack.add({
  { src = "https://github.com/saghen/blink.cmp", version = vim.version.range("1.*") },
  "https://github.com/rafamadriz/friendly-snippets",
})

local cmp = require("blink.cmp")
cmp.build():wait(60000)
cmp.setup({
  fuzzy = { implementation = "lua" },
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
    trigger = {
      show_on_trigger_character = true,
    },
    ghost_text = {
      enabled = true,
    },
    menu = {
      draw = {
        columns = {
          { "item_idx" },
          { "kind_icon" },
          { "label" },
          { "source_name" },
        },
        components = {
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
      ["<CR>"] = { "accept_and_enter", "fallback" },
    },
    completion = { menu = { auto_show = true } },
  },
  sources = {
    default = { "lsp", "path", "snippets", "buffer" },
    providers = {
      cmdline = {
        min_keyword_length = function(ctx)
          -- when typing a command, only show when the keyword is 3 characters or longer
          if ctx.mode == "cmdline" and string.find(ctx.line, " ") == nil then
            return 3
          end
          return 0
        end,
      },
    },
  },
})
