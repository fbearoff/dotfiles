return {
  cmd = { "jarl", "server" },
  filetypes = { "r", "rmd" },
  -- root_markers = { '.git' },
  root_dir = function(bufnr, on_dir)
    on_dir(vim.fs.root(bufnr, ".git") or vim.uv.os_homedir())
  end,
}
