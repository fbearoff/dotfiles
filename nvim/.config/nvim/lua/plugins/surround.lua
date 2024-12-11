return {
  "kylechui/nvim-surround",
  keys = {
    { mode = "i", "<C-g>s", "<Plug>(nvim-surround-insert)", desc = "Surround" },
    { mode = "i", "<C-g>S", "<Plug>(nvim-surround-insert-line)", desc = "Surround Line" },
    { "ys", "<Plug>(nvim-surround-normal)", desc = "Surround" },
    { "yss", "<Plug>(nvim-surround-normal-cur)", desc = "Surround Current Line" },
    { "yS", "<Plug>(nvim-surround-normal-line)", desc = "Surround Around Motion on New Lines" },
    { "ySS", "<Plug>(nvim-surround-normal-cur-line)", desc = "Surround Around Current Line" },
    { mode = "x", "S", "<Plug>(nvim-surround-visual)", desc = "Surround" },
    { mode = "x", "gS", "<Plug>(nvim-surround-visual-line)", desc = "Surround Line" },
    { "ds", "<Plug>(nvim-surround-delete)", desc = "Delete" },
    { "cs", "<Plug>(nvim-surround-change)", desc = "Change" },
    { "cS", "<Plug>(nvim-surround-change-line)", desc = "Change Line" },
  },
  opts = function()
    return {
      surrounds = {
        --markdown link from clipboard
        ["l"] = {
          add = function()
            local clipboard = vim.fn.getreg("+"):gsub("\n", "")
            return {
              { "[" },
              { "](" .. clipboard .. ")" },
            }
          end,
          find = "%b[]%b()",
          delete = "^(%[)().-(%]%b())()$",
          change = {
            target = "^()()%b[]%((.-)()%)$",
            replacement = function()
              local clipboard = vim.fn.getreg("+"):gsub("\n", "")
              return {
                { "" },
                { clipboard },
              }
            end,
          },
        },
        --- markdown italic
        ["*"] = {
          find = "(%*+).-(%*+)",
          delete = "^(%*+)().-(%*+)()$",
        },
        -- markdown bold
        ["M"] = {
          add = { "**", "**" },
          find = "%*%*.-%*%*",
          delete = "^(%*%*?)().-(%*%*?)()$",
          change = {
            target = "^(%*%*?)().-(%*%*?)()$",
          },
        },
        -- fenced R
        ["R"] = {
          add = { "```{r}", "```" },
        },
        -- fenced python
        ["P"] = {
          add = { "```{python}", "```" },
        },
      },
      aliases = {
        ["m"] = { "`", "*", "_" },
      },
    }
  end,
}
