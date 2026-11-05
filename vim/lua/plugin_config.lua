-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true
vim.cmd([[colorscheme vim-material]])

require("nvim-tree").setup({
	sync_root_with_cwd = true,
	view = { width = 40 },
	respect_buf_cwd = true,
	update_focused_file = {
		enable = true,
		update_root = true,
	},
})
local api = require("nvim-tree.api")
function Open_tree()
	api.tree.toggle({ path = vim.loop.cwd() })
end

function Open_tree_here()
	api.tree.toggle({ path = vim.loop.cwd(), find_file = true })
end

require("toggleterm").setup({ open_mapping = [[<c-\>]] })

require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = { "pyright", "lua_ls", "rust_analyzer", "ts_ls", "gopls", "ruff", "eslint" },
})
require("mason-nvim-dap").setup({ automatic_setup = true, handlers = {} })
require("dapui").setup()
require("nvim-dap-virtual-text").setup()
local dap = require("dap")
dap.configurations.rust = {
	{
		name = "Debug generic rust",
		type = "codelldb",
		request = "launch",
		program = vim.fn.getcwd() .. "/target/debug/" .. vim.fn.fnamemodify(vim.fn.getcwd(), ":t"),
		cwd = "${workspaceFolder}",
		stopOnEntry = false,
	},
}
require("mason-null-ls").setup({
	ensure_installed = {
		"black",
		"isort",
		"mypy",
		"goimports",
		"golines",
		"stylua",
		"gofumpt",
		"google_java_format",
		"prettier",
		"sql_formatter",
	},
})

-- Completion
local lspkind = require("lspkind")
local cmp = require("cmp")
-- local luasnip = require("luasnip")
local has_words_before = function()
	unpack = unpack or table.unpack
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end
cmp.setup({
	snippet = {
		expand = function(args)
			vim.snippet.expand(args.body)
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
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif has_words_before() then
				cmp.complete()
			else
				fallback()
			end
		end, { "i", "s" }),

		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			else
				fallback()
			end
		end, { "i", "s" }),
	}),
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
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
-- rust_analyzer is automatically setup by rustacean.nvim
-- keeping just in case I wanto to go back
-- lspconfig.rust_analyzer.setup({
-- 	capabilities = capabilities,
-- })
vim.lsp.config("html", {
	capabilities = capabilities,
})
vim.lsp.config("tailwindcss", {
	capabilities = capabilities,
})
-- ts_ls: TypeScript/JavaScript. Diagnostics come from tsserver (same type errors
-- tsc reports for open files + their imports). The inlayHints block makes ts_ls
-- emit inline type/parameter hints; they're actually rendered by the LspAttach
-- handler below calling vim.lsp.inlay_hint.enable.
local ts_inlay_hints = {
	includeInlayParameterNameHints = "all",
	includeInlayParameterNameHintsWhenArgumentMatchesName = false,
	includeInlayFunctionParameterTypeHints = true,
	includeInlayVariableTypeHints = true,
	includeInlayVariableTypeHintsWhenTypeMatchesName = false,
	includeInlayPropertyDeclarationTypeHints = true,
	includeInlayFunctionLikeReturnTypeHints = true,
	includeInlayEnumMemberValueHints = true,
}
vim.lsp.config("ts_ls", {
	capabilities = capabilities,
	settings = {
		typescript = { inlayHints = ts_inlay_hints },
		javascript = { inlayHints = ts_inlay_hints },
	},
})
vim.lsp.config("pyright", {
	capabilities = capabilities,
})
-- Ruff: Python linting + code actions. Formatting stays with black/isort (null-ls),
-- so Ruff's formatter is disabled to avoid duplicate formatters on <leader>rf.
vim.lsp.config("ruff", {
	capabilities = capabilities,
	on_attach = function(client)
		client.server_capabilities.documentFormattingProvider = false
		client.server_capabilities.documentRangeFormattingProvider = false
	end,
})
-- ESLint: JS/TS linting + code actions (replaces the removed eslint_d null-ls source).
vim.lsp.config("eslint", {
	capabilities = capabilities,
})
vim.lsp.config("jsonnet_language_server", {
	capabilities = capabilities,
})
vim.lsp.config('gopls', {
    capabilities = capabilities,
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
if vim.fn.hostname() ~= "Policy1st" then
	vim.lsp.config("lua_ls", {
		capabilities = capabilities,
		settings = {
			Lua = {
				runtime = {
					version = "LuaJIT",
				},
				diagnostics = {
					-- Get the language server to recognize the `vim` global
					globals = { "vim" },
				},
				workspace = {
					-- Make the server aware of Neovim runtime files
					library = vim.api.nvim_get_runtime_file("", true),
					checkThirdParty = false,
					ignoreDir = { "lazy" },
				},
				-- Do not send telemetry data containing a randomized but unique identifier
				telemetry = {
					enable = false,
				},
			},
		},
	})
end
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client and client:supports_method("textDocument/signatureHelp") then
      vim.api.nvim_create_autocmd("CursorHoldI", {
        buffer = args.buf,
        callback = function() vim.lsp.buf.signature_help() end,
      })
    end
    -- Inline inlay hints (inferred types, parameter names) for servers that support them (ts_ls, etc.)
    if client and client:supports_method("textDocument/inlayHint") then
      vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
    end
  end,
})

-- Diagnostics display: show the error text inline, not just sign-column icons.
-- virtual_text puts a short message at the end of the line; because TypeScript
-- errors are often long, <leader>dv toggles virtual_lines (full message below
-- the line) for the current buffer.
vim.diagnostic.config({
	virtual_text = {
		spacing = 2,
		prefix = "●",
		source = "if_many",
	},
	underline = true,
	severity_sort = true,
	update_in_insert = false,
	float = { border = "rounded", source = true },
})

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
local null_ls = require("null-ls")
null_ls.setup({
	debug = true,
	sources = {
		null_ls.builtins.formatting.black,
		null_ls.builtins.formatting.isort,
		null_ls.builtins.diagnostics.mypy.with({
			extra_args = function()
				local virtual = os.getenv("VIRTUAL_ENV") or os.getenv("CONDA_DEFAULT_ENV") or "/usr"
				return { "--python-executable", virtual .. "/bin/python3" }
			end,
		}),
		null_ls.builtins.formatting.goimports,
		null_ls.builtins.formatting.gofumpt,
		null_ls.builtins.formatting.golines,
		null_ls.builtins.formatting.stylua,
		null_ls.builtins.formatting.google_java_format,
		null_ls.builtins.formatting.prettier,
		null_ls.builtins.formatting.sql_formatter,
	},
	on_attach = function(client, bufnr)
		if client:supports_method("textDocument/formatting") then
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

-- nvim-treesitter `main` branch (the rewrite): no module system, no
-- `.configs.setup{}`. Parsers are installed explicitly, and highlighting is
-- opt-in per buffer via `vim.treesitter.start()`. See :h nvim-treesitter.
require("nvim-treesitter").install({
	"lua", "python", "go", "rust", "java",
	"bash", "sql", "json", "yaml", "toml",
	"markdown", "markdown_inline", "vim", "vimdoc",
})

-- Start Tree-sitter highlighting for any buffer whose filetype has a parser.
-- pcall keeps it silent while parsers are still installing on first launch.
vim.api.nvim_create_autocmd("FileType", {
	callback = function(args)
		local lang = vim.treesitter.language.get_lang(vim.bo[args.buf].filetype)
		if lang and pcall(vim.treesitter.language.add, lang) then
			-- `start` asserts a parser actually exists; some filetypes
			-- (e.g. startify) resolve to a lang name with no parser, so
			-- keep this guarded too.
			pcall(vim.treesitter.start, args.buf, lang)
		end
	end,
})
require("todo-comments").setup()
require("treesitter-context").setup()

-- git
require("gitsigns").setup()
require("conflict").setup()

require("image").setup({
	backend = "kitty",
	integrations = {
		markdown = {
			enabled = true,
			download_remote_images = false,
			filetypes = { "markdown" },
		},
	},
	max_width = 100,
	max_height = 12,
	window_overlap_clear_enabled = true,
	window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
})
require("render-markdown").setup({})

require("ibl").setup()

require("outline").setup()

-- require('nvim-web-devicons').setup()
require("lualine").setup()

-- buffer management
require("bufferline").setup()
-- close buffers
require("close_buffers").setup({
	preserve_window_layout = { "this" },
	next_buffer_cmd = function(windows)
		require("bufferline").cycle(1)
		local bufnr = vim.api.nvim_get_current_buf()

		for _, window in ipairs(windows) do
			vim.api.nvim_win_set_buf(window, bufnr)
		end
	end,
})

require("yanky").setup()

-- minis
require("mini.ai").setup()
require("mini.comment").setup()
require("mini.bracketed").setup()
-- require("mini.move").setup()
-- This drives me nuts, it always always adds two brackets/quotes/etc.
-- require("mini.pairs").setup()
require("mini.splitjoin").setup()
require("mini.surround").setup()

-- marks
require("marks").setup({
	default_mappings = true,
	signs = true,
	mappings = {},
})
require("nvim-lastplace").setup({})

require("project_nvim").setup()

-- local config = require("session_manager.config")
-- require("session_manager").setup({
-- 	autosave_last_session = false,
-- 	autosave_ignore_dirs = { "/home/nsemmler" },
-- 	autoload_mode = config.AutoloadMode.CurrentDir,
-- })
-- local config_group = vim.api.nvim_create_augroup("MyConfigGroup", {}) -- A global group for all your config autocommands
-- vim.api.nvim_create_autocmd({ "BufWritePost" }, {
-- 	group = config_group,
-- 	callback = function()
-- 		if vim.bo.filetype ~= "git" and not vim.bo.filetype ~= "gitcommit" and not vim.bo.filetype ~= "gitrebase" then
-- 			require("session_manager").autosave_session()
-- 		end
-- 	end,
-- })

require("refactoring").setup({})
require("gopher").setup({})

-- enable signs
local signs = { Error = "", Warn = "⚠", Hint = "", Info = "", Information = "" }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- reasonable auto pairs
require("nvim-autopairs").setup({})

-- f string python
require("f-string-toggle").setup({
	key_binding = "<leader>F",
	key_binding_desc = "Toggle f-string",
})
