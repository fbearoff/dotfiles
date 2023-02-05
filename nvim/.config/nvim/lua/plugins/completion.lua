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
      "jalvesaq/cmp-nvim-r",
      "saadparwaiz1/cmp_luasnip",
      "max397574/cmp-greek",
      "hrsh7th/cmp-emoji",
      { "aspeddro/cmp-pandoc.nvim",
        config = true },
    },
    config = function()

      local check_backspace = function()
        local col = vim.fn.col "." - 1
        return col == 0 or vim.fn.getline("."):sub(col, col):match "%s"
      end

      local has_words_before = function()
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end

      -- Setup nvim-cmp.
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      cmp.setup({
        enabled = function()
          -- disable autocompletion in prompt (wasn't playing well with telescope)
          local buftype = vim.api.nvim_buf_get_option(0, "buftype")
          if buftype == "prompt" then return false end

          local context = require 'cmp.config.context'
          -- disable autocompletion in comments
          return not context.in_treesitter_capture("comment") and not context.in_syntax_group("Comment")
        end,

        completion = {
          completeopt = "menu,menuone,noselect",
        },
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            elseif has_words_before() then
              cmp.complete()
            elseif check_backspace() then
              fallback()
            end
          end, { "i", "s", }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s", }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp", max_item_count = 10 },
          { name = "nvim_lua" },
          {
            name = "buffer",
            -- get words from visible buffers
            option = {
              keyword_length = 5,
              max_item_count = 3,
              get_bufnrs = function()
                local bufs = {}
                for _, win in ipairs(vim.api.nvim_list_wins()) do
                  bufs[vim.api.nvim_win_get_buf(win)] = true
                end
                return vim.tbl_keys(bufs)
              end
            }
          },
          { name = "cmp_nvim_r" },
          { name = "luasnip", keyword_length = 3, max_item_count = 3 },
          { name = "path" },
          { name = "greek" },
          { name = "emoji" },
          { name = "cmp_pandoc" },
        }),
        formatting = {
          fields = { "kind", "abbr", "menu" },
          format = function(_, item)
            local icons = require("config.icons").kinds
            if icons[item.kind] then
              -- item.kind = icons[item.kind] .. item.kind
              item.kind = string.format("%s", icons[item.kind])
              item.menu = ({
                nvim_lsp = "[LSP]",
                luasnip = "[Snip]",
                buffer = "[Buffer]",
                path = "[Path]",
                cmp_nvim_r = "[R]",
                nvim_lua = "[Lua]",
                greek = "[Greek]",
                emoji = "[Emoji]",
                cmp_pandoc = "[Ref]",
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
            hl_group = "LspCodeLens",
          },
        },
      })
      cmp.setup.cmdline({ '/', '?' }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'buffer' }
        }
      })
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "path" },
          { name = "cmdline" },
        }),
      })
    end
  },

  -- snippets
  {
    "L3MON4D3/LuaSnip",
    dependencies = {
      "rafamadriz/friendly-snippets",
      config = function()
        require("luasnip.loaders.from_vscode").lazy_load()
        require("luasnip.loaders.from_vscode").lazy_load({ paths = { "./snips" } })
      end,
    },
    opts = {
      history = true,
      delete_check_events = "TextChanged",
    },
    keys = {
      {
        "<tab>",
        function()
          return require("luasnip").jumpable(1) and "<Plug>luasnip-jump-next" or "<tab>"
        end,
        expr = true, silent = true, mode = "i",
      },
      { "<tab>", function() require("luasnip").jump(1) end, mode = "s" },
      { "<s-tab>", function() require("luasnip").jump(-1) end, mode = { "i", "s" } },
      { "<leader>cS", function() require("luasnip.loaders").edit_snippet_files() end, desc = "Edit Snippets" },
    },
  }
}
