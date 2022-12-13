local status_ok, colorizer = pcall(require, "colorizer")
if not status_ok then
  return
end

colorizer.setup {
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
  },
  user_default_options = {
    RGB = true, -- #RGB hex codes
    RRGGBB = true, -- #RRGGBB hex codes
    names = true, -- "Name" codes like Blue or blue
    RRGGBBAA = true, -- #RRGGBBAA hex codes
    AARRGGBB = false, -- 0xAARRGGBB hex codes
    rgb_fn = false, -- CSS rgb() and rgba() functions
    hsl_fn = false, -- CSS hsl() and hsla() functions
    css = false, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
    css_fn = false, -- Enable all CSS *functions*: rgb_fn, hsl_fn
    -- Available modes for `mode`: foreground, background,  virtualtext
    mode = "virtualtext", -- Set the display mode.
    -- Available methods are false / true / "normal" / "lsp" / "both"
    -- True is same as normal
    tailwind = false, -- Enable tailwind colors
    -- parsers can contain values used in |user_default_options|
    sass = { enable = false, parsers = { css }, }, -- Enable sass colors
    virtualtext = "⬤",
  },
  -- all the sub-options of filetypes apply to buftypes
  buftypes = {
    "!nofile",
    "!prompt",
    "!popup",
    "!scratch",
    "!unlisted",
  },
}
