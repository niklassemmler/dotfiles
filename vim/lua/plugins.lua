local plugins = {}
local add = function(value)
	table.insert(plugins, value)
end

-- # Visuals
-- colorscheme
add("altercation/vim-colors-solarized")
add("hzchirs/vim-material")
add("sjl/badwolf")
add("morhetz/gruvbox")
add("folke/tokyonight.nvim")

-- status line
add("nvim-lualine/lualine.nvim")

-- buffer line
add("akinsho/bufferline.nvim")

-- Startpage
add("mhinz/vim-startify")

-- Start at the last place
add("ethanholz/nvim-lastplace")

-- Offers a diff option for swp files
add("chrisbra/Recover.vim")

-- File interaction
add("tpope/vim-eunuch")

-- Lua function library
add("nvim-lua/plenary.nvim")

-- Git
-- > git commands
-- - Git show files
-- - Git move target_path
-- - Git blame | <CR> to return
add("tpope/vim-fugitive")

-- Terminal manager
add({ "akinsho/toggleterm.nvim", version = "*", config = true })

-- File manager
add("nvim-tree/nvim-tree.lua")
add("nvim-tree/nvim-web-devicons")

-- Key mappings
add("folke/which-key.nvim")

-- Faster find
add("ibhagwan/fzf-lua")

-- Session management
add("tpope/vim-obsession")

-- Manage external dependencies
add({
	"williamboman/mason.nvim",
	build = ":MasonUpdate",
	ensure_installed = {
		"gopls",
	},
})
add("jay-babu/mason-nvim-dap.nvim")
add("williamboman/mason-lspconfig.nvim")
add("jay-babu/mason-null-ls.nvim")

-- LSP Configs
add("neovim/nvim-lspconfig")

-- Highlighting
add({ "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" })

-- Undotree
add("mbbill/undotree")

-- Comments
add("numToStr/Comment.nvim")

-- Beautify error messages
add({
	"folke/trouble.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = {},
})

-- Show line indents
add("lukas-reineke/indent-blankline.nvim")

-- Gitsigns
add("lewis6991/gitsigns.nvim")

-- browse workspace symbols
add("simrat39/symbols-outline.nvim")

-- highlight other term
add("RRethy/vim-illuminate")

-- debugging
add("mfussenegger/nvim-dap")
add({ "rcarriga/nvim-dap-ui", dependencies = { "mfussenegger/nvim-dap" } })
add({
	"leoluz/nvim-dap-go",
	ft = "go",
	dependencies = { "mfussenegger/nvim-dap" },
})

-- Use jay-babu/mason-nvim-dap.nvim instead
-- add 'ravenxrz/DAPInstall.nvim'

-- completion
add("neovim/nvim-lspconfig")
add("hrsh7th/cmp-nvim-lsp")
add("hrsh7th/cmp-buffer")
add("hrsh7th/cmp-path")
add("hrsh7th/cmp-cmdline")
add("hrsh7th/nvim-cmp")
add("L3MON4D3/LuaSnip")
add("honza/vim-snippets")

-- neovim configuration
-- add 'folke/neodev.nvim'
-- Doesn't work for me

-- Use tools that don't speak LSP
add("jose-elias-alvarez/null-ls.nvim")

-- Easy Motion Lua variant
add("phaazon/hop.nvim")

-- Github Copilot
add("github/copilot.vim")

-- Improved yank ring
add("gbprod/yanky.nvim")

-- Multiline enable when I figure out keymappings
-- add 'mg979/vim-visual-multi'

return plugins
