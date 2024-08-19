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
add("junegunn/seoul256.vim")

-- status line
add("nvim-lualine/lualine.nvim")

-- buffer line
add("akinsho/bufferline.nvim")

-- delete buffers
add("kazhala/close-buffers.nvim")

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

-- Git conflicts
add({ "akinsho/git-conflict.nvim", version = "*", config = true })

-- Terminal manager
add({ "akinsho/toggleterm.nvim", version = "*", config = true })

-- File manager
add("nvim-tree/nvim-tree.lua")
add("nvim-tree/nvim-web-devicons")

-- Key mappings
add("folke/which-key.nvim")

-- Faster find
add("ibhagwan/fzf-lua")

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

-- LSP config for rust-analyzer
add({
	"mrcjkb/rustaceanvim",
	version = "^5", -- Recommended
	lazy = false, -- This plugin is already lazy
})

-- pairs of brackets quotes etc
add("windwp/nvim-autopairs")

-- pictograms for lsp
add("onsails/lspkind.nvim")

-- live function signature
add("ray-x/lsp_signature.nvim")

-- lsp ui
add("DNLHC/glance.nvim")

-- Highlighting
add({ "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" })
add("folke/todo-comments.nvim")

-- context of current buffer (e.g., function)
add("nvim-treesitter/nvim-treesitter-context")

-- Undotree
add("mbbill/undotree")

-- Beautify error messages
add({
	"folke/trouble.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = {},
})

--
add("roobert/f-string-toggle.nvim")

-- Show line indents
add("lukas-reineke/indent-blankline.nvim")

-- Gitsigns
-- TODO: Use to stage hunks and show blame
add("lewis6991/gitsigns.nvim")

-- browse workspace symbols
add("hedyhli/outline.nvim")

-- highlight other term
add("RRethy/vim-illuminate")

-- debugging
add("mfussenegger/nvim-dap")
add({ "rcarriga/nvim-dap-ui", dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" } })
add({
	"leoluz/nvim-dap-go",
	ft = "go",
	dependencies = { "mfussenegger/nvim-dap" },
})
add("theHamsta/nvim-dap-virtual-text")

-- Use jay-babu/mason-nvim-dap.nvim instead
-- add 'ravenxrz/DAPInstall.nvim'

-- completion
add("hrsh7th/cmp-nvim-lsp")
add("hrsh7th/cmp-buffer")
add("hrsh7th/cmp-path")
add("hrsh7th/cmp-cmdline")
add("hrsh7th/nvim-cmp")

-- TODO: Fix luasnip and reenable
add({ "L3MON4D3/LuaSnip", version = "v2.*", build = "make install_jsregexp" })
-- add("honza/vim-snippets")

-- Use tools that don't speak LSP
-- Null-Ls alternative
add("nvimtools/none-ls.nvim")

-- Easy Motion Lua variant
add("phaazon/hop.nvim")

-- Github Copilot
add("zbirenbaum/copilot.lua")
add("zbirenbaum/copilot-cmp")

-- Improved yank ring
add("gbprod/yanky.nvim")

-- Multiline enable when I figure out keymappings
-- add 'mg979/vim-visual-multi'

-- IDE UI elements
add("ldelossa/litee.nvim")
add("ldelossa/litee-calltree.nvim")

-- Lazy git
add({
	"kdheepak/lazygit.nvim",
	-- optional for floating window border decoration
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
})

-- Minis: Lots of really cool & minimal plugin
add("echasnovski/mini.nvim")

-- Markdown
add("jghauser/follow-md-links.nvim")

-- Marks
add("chentoast/marks.nvim")

-- for experimentation
-- Can I used this to maintain state of a project?
add("Shatur/neovim-session-manager")
add("ahmedkhalf/project.nvim")

-- Edit Macros
add("ecthelionvi/NeoComposer.nvim")

-- Tests
add("nvim-neotest/neotest")

-- Browse
-- Requires telescope?
-- add("lalitmee/browse.nvim")

-- Profiling/benchmarking currneltly not needed
-- add("stevearc/profile.nvim")

-- Go tricks
add("olexsmir/gopher.nvim")

-- Refactoring
add("ThePrimeagen/refactoring.nvim")

return plugins
