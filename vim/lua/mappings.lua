-- A list of vim mappings
-- These should be independent of plugins
local wk = require("which-key")
local set = function(mode, mapping, cmd, desc)
	vim.keymap.set(mode, mapping, cmd, { desc = desc })
end

-- Buffers
wk.register({
	b = {
		name = "Buffers",
		n = { "<cmd> bn<cr>", "Next buffer" },
		p = { "<cmd> bp<cr>", "Previous buffer" },
		d = { "<cmd> bd<cr>", "Delete buffer" },
		o = { "<cmd> b ", "Open buffer" },
		s = { "<cmd> sb ", "Open buffer horizontally" },
		v = { "<cmd> vert sb ", "Open buffer vertically" },
		c = { "<cmd> lua require('fzf-lua').buffers()<cr>", "Choose (fzf)" },
	},
}, { prefix = "<leader>" })

set("n", "<Tab>", "<cmd> bn<cr>", "Next buffer")
set("n", "<S-Tab>", "<cmd> bp<cr>", "Previous buffer")

-- Tabs
wk.register({
	t = {
		name = "Tabs",
		n = { "<cmd> tabn<cr>", "Tab next" },
		p = { "<cmd> tabp<cr>", "Tab previous" },
		s = { "<cmd> tab split<cr>", "Tab split" },
		o = { "<cmd> tabnew<cr>", "Tab new" },
		q = { "<cmd> tabclose<cr>", "Tab close" },
		c = { "<cmd> lua require('fzf-lua').tabs()<cr>", "Choose (fzf)" },
	},
}, { prefix = "<leader>" })
set("n", "J", "<cmd> tabn<cr>")
set("n", "K", "<cmd> tabp<cr>")

-- Files
wk.register({
	f = {
		name = "Files",
		e = { "<cmd> e ", "File edit" },
		w = { "<cmd> w<cr>", "File write" },
		s = { "<cmd> w<cr>", "File write" },
		q = { "<cmd> q<cr>", "File quit" },
		t = { Open_tree, "Toggle finder" },
		h = { Open_tree_here, "Toggle finder here" },
		c = { "<cmd> lua require('fzf-lua').files()<cr>", "Choose (FzF)" },
		f = { "w !sudo tee % >/dev/null", "sudo write" },
	},
}, { prefix = "<leader>" })
set("n", "F", Open_tree)
set({ "n", "v", "i" }, "<C-s>", "<cmd> w<cr>")

-- Splits
wk.register({
	s = {
		name = "Splits",
		h = { "<cmd> split ", "Split horizontally" },
		v = { "<cmd> vsplit ", "Split vertically" },
	},
}, { prefix = "<leader>" })
set("", "<C-h>", "<cmd> wincmd h<CR>", "Move to left split")
set("", "<C-j>", "<cmd> wincmd j<CR>", "Move to bottom split")
set("", "<C-k>", "<cmd> wincmd k<CR>", "Move to top split")
set("", "<C-l>", "<cmd> wincmd l<CR>", "Move to right split")
set("", "<C-+>", "<cmd> wincmd resize 10<CR>", "Move to right split")
set("", "<C-->", "<cmd> wincmd resize -10<CR>", "Move to right split")

-- Load config
vim.g.VIMRC = "~/.config/nvim/"
wk.register({
	l = {
		name = "Edit Config",
		i = { "<cmd> e ~/.vim/init.lua<cr>", "Init.lua" },
		p = { "<cmd> e ~/.vim/lua/plugins.lua<cr>", "Plugins" },
		c = { "<cmd> e ~/.vim/lua/plugin_config.lua<cr>", "Plugin config" },
		m = { "<cmd> e ~/.vim/lua/mappings.lua<cr>", "Key mappings" },
	},
}, { prefix = "<leader>" })

-- Search for selected term
set("v", "//", 'y/<c-r>"<cr>', "Search for selection")

-- Set spell checker
wk.register({
	L = {
		name = "Spell checker",
		e = { "<cmd> set spell spelllang=en_us<cr>", "Language EN_US" },
		d = { "<cmd> set spell spelllang=de_de<cr>", "Language DE_DE" },
		g = { "<cmd> set spell spelllang=de_de<cr>", "Language DE_DE" },
		o = { "<cmd> set nospell<cr>", "Disable" },
	},
}, { prefix = "<leader>" })

-- # Basics
-- Use semicolon and colon
set("n", ";", "<cmd> ", "Switch to command mode")

-- Retain visual selection on tabbing.
set("v", "<", "<gv", "Move selected text left")
set("v", ">", ">gv", "Move selected text right")

-- Navigate text lines in wrap
set("n", "j", "gj", "Go down in wrap")
set("n", "k", "gk", "Go up in wrap")
set("n", "vj", "vgj", "Select down in wrap")
set("n", "vk", "vgk", "Select up in wrap")

-- Reach insert mode easier.
set("i", "jk", "<esc>", "Switch to command mode")

-- Add line after or before current line
set("n", "<leader>o", "o<Esc>j", "Add line below")
set("n", "<leader>O", "O<Esc>k", "Add line above")

-- disable search highlightinq
set("n", "<leader>sq", "<cmd> nohlsearch<cr>", "Disable search highlighting")

-- gv highlights last selected text
-- gV now highlights last entered text
set("v", "gV", "`[v`]", "Highlight last entered text")

-- Copy to system register
set({ "n", "v" }, "<leader>c", '"+y', "Copy to system register")

-- Paste from system register
set("n", "<leader>v", '"+p', "Paste from system register")

-- Testing
wk.register({
	T = {
		name = "Testing",
		t = { "<cmd> TestNearest<CR>", "Nearest" },
		f = { "<cmd> TestFile<CR>", "File" },
		s = { "<cmd> TestSuite<CR>", "Suite" },
		l = { "<cmd> TestLast<CR>", "Last" },
		v = { "<cmd> TestVisit<CR>", "Visit" },
	},
}, { prefix = "<leader>" })

-- Access via fzf
wk.register({
	a = {
		name = "Access (fzf)",
		f = { "<cmd> lua require('fzf-lua').files()<cr>", "Files" },
		b = { "<cmd> lua require('fzf-lua').buffers()<cr>", "Buffers" },
		q = { "<cmd> lua require('fzf-lua').quickfix()<cr>", "Quickfix" },
		l = { "<cmd> lua require('fzf-lua').oldfiles()<cr>", "Last files" },
		m = { "<cmd> lua require('fzf-lua').man_pages()<cr>", "Man pages" },
		g = { "<cmd> lua require('fzf-lua').grep()<cr>", "Grep" },
	},
}, { prefix = "<leader>" })

-- Terminal
wk.register({
	e = {
		name = "Terminal",
		f = { "<cmd> ToggleTerm direction=float<cr>", "Float" },
		h = { "<cmd> ToggleTerm size=20 direction=horizontal<cr>", "Horizontal" },
		v = { "<cmd> ToggleTerm size=50 direction=vertical<cr>", "Vertical" },
		e = { "<cmd> ToggleTermSendCurrentLine<cr>", "Execute" },
	},
}, { prefix = "<leader>" })

wk.register({
	t = {
		name = "Terminal",
		e = { "<cmd> ToggleTermSendVisualSelection<cr>", "Execute" },
	},
}, { prefix = "<leader>", mode = "v" })

set("t", "<esc>", [[<C-\><C-n>]], "Exit terminal mode")
set("t", "jk", [[<C-\><C-n>]], "Exit terminal mode")

-- Sessions
wk.register({
	S = {
		name = "Session",
		s = { "<cmd> Obsession<cr>", "Store" },
		d = { "<cmd> Obsession!<cr>", "Delete" },
	},
}, { prefix = "<leader>" })
set("n", "QQ", "<cmd> qa<cr>", "Quit all")
set({ "n", "i", "v" }, "<C-q>", "<cmd> q<cr>", "Close buffer")
set("n", "XX", "<cmd> bd<cr>", "Remove buffer")

-- Undotree
set("n", "U", "<cmd> UndotreeToggle<cr>", "Undo tree")

-- LSP
wk.register({
	d = {
		name = "Errors",
		f = { vim.diagnostic.open_float, "Float" },
		l = { vim.diagnostic.setloclist, "Loclist" },
		t = { "<cmd> TroubleToggle<cr>", "Trouble" },
	},
}, { prefix = "<leader>" })
set("n", "<S-Up>", vim.diagnostic.goto_prev, "Previous issue")
set("n", "<S-Down>", vim.diagnostic.goto_next, "Next issue")

-- Debug
local open_sidebar = function()
	local widgets = require("dap.ui.widgets")
	local sidebar = widgets.sidebar(widgets.scopes)
	sidebar.open()
end
wk.register({
	D = {
		name = "Debug",
		b = { "<cmd> DapToggleBreakPoint <cr>", "Add breakpoint" },
		s = { open_sidebar, "Open debug sidebar" },
		l = { require("dap-go").debug_last, "Debug last" },
		t = { require("dap-go").debug_test, "Debug test" },
	},
}, { prefix = "<leader>" })

--  External commands
wk.register({
	C = {
		name = "Tools",
		g = { "<cmd> LazyGit<cr>", "Lazy Git" },
	},
}, { prefix = "<leader>" })

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		-- Enable completion triggered by <c-x><c-o>
		vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

		-- Buffer local mappings.
		-- See `:help vim.lsp.*` for documentation on any of the below functions
		local setHere = function(mode, mapping, cmd, desc)
			vim.keymap.set(mode, mapping, cmd, {
				buffer = ev.buf,
				desc = desc,
			})
		end

		-- Go tos
		setHere("n", "<leader>gD", vim.lsp.buf.declaration, "Go to declaration")
		setHere("n", "<leader>gd", vim.lsp.buf.definition, "Go to definition")
		setHere("n", "<leader>gi", vim.lsp.buf.implementation, "Go to implementation")
		setHere("n", "<leader>gI", vim.lsp.buf.incoming_calls, "Go to incoming calls")
		setHere("n", "<leader>gO", vim.lsp.buf.outgoing_calls, "Go to outgoing calls")
		setHere("n", "<leader>gt", vim.lsp.buf.type_definition, "Go to type definition")
		setHere("n", "<leader>gr", vim.lsp.buf.references, "Show references")
		setHere("n", "<leader>gs", vim.lsp.buf.document_symbol, "Show symbols")

		-- Workspace
		setHere("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, "add workspace folder")
		setHere("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, "remove workspace folder")
		setHere("n", "<leader>wl", function()
			print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		end, "list workspace folders")

		-- in-place info
		setHere("n", "K", vim.lsp.buf.hover, "Hover")
		setHere("n", "<C-K>", vim.lsp.buf.signature_help, "Signature help")

		-- Refactor actions
		setHere("n", "<leader>rn", vim.lsp.buf.rename, "Rename")
		setHere({ "n", "v" }, "<leader>ra", vim.lsp.buf.code_action, "Code action")
		setHere("n", "<leader>rf", function()
			vim.lsp.buf.format({ async = true })
		end, "Format")
	end,
})

-- Symbols
set("n", "S", "<cmd> SymbolsOutline<cr>", "Show symbols")

-- Hop
set("n", "<leader>gw", "<cmd> HopWord<cr>", "Jump to word")

-- Yanky
require("yanky")
set({ "n", "x" }, "p", "<Plug>(YankyPutAfter)", "Paste after")
set({ "n", "x" }, "P", "<Plug>(YankyPutBefore)", "Paste before")
set({ "n", "x" }, "gp", "<Plug>(YankyGPutAfter)", "Paste after & move cursor")
set({ "n", "x" }, "gP", "<Plug>(YankyGPutBefore)", "Paste before & move cursor")
set("n", "<c-n>", "<Plug>(YankyCycleForward)", "Cycle forward")
set("n", "<c-p>", "<Plug>(YankyCycleBackward)", "Cycle backward")
