local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  require('packer').packadd = 'packer.nvim'
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
local group = vim.api.nvim_create_augroup("packer_user_config", { clear = true })
vim.api.nvim_create_autocmd("BufWritePost", {
  command = "source <afile> | PackerSync",
  pattern = "plugins.lua",
  group = group,
})
-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

-- Install your plugins here
return packer.startup(function(use)
  -- My plugins here
  use "wbthomason/packer.nvim" -- Have packer manage itself
  use "nvim-lua/popup.nvim" -- An implementation of the Popup API from vim in Neovim
  use "nvim-lua/plenary.nvim" -- Useful lua functions used by lots of plugins
  use "windwp/nvim-autopairs" -- Autopairs, integrates with both cmp and treesitter
  use "numToStr/Comment.nvim" -- Easily comment stuff
  use "kyazdani42/nvim-web-devicons" -- glyphs
  use "kyazdani42/nvim-tree.lua" -- file manager
  use "nvim-lualine/lualine.nvim" -- statusline
  use "akinsho/toggleterm.nvim" -- terminal in nvim
  use "ahmedkhalf/project.nvim" -- git project manager
  use "lewis6991/impatient.nvim" -- speedup plugin loading
  use "lukas-reineke/indent-blankline.nvim"
  use "goolord/alpha-nvim" -- greeting page
  use "folke/which-key.nvim" -- keymap reminder
  -- use { "jalvesaq/Nvim-R", commit = '16ad0bbf3496bc70c12d7f78df61778636374b0c' } -- R in vim
  use "jalvesaq/Nvim-R"
  use "chentoast/marks.nvim" -- marks in gutter
  use "cappyzawa/trim.nvim" -- fix whitespace
  use "romgrk/barbar.nvim" -- bufferbar
  use "DanilaMihailov/beacon.nvim" --show cursor jumps
  use "kosayoda/nvim-lightbulb" --show lightbulb when code action available
  use "RRethy/vim-illuminate" -- Illuminate other uses of current word/symbol under cursor
  use "mrjones2014/smart-splits.nvim" -- natural window switching
  use "AckslD/nvim-neoclip.lua" -- clipboard manager
  use "max397574/better-escape.nvim" -- ignore timeloutlen when escaping insert mode
  use { "ellisonleao/glow.nvim", branch = 'main' } -- render markdown
  use "NvChad/nvim-colorizer.lua" -- show color codes
  use "kylechui/nvim-surround" -- edit surrounding delimiters
  use "phaazon/hop.nvim" -- hinted text jumping
  use "lewis6991/satellite.nvim" --scrollbar with Git and marks
  use { "folke/noice.nvim", -- pretty UI
    requires = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify" -- notifications manager
    }
  }
  use "nguyenvukhang/nvim-toggler" -- toggle booleans
  use "cbochs/grapple.nvim" -- quickly access tagged files
  use { 'michaelb/sniprun', run = 'bash ./install.sh' } -- run code snippets
  use "gbprod/substitute.nvim" -- put over text with motion

  -- Colorschemes
  -- use "ellisonleao/gruvbox.nvim"
  use "rebelot/kanagawa.nvim"

  -- cmp plugins
  use "hrsh7th/nvim-cmp" -- The completion plugin
  use "hrsh7th/cmp-buffer" -- buffer completions
  use "hrsh7th/cmp-path" -- path completions
  use "hrsh7th/cmp-cmdline" -- cmdline completions
  use "hrsh7th/cmp-nvim-lua" -- nvim lua API completions
  use "saadparwaiz1/cmp_luasnip" -- snippet completions
  use "hrsh7th/cmp-nvim-lsp" -- LSP completions
  use "hrsh7th/cmp-nvim-lsp-signature-help" -- LSP signature completions
  use "jalvesaq/cmp-nvim-r" -- R completions

  -- snippets
  use "L3MON4D3/LuaSnip" -- snippet engine
  use "rafamadriz/friendly-snippets" -- a bunch of snippets to use

  -- LSP
  use "neovim/nvim-lspconfig" -- enable LSP
  use "williamboman/mason.nvim" --LSP installer
  use "williamboman/mason-lspconfig.nvim"
  use "SmiteshP/nvim-navic" -- show current document symbol

  -- Telescope
  use "nvim-telescope/telescope.nvim" -- selector
  use { "nvim-telescope/telescope-fzf-native.nvim", run = 'make' }
  use 'debugloop/telescope-undo.nvim'

  -- Treesitter
  use "nvim-treesitter/nvim-treesitter"
  use "RRethy/nvim-treesitter-textsubjects" -- smart incremental selection of code context
  use "nvim-treesitter/nvim-treesitter-context" -- show code context when scrolling
  use "p00f/nvim-ts-rainbow" --rainbow parens

  -- Git
  use "lewis6991/gitsigns.nvim" -- git signs in gutter

  -- DAP
  use "mfussenegger/nvim-dap"
  use "rcarriga/nvim-dap-ui"
  use "jayp0521/mason-nvim-dap.nvim"

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
