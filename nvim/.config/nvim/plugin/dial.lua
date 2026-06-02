vim.pack.add({ "https://github.com/monaqa/dial.nvim" })

local augend = require("dial.augend")
require("dial.config").augends:register_group({
  default = {
    augend.integer.alias.decimal_int,
    augend.integer.alias.hex,
    augend.date.alias["%Y/%m/%d"],
    augend.semver.alias.semver,
    augend.constant.new({
      elements = { "true", "false" },
      word = true,
      cyclic = true,
      preserve_case = true,
    }),
    augend.constant.new({
      elements = { "&&", "||" },
      word = false,
      cyclic = true,
    }),
    augend.date.new({
      pattern = "%Y_%m_%d",
      default_kind = "day",
      only_valid = true,
      word = false,
    }),
    augend.decimal_fraction.new({
      signed = false,
      point_char = ".",
    }),
    -- markdown
    augend.misc.alias.markdown_header,
    augend.constant.new({
      elements = { "[ ]", "[-]", "[x]" },
      word = false,
      cyclic = true,
    }),
    -- R
    augend.constant.new({
      elements = { "%>%", "|>" },
      word = false,
      cyclic = true,
    }),
    augend.constant.new({
      elements = { "&", "|" },
      word = false,
      cyclic = true,
    }),
    augend.constant.new({
      elements = { "==", "!=" },
      word = false,
      cyclic = true,
    }),
  },
})

vim.keymap.set("n", "<C-a>", function()
  return require("dial.map").inc_normal()
end, { expr = true, desc = "Dial Increment" })
vim.keymap.set("n", "<C-x>", function()
  return require("dial.map").dec_normal()
end, { expr = true, desc = "Dial Decrement" })
vim.keymap.set("n", "g<C-a>", function()
  return require("dial.map").inc_gnormal()
end, { expr = true, desc = "Dial Additive Increment" })
vim.keymap.set("n", "g<C-x>", function()
  return require("dial.map").dec_gnormal()
end, { expr = true, desc = "Dial Additive Decrement" })
