local icons = require("icons")

-- diagnostics
vim.diagnostic.config({
  severity_sort = true,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = icons.diagnostics.Error,
      [vim.diagnostic.severity.WARN] = icons.diagnostics.Warn,
      [vim.diagnostic.severity.HINT] = icons.diagnostics.Hint,
      [vim.diagnostic.severity.INFO] = icons.diagnostics.Info,
    },
  },
  virtual_text = {
    source = "if_many",
    prefix = "",
    severity = {
      min = vim.diagnostic.severity.ERROR,
    },
  },
  underline = {
    severity = {
      min = vim.diagnostic.severity.HINT,
    },
  },
  jump = {
    -- use virtual lines for jumps
    -- help diagnostic-on-jump-example
    on_jump = function(diagnostic, bufnr)
      if not diagnostic then
        return
      end
      vim.diagnostic.show(
        diagnostic.namespace,
        bufnr,
        { diagnostic },
        { virtual_lines = { current_line = true }, virtual_text = false }
      )
    end,
  },
})
