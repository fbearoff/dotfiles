return {
  -- completion engine
  {
    "saghen/blink.cmp",
    dependencies = {
      "saghen/blink.compat",
      "R-nvim/cmp-r",
    },
    version = "1.*",
    opts = {
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
      snippets = { preset = "luasnip" },
      sources = {
        default = { "cmp_nvim_r", "lsp", "path", "snippets", "buffer" },
        providers = {
          cmp_nvim_r = {
            name = "cmp_r",
            module = "blink.compat.source",
          },
        },
      },
    },
  },

  -- snippets
  {
    "L3MON4D3/LuaSnip",
    build = "make install_jsregexp",
    dependencies = {
      "rafamadriz/friendly-snippets",
      config = function()
        require("luasnip.loaders.from_vscode").lazy_load()
      end,
    },
    opts = function()
      require("luasnip.loaders.from_vscode").lazy_load({ paths = { vim.fn.stdpath("config") .. "/snips/vscode" } })
      require("luasnip.loaders.from_lua").lazy_load({ paths = { vim.fn.stdpath("config") .. "/lua/snippets" } })
      return {
        history = true,
        update_events = "InsertLeave",
        enable_autosnippets = true,
        region_check_events = "CursorHold,InsertLeave",
        delete_check_events = "TextChanged,InsertEnter",
        store_selection_keys = "<Tab>",
      }
    end,
    keys = {
      {
        "<C-d>",
        function()
          require("luasnip.extras.select_choice")()
        end,
        mode = { "i", "s" },
      },
      {
        "<C-e>",
        function()
          require("luasnip").change_choice(1)
        end,
        mode = { "i", "s" },
      },
      {
        "<leader>cS",
        function()
          require("luasnip.loaders").edit_snippet_files()
        end,
        desc = "Edit Snippets",
      },
      {
        "<leader>sl",
        function()
          local Snacks = require("snacks")

          Snacks.picker({
            title = "Luasnips",
            finder = function()
              local items = {}

              local snippets_by_language = require("luasnip").available(function(s)
                return s
              end)

              for language, snippets_list in pairs(snippets_by_language) do
                for _, snippet in ipairs(snippets_list) do
                  local context = { ft = language, snippet = snippet, text = snippet.name }
                  table.insert(items, context)
                end
              end

              table.sort(items, function(a, b)
                if a.ft ~= b.ft then
                  return a.ft > b.ft
                elseif a.snippet.name ~= b.snippet.name then
                  return a.snippet.name > b.snippet.name
                else
                  return a.snippet.trigger > b.snippet.trigger
                end
              end)
              return items
            end,
            format = function(item)
              local ret = {}
              local icon, hl = Snacks.util.icon(item.ft, "filetype")
              local a = Snacks.picker.util.align

              ret[#ret + 1] = { a(icon, 2), hl, virtual = true }
              ret[#ret + 1] = { "  " }
              ret[#ret + 1] = { a(item.ft, 3) }
              ret[#ret + 1] = { "  " }
              ret[#ret + 1] = { a(item.snippet.name, 21) }
              ret[#ret + 1] = { "  " }
              ret[#ret + 1] = { a(item.snippet.trigger, 8, { align = "left" }), "SnacksPickerDelim" }
              ret[#ret + 1] = { "  " }
              ret[#ret + 1] = { table.concat(item.snippet.description, " "):sub(1, 40) }
              return ret
            end,
            preview = function(ctx)
              local lines
              if type(ctx.item.snippet.docstring) == "string" then
                lines = ctx.item.snippet.docstring and vim.split(ctx.item.snippet.docstring, "\n") or {}
              else
                lines = tostring(ctx.item.snippet.docstring[1])
                    and vim.split(tostring(ctx.item.snippet.docstring[1]), "\n")
                  or {}
              end
              ctx.preview:reset()
              ctx.preview:set_lines(lines)
              ctx.preview:set_title(ctx.item.snippet.name)
              ctx.preview:highlight({ ft = ctx.item.ft })
            end,
            actions = {
              confirm = function(picker)
                picker:close()
                local selected = picker:selected({ fallback = true })
                if vim.tbl_count(selected) == 1 then
                  vim.cmd("startinsert!")
                  require("luasnip").snip_expand(selected[1].snippet)
                  return
                end
              end,
            },
          })
        end,
        desc = "Luasnips",
      },
    },
  },
}
