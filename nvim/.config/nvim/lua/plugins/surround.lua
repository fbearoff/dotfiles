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
    local config = require("nvim-surround.config")

    -- Factory that returns function that surrounds key with a given character
    local add_key_surround = function(surround_key)
      return function()
        local container = config.get_input("Enter object name: ")
        if container then
          return { { container .. "[" .. surround_key }, { surround_key .. "]" } }
        end
      end
    end

    -- Matches reference to table key, e.g. foo["bar"] -> 'foo["]' , '"]'
    local quoted_pattern = [=[([%w_]+%[["'])()[^"']*(["']%])()]=]
    --  Indirect referernces: foo[bar] -> 'foo[", "]'
    local unquoted_pattern = [=[([%w_]+%[)()[^]]+(%])()]=]
    local quoted_surround = add_key_surround([["]])
    local unquoted_surround = add_key_surround("")

    return {
      surrounds = {
        ["k"] = {
          add = quoted_surround,
          find = quoted_pattern,
          delete = quoted_pattern,
          change = {
            target = quoted_pattern,
          },
        },
        ["K"] = {
          add = unquoted_surround,
          find = unquoted_pattern,
          delete = unquoted_pattern,
          change = {
            target = unquoted_pattern,
          },
        },
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
