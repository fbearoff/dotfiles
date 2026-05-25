vim.pack.add({
  "https://github.com/folke/snacks.nvim",
})

require("snacks").setup({
  indent = { enabled = true },
  picker = {
    win = {
      input = {
        keys = {
          ["<a-s>"] = { "flash_jump", mode = { "n", "i" } },
          ["s"] = { "flash_jump" },
        },
      },
    },
    actions = {
      flash_jump = function(picker)
        require("flash").jump({
          pattern = "^",
          label = { after = { 0, 0 } },
          search = {
            mode = "search",
            exclude = {
              function(win)
                return vim.bo[vim.api.nvim_win_get_buf(win)].filetype ~= "snacks_picker_list"
              end,
            },
          },
          action = function(match)
            local idx = picker.list:row2idx(match.pos[1])
            picker.list:_move(idx, true, true)
          end,
        })
      end,
    },
  },
  notifier = { timeout = 2000 },
  quickfile = { enabled = true },
  statuscolumn = {
    left = { "git" },
    right = { "sign", "mark", "fold" },
    folds = {
      open = true,
    },
  },
  words = { enabled = true },
  styles = {
    notification = {
      wo = {
        winblend = 10,
      },
    },
  },
})

-- Pickers
-- core
vim.keymap.set("n", "<leader>e", function()
  Snacks.explorer({ cwd = vim.lsp.buf.list_workspace_folders()[1] })
end, { desc = "File Explorer" })
vim.keymap.set("n", "<leader>/", function()
  Snacks.picker.smart()
end, { desc = "Smart Find Files" })
vim.keymap.set("n", "<leader>:", function()
  Snacks.picker.command_history()
end, { desc = "Command History" })
vim.keymap.set("n", "<leader>n", function()
  Snacks.picker.notifications()
end, { desc = "Notification History" })
-- Files
vim.keymap.set("n", "<leader>fc", function()
  Snacks.picker.files({ cwd = vim.fn.stdpath("config"), title = "Config Files" })
end, { desc = "Find Config File" })
vim.keymap.set("n", "<leader>ff", function()
  Snacks.picker.files({ hidden = true, cwd = vim.lsp.buf.list_workspace_folders()[1] or vim.fn.expand("%:h") })
end, { desc = "Find Files" })
vim.keymap.set("n", "<leader>fF", function()
  Snacks.picker.files({ cwd = vim.fn.expand("%:h") })
end, { desc = "Find Files (CWD)" })
vim.keymap.set("n", "<leader>fg", function()
  Snacks.picker.grep({
    hidden = true,
    layout = { preset = "ivy" },
    cwd = vim.lsp.buf.list_workspace_folders()[1] or vim.fn.expand("%:h"),
  })
end, { desc = "Grep" })
vim.keymap.set("n", "<leader>fr", function()
  Snacks.picker.recent()
end, { desc = "Recent" })
vim.keymap.set("n", "<leader>fu", function()
  Snacks.picker.undo()
end, { desc = "Undo History" })
-- Buffers
vim.keymap.set("n", "<leader>bb", function()
  Snacks.picker.buffers()
end, { desc = "Buffers" })
-- search
vim.keymap.set("n", "<leader>sk", function()
  Snacks.picker.keymaps()
end, { desc = "Keymaps" })
vim.keymap.set("n", "<leader>sc", function()
  Snacks.picker.colorschemes()
end, { desc = "Colorscheme" })
vim.keymap.set("n", "<leader>sC", function()
  Snacks.picker.commands()
end, { desc = "Commands" })
vim.keymap.set("n", "<leader>sh", function()
  Snacks.picker.help()
end, { desc = "Help Pages" })
vim.keymap.set("n", "<leader>sp", function()
  Snacks.picker.projects()
end, { desc = "Projects" })
vim.keymap.set("n", "<leader>se", function()
  Snacks.picker.icons()
end, { desc = "Emoji/Icons" })
vim.keymap.set("n", "<leader>sm", function()
  Snacks.picker.man()
end, { desc = "Man Pages" })
vim.keymap.set("n", "<leader><return>", function()
  Snacks.picker.resume()
end, { desc = "Resume Picker" })
vim.keymap.set({ "n", "x" }, "<leader>sw", function()
  Snacks.picker.grep_word()
end, { desc = "Visual selection or word" })
-- Other
vim.keymap.set("n", "<leader>gg", function()
  Snacks.lazygit({ cwd = vim.lsp.buf.list_workspace_folders()[1] })
end, { desc = "Lazygit" })
vim.keymap.set("n", "<leader>gB", function()
  Snacks.gitbrowse()
end, { desc = "Gitbrowse" })
vim.keymap.set("n", "<leader>.", function()
  Snacks.scratch()
end, { desc = "Toggle Scratch Buffer" })
vim.keymap.set("n", [[<c-\>]], function()
  Snacks.terminal.toggle(nil, { cwd = vim.lsp.buf.list_workspace_folders()[1] or vim.fn.expand("%:h") })
end, { desc = "Toggle Terminal" })
vim.keymap.set("t", [[<c-\>]], "<cmd>close<cr>", { desc = "Toggle Terminal" })
vim.keymap.set({ "n", "t" }, "]]", function()
  Snacks.words.jump(vim.v.count1)
end, { desc = "Next Reference" })
vim.keymap.set({ "n", "t" }, "[[", function()
  Snacks.words.jump(-vim.v.count1)
end, { desc = "Prev Reference" })

-- Create some toggle mappings
Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
Snacks.toggle.diagnostics():map("<leader>ud")
Snacks.toggle.line_number():map("<leader>ul")
Snacks.toggle
  .option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2, name = "Conceallevel" })
  :map("<leader>uc")
Snacks.toggle.inlay_hints():map("<leader>uh")
Snacks.toggle.indent():map("<leader>ug")
Snacks.toggle
  .new({
    id = "document_color",
    name = "Document Color",
    get = function()
      return vim.lsp.document_color.is_enabled({ bufnr = 0 })
    end,
    set = function(state)
      vim.lsp.document_color.enable(state, { bufnr = 0 })
    end,
  })
  :map("<leader>uW")
