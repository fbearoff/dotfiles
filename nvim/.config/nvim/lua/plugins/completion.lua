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
      { "aspeddro/cmp-pandoc.nvim", opts = {} },
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
          { name = "cmp_pandoc" },
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
    },
  },
}
