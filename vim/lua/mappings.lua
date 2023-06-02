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
		n = { ":bn<cr>", "Next buffer" },
		p = { ":bp<cr>", "Previous buffer" },
		d = { ":bd<cr>", "Delete buffer" },
		o = { ":b ", "Open buffer" },
		s = { ":sb ", "Open buffer horizontally" },
		v = { ":vert sb ", "Open buffer vertically" },
		c = { ":lua require('fzf-lua').buffers()<cr>", "Choose (fzf)" },
	},
}, { prefix = "<leader>" })

set("n", "<Tab>", ":bn<cr>", "Next buffer")
set("n", "<S-Tab>", ":bp<cr>", "Previous buffer")

-- Tabs
wk.register({
	t = {
		name = "Tabs",
		n = { ":tabn<cr>", "Tab next" },
		p = { ":tabp<cr>", "Tab previous" },
		s = { ":tab split<cr>", "Tab split" },
		o = { ":tabnew<cr>", "Tab new" },
		q = { ":tabclose<cr>", "Tab close" },
		c = { ":lua require('fzf-lua').tabs()<cr>", "Choose (fzf)" },
	},
}, { prefix = "<leader>" })
set("n", "J", ":tabn<cr>")
set("n", "K", ":tabp<cr>")

-- Files
wk.register({
	f = {
		name = "Files",
		e = { ":e ", "File edit" },
		w = { ":w<cr>", "File write" },
		s = { ":w<cr>", "File write" },
		q = { ":q<cr>", "File quit" },
		t = { Open_tree, "Toggle finder" },
		h = { Open_tree_here, "Toggle finder here" },
		c = { ":lua require('fzf-lua').files()<cr>", "Choose (FzF)" },
		f = { "w !sudo tee % >/dev/null", "sudo write" },
	},
}, { prefix = "<leader>" })
set("n", "F", Open_tree)
set({ "n", "v", "i" }, "<C-s>", "<cmd> w<cr>")

-- Splits
wk.register({
	s = {
		name = "Splits",
		h = { ":split ", "Split horizontally" },
		v = { ":vsplit ", "Split vertically" },
	},
}, { prefix = "<leader>" })
set("n", "<C-h>", ":wincmd h<CR>", "Move to left split")
set("n", "<C-j>", ":wincmd j<CR>", "Move to bottom split")
set("n", "<C-k>", ":wincmd k<CR>", "Move to top split")
set("n", "<C-l>", ":wincmd l<CR>", "Move to right split")

-- Load config
vim.g.VIMRC = "~/.config/nvim/init.lua"
wk.register({
	c = {
		name = "Edit Config",
		h = { ":split $MYVIMRC<cr>", "Edit in horizontal split" },
		v = { ":vsplit $MYVIMRC<cr>", "Edit in vertical split" },
		t = { ":tabnew $MYVIMRC<cr>", "Edit in new tab" },
	},
}, { prefix = "<leader>" })

-- Search for selected term
set("v", "//", 'y/<c-r>"<cr>', "Search for selection")

-- Set spell checker
wk.register({
	l = {
		name = "Spell checker",
		e = { ":set spell spelllang=en_us<cr>", "Language EN_US" },
		d = { ":set spell spelllang=de_de<cr>", "Language DE_DE" },
		g = { ":set spell spelllang=de_de<cr>", "Language DE_DE" },
		o = { ":set nospell<cr>", "Disable" },
	},
}, { prefix = "<leader>" })

-- # Basics
-- Use semicolon and colon
set("n", ";", ":", "Switch to command mode")

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
set("n", "<leader>sq", ":nohlsearch<cr>", "Disable search highlighting")

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
		t = { ":TestNearest<CR>", "Nearest" },
		f = { ":TestFile<CR>", "File" },
		s = { ":TestSuite<CR>", "Suite" },
		l = { ":TestLast<CR>", "Last" },
		v = { ":TestVisit<CR>", "Visit" },
	},
}, { prefix = "<leader>" })

-- Access via fzf
wk.register({
	a = {
		name = "Access (fzf)",
		f = { ":lua require('fzf-lua').files()<cr>", "Files" },
		b = { ":lua require('fzf-lua').buffers()<cr>", "Buffers" },
		q = { ":lua require('fzf-lua').quickfix()<cr>", "Quickfix" },
		l = { ":lua require('fzf-lua').oldfiles()<cr>", "Last files" },
		m = { ":lua require('fzf-lua').man_pages()<cr>", "Man pages" },
		g = { ":lua require('fzf-lua').grep()<cr>", "Grep" },
	},
}, { prefix = "<leader>" })

-- Terminal
wk.register({
	e = {
		name = "Terminal",
		f = { ":ToggleTerm direction=float<cr>", "Float" },
		h = { ":ToggleTerm size=20 direction=horizontal<cr>", "Horizontal" },
		v = { ":ToggleTerm size=50 direction=vertical<cr>", "Vertical" },
		e = { ":ToggleTermSendCurrentLine<cr>", "Execute" },
	},
}, { prefix = "<leader>" })

wk.register({
	t = {
		name = "Terminal",
		e = { ":ToggleTermSendVisualSelection<cr>", "Execute" },
	},
}, { prefix = "<leader>", mode = "v" })

set("t", "<esc>", [[<C-\><C-n>]], "Exit terminal mode")
set("t", "jk", [[<C-\><C-n>]], "Exit terminal mode")

-- Sessions
wk.register({
	S = {
		name = "Session",
		s = { ":Obsession<cr>", "Store" },
		d = { ":Obsession!<cr>", "Delete" },
	},
}, { prefix = "<leader>" })
set("n", "QQ", "<cmd> qa<cr>", "Quit all")
set({ "n", "i", "v" }, "<C-q>", "<cmd> q<cr>", "Close buffer")
set("n", "XX", "<cmd> bd<cr>", "Remove buffer")

-- Undotree
set("n", "U", ":UndotreeToggle<cr>", "Undo tree")

-- LSP
wk.register({
	d = {
		name = "Errors",
		f = { vim.diagnostic.open_float, "Float" },
		l = { vim.diagnostic.setloclist, "Loclist" },
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

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		-- Enable completion triggered by <c-x><c-o>
		vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

		-- Buffer local mappings.
		-- See `:help vim.lsp.*` for documentation on any of the below functions
		local opts = { buffer = ev.buf }
		set("n", "gD", vim.lsp.buf.declaration, opts)
		set("n", "gd", vim.lsp.buf.definition, opts)
		set("n", "K", vim.lsp.buf.hover, opts)
		set("n", "gi", vim.lsp.buf.implementation, opts)
		set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
		set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, opts)
		set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, opts)
		set("n", "<space>wl", function()
			print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		end, opts)
		set("n", "<space>D", vim.lsp.buf.type_definition, opts)
		set("n", "<space>rn", vim.lsp.buf.rename, opts)
		set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, opts)
		set("n", "gr", vim.lsp.buf.references, opts)
		set("n", "<space>f", function()
			vim.lsp.buf.format({ async = true })
		end, opts)
	end,
})

-- Symbols
set("n", "S", ":SymbolsOutline<cr>", "Show symbols")

-- Hop
set("n", "gt", ":HopWord<cr>", "Jump to word")

-- Yanky
local yanky = require("yanky")
set({ "n", "x" }, "p", "<Plug>(YankyPutAfter)", "Paste after")
set({ "n", "x" }, "P", "<Plug>(YankyPutBefore)", "Paste before")
set({ "n", "x" }, "gp", "<Plug>(YankyGPutAfter)", "Paste after & move cursor")
set({ "n", "x" }, "gP", "<Plug>(YankyGPutBefore)", "Paste before & move cursor")
set("n", "<c-n>", "<Plug>(YankyCycleForward)", "Cycle forward")
set("n", "<c-p>", "<Plug>(YankyCycleBackward)", "Cycle backward")
