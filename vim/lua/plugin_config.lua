-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true
vim.cmd([[colorscheme vim-material]])

require("nvim-tree").setup()

require("toggleterm").setup({ open_mapping = [[<c-\>]] })

require("mason").setup()
require("mason-lspconfig").setup()
require("mason-nvim-dap").setup()
require("mason-null-ls").setup()

-- Completion
local cmp = require("cmp")
cmp.setup({
	snippet = {
		expand = function(args)
			-- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
			require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
			-- require'snippy'.expand_snippet(args.body) -- For `snippy` users.
			-- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
		end,
	},
	-- window = {
	--   -- completion = cmp.config.window.bordered(),
	--   -- documentation = cmp.config.window.bordered(),
	-- },
	mapping = cmp.mapping.preset.insert({
		["<C-d>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<CR>"] = cmp.mapping.confirm({ select = true }),
	}),
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		-- { name = 'vsnip' }, -- For vsnip users.
		{ name = "luasnip" }, -- For luasnip users.
		-- { name = 'snippy' }, -- For snippy users.
		-- { name = 'ultisnips' }, -- For ultisnips users.
	}, {
		{ name = "buffer" },
	}),
})

-- `/` cmdline setup.
cmp.setup.cmdline("/", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = "buffer" },
	},
})

local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- `:` cmdline setup.
cmp.setup.cmdline(":", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = "path" },
	}, {
		{ name = "cmdline" },
	}),
})

-- Setup lspconfig.
local lspconfig = require("lspconfig")
lspconfig.pyright.setup({ capabilities = capabilities })
lspconfig.gopls.setup({
	capabilities = capabilities,
	cmd = { "gopls", "serve" },
	filetypes = { "go", "gomod" },
	root_dir = lspconfig.util.root_pattern("go.mod", ".git"),
	settings = {
		gopls = {
			completeUnimported = true,
			usePlaceholders = true,
			analyses = {
				unusedparams = true,
			},
		},
	},
})
lspconfig.lua_ls.setup({
	capabilities = capabilities,
	settings = {
		Lua = {
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = { "vim" },
			},
			workspace = {
				-- Make the server aware of Neovim runtime files
				library = vim.api.nvim_get_runtime_file("", true),
				checkThirdParty = false,
			},
			-- Do not send telemetry data containing a randomized but unique identifier
			telemetry = {
				enable = false,
			},
		},
	},
})

local null_ls = require("null-ls")
null_ls.setup({
	sources = {
		null_ls.builtins.formatting.black,
		null_ls.builtins.formatting.isort,
		null_ls.builtins.formatting.goimports,
		null_ls.builtins.formatting.gofumpt,
		null_ls.builtins.formatting.golines,
		null_ls.builtins.formatting.stylua,
	},
	on_attach = function(client, bufnr)
		if client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					vim.lsp.buf.format({ async = false })
				end,
			})
		end
	end,
})

require("nvim-treesitter.configs").setup({
	ensure_installed = { "lua", "python", "go" },
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
})

require("Comment").setup()

require("gitsigns").setup()

require("indent_blankline").setup({
	show_end_of_line = true,
})

local api = require("nvim-tree.api")
function Open_tree()
	api.tree.toggle({ path = vim.loop.cwd() })
end

function Open_tree_here()
	api.tree.toggle({ path = vim.loop.cwd(), find_file = true })
end

require("symbols-outline").setup()

-- require('nvim-web-devicons').setup()
require("lualine").setup()

require("bufferline").setup()

require("hop").setup()

require("yanky").setup()