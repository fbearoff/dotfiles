local M = {
  "rcarriga/nvim-notify",
  -- event = "VeryLazy",

  lock = false,
}

function M.config()
  require("notify").setup({
    timeout = 0,
    level = vim.log.levels.INFO,
    fps = 20,
    stages = "fade_in_slide_out",
    render = "minimal",
    max_height = function()
      return math.floor(vim.o.lines * 0.75)
    end,
    max_width = function()
      return math.floor(vim.o.columns * 0.75)
    end,
  })
end

return M
