-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true
vim.cmd([[colorscheme vim-material]])

require("nvim-tree").setup({
	sync_root_with_cwd = true,
	respect_buf_cwd = true,
	update_focused_file = {
		enable = true,
		update_root = true,
	},
})

require("toggleterm").setup({ open_mapping = [[<c-\>]] })

require("mason").setup()
require("mason-lspconfig").setup()
require("mason-nvim-dap").setup({ automatic_setup = true, handlers = {} })
require("dapui").setup()
require("mason-null-ls").setup()

-- Completion
local lspkind = require("lspkind")
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
	formatting = {
		format = lspkind.cmp_format({
			mode = "symbol", -- show only symbol annotations
			maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
			ellipsis_char = "...", -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)

			-- The function below will be called before any actual modifications from lspkind
			-- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
			before = function(entry, vim_item)
				return vim_item
			end,
		}),
	},
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
lspconfig.rust_analyzer.setup({
	capabilities = capabilities,
})
lspconfig.pylsp.setup({
	capabilities = capabilities,
	settings = {
		pylsp = {
			plugins = {
				rope = {
					enable = true,
					rope_autoimport_enabled = true,
				},
			},
		},
	},
})
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
cmp.setup({
	formatting = {
		format = lspkind.cmp_format({
			mode = "symbol", -- show only symbol annotations
			maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
			ellipsis_char = "...", -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)

			-- The function below will be called before any actual modifications from lspkind
			-- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
			before = function(entry, vim_item)
				return vim_item
			end,
		}),
	},
})
require("lsp_signature").setup({ hint_enable = false })

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
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
	ensure_installed = { "lua", "python", "go", "rust" },
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
})
require("todo-comments").setup()
require("treesitter-context").setup()

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

-- configure the litee.nvim library
require("litee.lib").setup()
-- configure litee-calltree.nvim
require("litee.calltree").setup()
require("litee.symboltree").setup()

-- minis
require("mini.ai").setup()
require("mini.comment").setup()
require("mini.bracketed").setup()
-- require("mini.move").setup()
require("mini.pairs").setup()
require("mini.splitjoin").setup()
require("mini.surround").setup()

-- marks
require("marks").setup()

require("project_nvim").setup()

local config = require("session_manager.config")
require("session_manager").setup({
	autosave_last_session = false,
	autosave_ignore_dirs = { "/home/nsemmler" },
	autoload_mode = config.AutoloadMode.CurrentDir,
})
local config_group = vim.api.nvim_create_augroup("MyConfigGroup", {}) -- A global group for all your config autocommands
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	group = config_group,
	callback = function()
		if vim.bo.filetype ~= "git" and not vim.bo.filetype ~= "gitcommit" and not vim.bo.filetype ~= "gitrebase" then
			require("session_manager").autosave_session()
		end
	end,
})
