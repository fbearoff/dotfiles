local M = {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/cmp-nvim-lua",
    "hrsh7th/cmp-nvim-lsp-signature-help",
    "dmitmel/cmp-cmdline-history",
    "hrsh7th/cmp-path",
    "saadparwaiz1/cmp_luasnip",
    "jalvesaq/cmp-nvim-r"
  },
}

function M.config()

  local check_backspace = function()
    local col = vim.fn.col "." - 1
    return col == 0 or vim.fn.getline("."):sub(col, col):match "%s"
  end

  local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
  end

  local kind_icons = {
    Text = "",
    Method = "m",
    Function = "",
    Constructor = "",
    Field = "",
    Variable = "",
    Class = "",
    Interface = "",
    Module = "",
    Property = "",
    Unit = "",
    Value = "",
    Enum = "",
    Keyword = "",
    Snippet = "",
    Color = "",
    File = "",
    Reference = "",
    Folder = "",
    EnumMember = "",
    Constant = "",
    Struct = "",
    Event = "",
    Operator = "",
    TypeParameter = "",
  }

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
    mapping = {
      ["<C-k>"] = cmp.mapping.select_prev_item(),
      ["<C-j>"] = cmp.mapping.select_next_item(),
      ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
      ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
      ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
      ["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
      ["<C-e>"] = cmp.mapping {
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      },
      -- Accept currently selected item. If none selected, `select` first item.
      -- Set `select` to `false` to only confirm explicitly selected items.
      ["<CR>"] = cmp.mapping.confirm { select = false },
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
      end,
        { "i", "s", }),
      ["<S-Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end,
        { "i", "s", }),
    },
    sources = cmp.config.sources({
      { name = "cmp_nvim_r" },
      { name = "nvim_lsp", max_item_count = 10 },
      { name = "nvim_lua" },
      { name = "nvim_lsp_signature_help" },
      { name = "luasnip" },
      { name = "buffer", max_item_count = 10 },
      { name = "path" },
    }),
    formatting = {
      fields = { "kind", "abbr", "menu" },
      format = function(entry, vim_item)
        vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
        vim_item.menu = ({
          nvim_lsp = "[LSP]",
          luasnip = "[Snippet]",
          buffer = "[Buffer]",
          path = "[Path]",
          cmp_nvim_r = "[R]",
          nvim_lsp_signature_help = "[Signature]",
          nvim_lua = "[Lua]",
        })[entry.source.name]
        return vim_item
      end,
    },
    confirm_opts = {
      behavior = cmp.ConfirmBehavior.Replace,
      select = false,
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
  cmp.setup.cmdline('/', {
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
      { name = "cmdline_history" },
    }),
  })
end

return M
