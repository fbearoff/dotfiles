local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
  return
end

local status_navic_ok, navic = pcall(require, "nvim-navic")
if not status_navic_ok then
  return
end

local hide_in_width = function()
  return vim.fn.winwidth(0) > 80
end

local diagnostics = {
  "diagnostics",
  sources = { "nvim_diagnostic" },
  -- sections = { "error", "warn" },
  symbols = { error = " ", warn = " " },
  colored = true,
  update_in_insert = false,
  always_visible = true,
  on_click = function()
    vim.diagnostic.setqflist()
  end
}

local diff = {
  "diff",
  colored = true,
  symbols = { added = " ", modified = " ", removed = " " }, -- changes diff symbols
  cond = hide_in_width,
  on_click = function()
    vim.cmd.DiffviewOpen()
  end
}

local filetype = {
  "filetype",
  icons_enabled = true,
}

local location = {
  "location",
  padding = 0,

}

local filename = {
  "filename",
  symbols = {
    modified = '[+]',
    readonly = '[-]',
    unnamed = '[No Name]',
  },
}

local long_filename = {
  "filename",
  file_status = true,
  path = 3,
  symbols = {
    modified = '[+]',
    readonly = '[-]',
    unnamed = '[No Name]',
  },
}
-- Lsp server name .
local lsp_server = {
  function()
    local msg = 'No Active Lsp'
    local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
    local clients = vim.lsp.get_active_clients()
    if next(clients) == nil then
      return msg
    end
    for _, client in ipairs(clients) do
      local filetypes = client.config.filetypes
      if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
        return client.name
      end
    end
    return msg
  end,
  icon = ' LSP:',
  on_click = function()
    require 'lspconfig.ui.lspinfo' ()
  end
}

-- cool function for progress
local progress = function()
  local current_line = vim.fn.line(".")
  local total_lines = vim.fn.line("$")
  local chars = { "__", "▁▁", "▂▂", "▃▃", "▄▄", "▅▅", "▆▆", "▇▇", "██" }
  local line_ratio = current_line / total_lines
  local index = math.ceil(line_ratio * #chars)
  return chars[index]
end

local spaces = function()
  return "spaces: " .. vim.api.nvim_buf_get_option(0, "shiftwidth")
end

local macro = {
  require("noice").api.statusline.mode.get,
  cond = require("noice").api.statusline.mode.has,
  color = { fg = "#ff9e64" },
}

-- silence navic if documentSymbols is not supported
vim.g.navic_silence = true
navic.setup {
  highlight = true,
  separator = "  ",
  depth_limit = 0,
  depth_limit_indicator = "...",
}

lualine.setup({
  options = {
    icons_enabled = true,
    theme = "auto",
    component_separators = { left = "|", right = "|" },
    section_separators = { left = "", right = "" },
    disabled_filetypes = {
      statusline = { 'alpha',
        'dashboard',
        'NvimTree',
        'Outline' },
      winbar = { 'help',
        'startify',
        'dashboard',
        'packer',
        'neogitstatus',
        'NvimTree',
        'Trouble',
        'alpha',
        'lir',
        'Outline',
        'spectre_panel',
        'toggleterm',
        'qf', },
    },
    always_divide_middle = true,
    globalstatus = true,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    }
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = { "branch", diff, diagnostics },
    lualine_c = { long_filename },
    lualine_x = { macro, lsp_server, spaces, "fileformat", "encoding", filetype },
    lualine_y = { location },
    lualine_z = { progress },
  },
  -- unused with global statusline
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {},
  },
  winbar = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { filename },
    lualine_x = {},
    lualine_y = {},
    lualine_z = { { navic.get_location, cond = navic.is_available }, }
  },
  inactive_winbar = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { filename },
    lualine_x = {},
    lualine_y = {},
    lualine_z = { { navic.get_location, cond = navic.is_available }, }
  },
  tabline = {},
  extensions = {},
})
