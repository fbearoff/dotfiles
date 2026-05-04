local M = {}

M._installed = nil

function M.get_installed(update)
  if update then
    M._installed = {}
    for _, lang in ipairs(require("nvim-treesitter").get_installed("parsers")) do
      M._installed[lang] = lang
    end
  end
  return M._installed or {}
end

function M.have(ft)
  local lang = vim.treesitter.language.get_lang(ft)
  return lang and M.get_installed()[lang]
end

function M.indentexpr()
  local buf = vim.api.nvim_get_current_buf()
  return M.have(vim.bo[buf].filetype) and require("nvim-treesitter").indentexpr() or -1
end

return M
