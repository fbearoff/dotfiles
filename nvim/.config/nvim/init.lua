require("config.options")
require("config.lazy")

vim.api.nvim_create_autocmd("User", {
  pattern = "VeryLazy",
  callback = function()
    -- util.version()
    require("config.commands")
    require("config.mappings")
  end,
})
