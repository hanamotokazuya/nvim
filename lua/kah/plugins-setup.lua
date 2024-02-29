local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins-setup.lua source <afile> | PackerSync
  augroup end
]])

local status, packer = pcall(require, 'packer')
if not status then return end

return packer.startup(function(use)
  use 'wbthomason/packer.nvim'
  -- lua functions that many plugins use
  use 'nvim-lua/plenary.nvim'
  use { 'nvim-telescope/telescope.nvim', tag = '0.1.4' }
  -- color scheme
  use { 'bluz71/vim-nightfly-guicolors', as = 'nightfly' }
  use 'szw/vim-maximizer'
  use 'norcalli/nvim-colorizer.lua'
  -- icons
  use 'nvim-tree/nvim-web-devicons'
  -- status line
  use 'nvim-lualine/lualine.nvim'
  -- buffer line
  -- use {'akinsho/bufferline.nvim', tag = "v3.*"}
  -- file explorer
  use 'nvim-tree/nvim-tree.lua'
  -- indent visible
  use 'lukas-reineke/indent-blankline.nvim'
  -- scrollbar
  use 'petertriho/nvim-scrollbar'
  use 'lewis6991/gitsigns.nvim'
  use ('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' })
  use {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v1.x',
    requires = {
      -- LSP Support
      {'neovim/nvim-lspconfig'},             -- Required
      {'williamboman/mason.nvim'},           -- Optional
      {'williamboman/mason-lspconfig.nvim'}, -- Optional

      -- Autocompletion
      {'hrsh7th/nvim-cmp'},         -- Required
      {'hrsh7th/cmp-nvim-lsp'},     -- Required
      {'hrsh7th/cmp-buffer'},       -- Optional
      {'hrsh7th/cmp-path'},         -- Optional
      {'saadparwaiz1/cmp_luasnip'}, -- Optional
      {'hrsh7th/cmp-nvim-lua'},     -- Optional

      -- Snippets
      {'L3MON4D3/LuaSnip'},             -- Required
      {'rafamadriz/friendly-snippets'}, -- Optional
    }
  }
  -- LSP UIs
  use 'nvimdev/lspsaga.nvim'
  -- vscode-like pictograms
  use 'onsails/lspkind.nvim'
  -- auto brackets
  use 'windwp/nvim-autopairs'
  -- auto tags
  use 'windwp/nvim-ts-autotag'
  -- essential plugins
  use 'tpope/vim-surround'
  use 'vim-scripts/ReplaceWithRegister'
  -- commenting with gc
  use 'numToStr/Comment.nvim'
  -- formatting & linting
  use 'jose-elias-alvarez/null-ls.nvim'
  use 'jayp0521/mason-null-ls.nvim'
  use 'MunifTanjim/prettier.nvim'
--   -- markdown preview
--   -- use({ "iamcco/markdown-preview.nvim", run = "cd app && npm install", setup = function() vim.g.mkdp_filetypes = { "markdown" } end, ft = { "markdown" }, })

  if packer_bootstrap then
    require('packer').sync()
  end
end)
