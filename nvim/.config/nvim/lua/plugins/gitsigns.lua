local M = {
  "lewis6991/gitsigns.nvim",
  event = "BufReadPre",
}

function M.config()

  local wk = require("which-key")
  require("gitsigns").setup({
    signs = {
      add = { text = "▎" },
      change = { text = "▎" },
      delete = { text = "▸" },
      topdelete = { text = "▾" },
      changedelete = { text = "▎" },
      untracked = { text = "▎" },
    },
    on_attach = function()
      local keymap = {
        ["<leader>"] = {
          g = { name = "Git",
            b = { "<cmd>Telescope git_branches<cr>", "Checkout Branch" },
            c = { "<cmd>Telescope git_commits<cr>", "Checkout Commit" },
            d = { "<cmd>Gitsigns diffthis<cr>", "Diff This" },
            g = { "<cmd>lua require 'util'.open_term('lazygit', {direction = 'float'})<cr>", "Lazygit" },
            L = { "<cmd>lua require 'gitsigns'.toggle_current_line_blame()<cr>", "Toggle Line Blame" },
            l = { "<cmd>lua require 'gitsigns'.toggle_linehl()<cr>", "Toggle Line Highlight" },
            p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
            R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
            r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
            s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
            S = { "<cmd>Telescope git_status<cr>", "Git Status", },
            u = { "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>", "Undo Stage Hunk" },
            w = { "<cmd>lua require 'gitsigns'.toggle_word_diff()<cr>", "Toggle Word Diff" },
          },
        },
        ["[h"] = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk" },
        ["]h"] = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
      }
      wk.register(keymap)
    end
  })
end

return M
