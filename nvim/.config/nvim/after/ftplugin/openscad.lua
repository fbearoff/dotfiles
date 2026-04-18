vim.api.nvim_create_autocmd("User", {
  pattern = "TSUpdate",
  callback = function()
    require("nvim-treesitter.parsers").openscad = {
      install_info = {
        url = "https://github.com/openscad/tree-sitter-openscad",
        queries = "queries",
      },
    }
  end,
})
