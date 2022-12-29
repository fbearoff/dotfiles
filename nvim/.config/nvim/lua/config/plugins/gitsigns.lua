local M = {
  "lewis6991/gitsigns.nvim",
  event = "BufReadPre",
}

function M.config()
  if not package.loaded.trouble then
    package.preload.trouble = function()
      return true
    end
  end
  local wk = require("which-key")
  require("gitsigns").setup({
    signs = {
      add = { hl = "GitSignsAdd",
        text = "▎",
        numhl = "GitSignsAddNr",
        linehl = "GitSignsAddLn" },
      change = {
        hl = "GitSignsChange",
        text = "▎",
        numhl = "GitSignsChangeNr",
        linehl = "GitSignsChangeLn",
      },
      delete = {
        hl = "GitSignsDelete",
        text = "▸",
        numhl = "GitSignsDeleteNr",
        linehl = "GitSignsDeleteLn",
      },
      topdelete = {
        hl = "GitSignsDelete",
        text = "▾",
        numhl = "GitSignsDeleteNr",
        linehl = "GitSignsDeleteLn",
      },
      changedelete = {
        hl = "GitSignsChange",
        text = "▎",
        numhl = "GitSignsChangeNr",
        linehl = "GitSignsChangeLn",
      },
      untracked = { hl = "GitSignsAdd",
        text = "▎",
        numhl = "GitSignsAddNr",
        linehl = "GitSignsAddLn" },
    },
    signcolumn = true,
    numhl = false,
    linehl = false,
    word_diff = false,
    watch_gitdir = {
      interval = 1000,
      follow_files = true,
    },
    attach_to_untracked = true,
    current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
    current_line_blame_opts = {
      virt_text = true,
      virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
      delay = 1000,
      ignore_whitespace = false,
    },
    current_line_blame_formatter_opts = {
      relative_time = false,
    },
    sign_priority = 25,
    update_debounce = 100,
    status_formatter = nil, -- Use default
    max_file_length = 40000,
    preview_config = {
      -- Options passed to nvim_open_win
      border = "single",
      style = "minimal",
      relative = "cursor",
      row = 0,
      col = 1,
    },
    yadm = {
      enable = false,
    },
    on_attach = function()
      local keymap = {
        ["<leader>"] = {
          g = { name = "Git",
            b = { "<cmd>Telescope git_branches<cr>", "Checkout Branch" },
            c = { "<cmd>Telescope git_commits<cr>", "Checkout Commit" },
            d = { "<cmd>Telescope git_status<cr>", "Diff Overview", },
            g = { "<cmd>lua _GITUI_TOGGLE()<cr>", "GitUI" },
            j = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
            k = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk" },
            L = { "<cmd>lua require 'gitsigns'.toggle_current_line_blame()<cr>", "Toggle Line Blame" },
            l = { "<cmd>lua require 'gitsigns'.toggle_linehl()<cr>", "Toggle Line Highlight" },
            o = { "<cmd>Telescope git_status<cr>", "Open Changed File" },
            p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
            R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
            r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
            s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
            u = { "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>", "Undo Stage Hunk" },
            v = { "<cmd>Gitsigns diffthis<cr>", "Diff This" },
            w = { "<cmd>lua require 'gitsigns'.toggle_word_diff()<cr>", "Toggle Word Diff" },
          },
        },
      }
      wk.register(keymap)
    end
  })
  package.loaded.trouble = nil
  package.preload.trouble = nil
end

return M
