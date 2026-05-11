vim.pack.add({ "https://github.com/nvim-lualine/lualine.nvim" })

local icons = require("icons")
local diagnostics = {
  "diagnostics",
  symbols = {
    error = icons.diagnostics.Error,
    warn = icons.diagnostics.Warn,
    info = icons.diagnostics.Info,
    hint = icons.diagnostics.Hint,
  },
}

local diff = {
  "diff",
  symbols = {
    added = icons.git.added,
    modified = icons.git.modified,
    removed = icons.git.removed,
  },
  cond = function()
    return vim.fn.winwidth(0) > 80
  end,
}

local location = {
  "location",
  padding = 0,
}

local filename = {
  "filename",
  path = 1,
}

local macro = {
  "macro",
  fmt = function()
    local reg = vim.fn.reg_recording()
    if reg ~= "" then
      return "REC @" .. reg
    end
    return nil
  end,
  color = { fg = "#C34043" },
  draw_empty = false,
}

local navic = {
  "navic",
  color_correction = "static",
  padding = { left = 1, right = 0 },
}

local lightbulb = {
  function()
    return require("nvim-lightbulb").get_status_text()
  end,
}

require("lualine").setup({
  options = {
    component_separators = { left = "|", right = "|" },
    section_separators = { left = "", right = "" },
    globalstatus = true,
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = { "branch", diff },
    lualine_c = {
      diagnostics,
      lightbulb,
      filename,
      navic,
    },
    lualine_x = {
      macro,
      "lsp_status",
      "fileformat",
      "encoding",
      "filetype",
    },
    lualine_y = { location },
    lualine_z = { "searchcount" },
  },
  extensions = {
    "nvim-tree",
  },
})
