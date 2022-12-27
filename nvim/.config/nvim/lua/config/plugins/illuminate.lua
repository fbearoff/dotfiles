return {
  "RRethy/vim-illuminate",
  event = "BufReadPost",

  config = function()
    require("illuminate").configure({
      delay = 200,
      filetypes_denylist = {
        "dirvish",
        "fugitive",
        "alpha",
        "NvimTree",
        "packer",
        "neogitstatus",
        "Trouble",
        "lir",
        "Outline",
        "spectre_panel",
        "toggleterm",
        "DressingSelect",
        "TelescopePrompt",
      },
    })
  end,
  init = function()
    vim.keymap.set("n", "]]", function()
      require("illuminate").goto_next_reference(false)
    end, { desc = "Next Reference" })
    vim.keymap.set("n", "[[", function()
      require("illuminate").goto_prev_reference(false)
    end, { desc = "Prev Reference" })
  end,
}
