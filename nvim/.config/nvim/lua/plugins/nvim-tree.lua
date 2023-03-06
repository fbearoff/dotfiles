return {
  "nvim-tree/nvim-tree.lua",
  cmd = "NvimTreeToggle",
  keys = {
    { "<leader>e", "<cmd>NvimTreeToggle<CR>", desc = "Explorer" },
  },
  config = function()
    local nvim_tree = require("nvim-tree")

    local function on_attach(bufnr)
      local api = require("nvim-tree.api")

      local function opts(desc)
        return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
      end
      api.config.mappings.default_on_attach(bufnr)

      vim.keymap.set("n", "l", api.node.open.edit, opts("Open"))
      vim.keymap.set("n", "h", api.node.navigate.parent_close, opts("Close Directory"))
      vim.keymap.set("n", "H", api.tree.collapse_all, opts("Collapse"))
    end

    nvim_tree.setup({
      on_attach = on_attach,
      disable_netrw = true,
      hijack_netrw = true,
      open_on_tab = false,
      hijack_cursor = false,
      update_cwd = true,
      reload_on_bufenter = true,
      renderer = {
        highlight_git = true,
        indent_markers = {
          enable = true,
        },
      },
      diagnostics = {
        enable = true,
        show_on_dirs = true,
        icons = {
          hint = " ",
          info = " ",
          warning = " ",
          error = " ",
        },
      },
      sync_root_with_cwd = true,
      respect_buf_cwd = true,
      update_focused_file = {
        enable = true,
        update_cwd = true,
        ignore_list = {},
      },
      filters = {
        custom = { "^.git$" },
      },
      view = {
        adaptive_size = true,
      },
      trash = {
        cmd = "trash",
        require_confirm = true,
      },
    })

    local nvim_tree_events = require("nvim-tree.events")
    local bufferline_api = require("bufferline.api")

    local function get_tree_size()
      return require("nvim-tree.view").View.width
    end

    nvim_tree_events.subscribe("TreeOpen", function()
      bufferline_api.set_offset(get_tree_size())
    end)

    nvim_tree_events.subscribe("Resize", function()
      bufferline_api.set_offset(get_tree_size())
    end)

    nvim_tree_events.subscribe("TreeClose", function()
      bufferline_api.set_offset(0)
    end)
  end,
}
