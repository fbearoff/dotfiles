local M = {
  "rcarriga/nvim-notify",
  keys = {
    {
      "<leader>nc",
      function()
        require("notify").dismiss({ silent = true, pending = true })
      end,
      desc = "Clear all Notifications",
    },
  },
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
