return {
  -- completion engine
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-path",
      "R-nvim/cmp-r",
      "saadparwaiz1/cmp_luasnip",
      "max397574/cmp-greek",
      "hrsh7th/cmp-emoji",
    },
    config = function()
      vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })

      -- Setup nvim-cmp.
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      cmp.setup({
        enabled = function()
          -- disable autocompletion in prompt (wasn't playing well with telescope)
          local buftype = vim.api.nvim_get_option_value("buftype", { buf = 0 })
          if buftype == "prompt" then
            return false
          end

          local context = require("cmp.config.context")
          -- disable autocompletion in comments
          return not context.in_treesitter_capture("comment") and not context.in_syntax_group("Comment")
        end,
        completion = {
          completeopt = "menu,menuone,noselect",
        },
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
          ["<S-CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
          }),
          ["<Tab>"] = cmp.mapping(function()
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            else
              require("neotab").tabout()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        sources = cmp.config.sources({
          { name = "cmp_r" },
          { name = "nvim_lsp", max_item_count = 10 },
          { name = "nvim_lua" },
          {
            name = "buffer",
            -- get words from visible buffers
            keyword_length = 5,
            max_item_count = 3,
            get_bufnrs = function()
              local bufs = {}
              for _, win in ipairs(vim.api.nvim_list_wins()) do
                bufs[vim.api.nvim_win_get_buf(win)] = true
              end
              return vim.tbl_keys(bufs)
            end,
          },
          { name = "luasnip", keyword_length = 3, max_item_count = 3 },
          { name = "path" },
          { name = "greek" },
          { name = "emoji" },
          { name = "render-markdown" },
        }),
        formatting = {
          fields = { "kind", "abbr", "menu" },
          format = function(_, item)
            local icons = require("config.icons").kinds
            if icons[item.kind] then
              item.kind = string.format("%s", icons[item.kind])
              item.menu = ({
                cmp_nvim_r = "[R]",
                nvim_lsp = "[LSP]",
                luasnip = "[Snip]",
                buffer = "[Buffer]",
                path = "[Path]",
                nvim_lua = "[Lua]",
                greek = "[Greek]",
                emoji = "[Emoji]",
              })[_.source.name]
            end
            return item
          end,
        },
        window = {
          documentation = cmp.config.window.bordered(),
          completion = cmp.config.window.bordered(),
        },
        experimental = {
          ghost_text = {
            hl_group = "CmpGhostText",
          },
        },
      })
      cmp.setup.cmdline({ "/", "?" }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "buffer" },
        },
      })
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "path" },
          { name = "cmdline" },
        }),
      })
    end,
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
        "<tab>",
        function()
          return require("luasnip").jumpable(1) and "<Plug>luasnip-jump-next" or "<tab>"
        end,
        expr = true,
        silent = true,
        mode = "i",
      },
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
              ret[#ret + 1] = { item.ft }
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
