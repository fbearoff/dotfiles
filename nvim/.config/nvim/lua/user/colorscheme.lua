-- vim.g.gruvbox_contrast_dark = "hard"
vim.cmd [[
try
  colorscheme kanagawa
catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme default
  set background=dark
endtry
]]
