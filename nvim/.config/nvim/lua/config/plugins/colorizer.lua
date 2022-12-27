return {
  "NvChad/nvim-colorizer.lua",
  event = "BufReadPre",
  config = function()
    require("colorizer").setup({
      user_default_options = {
        RGB = true, -- #RGB hex codes
        RRGGBB = true, -- #RRGGBB hex codes
        names = false, -- "Name" codes like Blue
        RRGGBBAA = true, -- #RRGGBBAA hex codes
        AARRGGBB = false, -- 0xAARRGGBB hex codes
        rgb_fn = false, -- CSS rgb() and rgba() functions
        hsl_fn = false, -- CSS hsl() and hsla() functions
        css = false, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
        css_fn = false, -- Enable all CSS *functions*: rgb_fn, hsl_fn
        -- Available modes: foreground, background
        -- Available modes for `mode`: foreground, background,  virtualtext
        mode = "virtualtext", -- Set the display mode.
        virtualtext = "⬤"
      },
      filetypes = { "*",
        "!dirvish",
        "!fugitive",
        "!alpha",
        "!NvimTree",
        "!packer",
        "!neogitstatus",
        "!Trouble",
        "!lir",
        "!Outline",
        "!spectre_panel",
        "!toggleterm",
        "!DressingSelect",
        "!TelescopePrompt",
        "!rbrowser",
        "!rdoc"
      },
      -- all the sub-options of filetypes apply to buftypes
      buftypes = {
        "!nofile",
        "!prompt",
        "!popup",
        "!scratch",
        "!unlisted",
      },
    })

    vim.cmd(
      [[autocmd ColorScheme * lua package.loaded['colorizer'] = nil; require('colorizer').setup(); require('colorizer').attach_to_buffer(0)]]
    )
  end,
}
