return {
  "akinsho/toggleterm.nvim",
  keys = {
    { [[<c-\>]], desc = "ToggleTerm" },
    { "<leader>t-", "<cmd>ToggleTerm size=10 direction=horizontal<CR>", desc = "Horizontal" },
    { "<leader>t\\", "<cmd>ToggleTerm size=80 direction=vertical<CR>", desc = "Vertical" },
  },
  cmd = "ToggleTerm",

  config = function()
    require("toggleterm").setup({
      size = 20,
      open_mapping = [[<c-\>]],
      hide_numbers = true,
      shade_filetypes = {},
      shade_terminals = true,
      shading_factor = 2,
      start_in_insert = true,
      insert_mappings = true,
      persist_size = true,
      direction = "float",
      close_on_exit = true,
      shell = vim.o.shell,
      float_opts = {
        border = "curved",
        winblend = 5,
        highlights = {
          border = "Normal",
          background = "Normal",
        },
      },
      winbar = {
        enabled = false,
      },
    })

    function _G.set_terminal_keymaps()
      local opts = { noremap = true }
      vim.api.nvim_buf_set_keymap(0, 't', 'jk', [[<C-\><C-n>]], opts)
      vim.api.nvim_buf_set_keymap(0, 't', '<A-h>', [[<C-\><C-n><C-W>h]], opts)
      vim.api.nvim_buf_set_keymap(0, 't', '<A-j>', [[<C-\><C-n><C-W>j]], opts)
      vim.api.nvim_buf_set_keymap(0, 't', '<A-k>', [[<C-\><C-n><C-W>k]], opts)
      vim.api.nvim_buf_set_keymap(0, 't', '<A-l>', [[<C-\><C-n><C-W>l]], opts)
    end

    vim.api.nvim_create_autocmd({ "TermOpen" }, {
      pattern = 'term://*',
      callback = set_terminal_keymaps
    })
  end
}
