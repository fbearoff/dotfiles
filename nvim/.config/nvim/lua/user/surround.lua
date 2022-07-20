local status_ok, surround = pcall(require, "nvim-surround")
if not status_ok then
  return
end
surround.setup({
  keymaps = { -- vim-surround style keymaps
    insert = "<C-g>s",
    insert_line = "<C-g>S",
    normal = "ys",
    normal_cur = "yss",
    normal_line = "yS",
    normal_cur_line = "ySS",
    visual = "S",
    visual_line = "gS",
    delete = "ds",
    change = "cs",
  },
  delimiters = {
    pairs = {
      ["("] = { "( ", " )" },
      [")"] = { "(", ")" },
      ["{"] = { "{ ", " }" },
      ["}"] = { "{", "}" },
      ["<"] = { "< ", " >" },
      [">"] = { "<", ">" },
      ["["] = { "[ ", " ]" },
      ["]"] = { "[", "]" },
      -- Define pairs based on function evaluations!
      ["i"] = function()
        return {
          require("nvim-surround.utils").get_input(
            "Enter the left delimiter: "
          ),
          require("nvim-surround.utils").get_input(
            "Enter the right delimiter: "
          )
        }
      end,
      ["f"] = function()
        return {
          require("nvim-surround.utils").get_input(
            "Enter the function name: "
          ) .. "(",
          ")"
        }
      end,
      -- paste clipboard content as markdown link
      ["l"] = function()
        return {
          "[",
          "](" .. vim.fn.getreg("*") .. ")",
        }
      end,
    },
    separators = {
      ["'"] = { "'", "'" },
      ['"'] = { '"', '"' },
      ["`"] = { "`", "`" },
    },
    HTML = {
      ["t"] = true, -- Use "t" for HTML-style mappings
      ["T"] = "whole", -- Change the whole tag contents
    },
    aliases = {
      ["a"] = ">", -- Single character aliases apply everywhere
      ["b"] = ")",
      ["B"] = "}",
      ["r"] = "]",
      -- Table aliases only apply for changes/deletions
      ["q"] = { '"', "'", "`" }, -- Any quote character
      ["s"] = { ")", "]", "}", ">", "'", '"', "`" }, -- Any surrounding delimiter
    },
  },
  highlight_motion = { -- Highlight text-objects before surrounding them
    duration = 0,
  }
})
