local M = {
  "monaqa/dial.nvim",
  keys = {
    {
      "<C-a>",
      function()
        return require("dial.map").inc_normal()
      end,
      expr = true,
    },
    {
      "<C-x>",
      function()
        return require("dial.map").dec_normal()
      end,
      expr = true,
    },
  },
}

function M.config()
  local augend = require("dial.augend")
  require("dial.config").augends:register_group({
    default = {
      augend.integer.alias.decimal,
      augend.integer.alias.hex,
      augend.date.alias["%Y/%m/%d"],
      augend.semver.alias.semver,
      augend.constant.new {
        elements = { "true", "false" },
        word = true,
        cyclic = true,
        preserve_case = true
      },
      augend.constant.new {
        elements = { "&&", "||" },
        word = false,
        cyclic = true,
      },
    },
  })
end

return M
