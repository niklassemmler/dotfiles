-- A list of vim mappings
-- These should be independent of plugins
local wk = require("which-key")
local set = function(mode, mapping, cmd, desc)
	vim.keymap.set(mode, mapping, cmd, { desc = desc })
end
local fzflua = require("fzf-lua")

-- Buffers
wk.add({
	{ "<leader>b", group = "Buffers" },
	{ "<leader>bD", "<cmd>BDelete hidden<cr>", desc = "Delete hidden buffers" },
	{ "<leader>bc", fzflua.buffers, desc = "Choose (fzf)" },
	{ "<leader>bd", "<cmd>BDelete this<cr>", desc = "Delete current buffer" },
	{ "<leader>bn", "<cmd>bn<cr>", desc = "Next buffer" },
	{ "<leader>be", fzflua.files, desc = "Edit file in buffer (fzf)" },
	{ "<leader>bo", ":b ", desc = "Open buffer" },
	{ "<leader>bp", "<cmd>bp<cr>", desc = "Previous buffer" },
	{ "<leader>bs", "<cmd>sb<cr>", desc = "Open buffer horizontally" },
	{ "<leader>bv", "<cmd>vert sb<cr>", desc = "Open buffer vertically" },
})

set("n", "<Tab>", "<cmd>bn<cr>", "Next buffer")
set("n", "<S-Tab>", "<cmd>bp<cr>", "Previous buffer")

-- Tabs
wk.add({
	{ "<leader>t", group = "Tabs" },
	{ "<leader>tc", fzflua.tabs, desc = "Choose (fzf)" },
	{ "<leader>tn", "<cmd>tabn<cr>", desc = "Tab next" },
	{ "<leader>to", "<cmd>tabnew<cr>", desc = "Tab new" },
	{ "<leader>tp", "<cmd>tabp<cr>", desc = "Tab previous" },
	{ "<leader>tq", "<cmd>tabclose<cr>", desc = "Tab close" },
	{ "<leader>ts", "<cmd>tab split<cr>", desc = "Tab split" },
})
set("n", "J", "<cmd>tabn<cr>", "Next tab")
set("n", "K", "<cmd>tabp<cr>", "Previous tab")

-- Files
wk.add({
	{ "<leader>f", group = "Files" },
	{ "<leader>fc", fzflua.files, desc = "Choose (FzF)" },
	{ "<leader>fe", "<cmd>e ", desc = "File edit" },
	{ "<leader>ff", "w !sudo tee % >/dev/null", desc = "sudo write" },
	{ "<leader>fh", Open_tree_here, desc = "Toggle finder here" },
	{ "<leader>fq", "<cmd>q<cr>", desc = "File quit" },
	{ "<leader>fs", "<cmd>w<cr>", desc = "File write" },
	{ "<leader>ft", Open_tree, desc = "Toggle finder" },
	{ "<leader>fw", "<cmd>w<cr>", desc = "File write" },
})
set({ "n", "v", "i" }, "<C-s>", "<cmd>w<cr>", "Save")
set("n", "F", Open_tree, "Directory")

-- Splits
wk.add({
	{ "<leader>s", group = "Splits" },
	{ "<leader>sh", ":split ", desc = "Split horizontally" },
	{ "<leader>sv", ":vsplit ", desc = "Split vertically" },
})
set("", "<C-h>", "<cmd>wincmd h<CR>", "Move to left split")
set("", "<C-j>", "<cmd>wincmd j<CR>", "Move to bottom split")
set("", "<C-k>", "<cmd>wincmd k<CR>", "Move to top split")
set("", "<C-l>", "<cmd>wincmd l<CR>", "Move to right split")
set("", "<C-+>", "<cmd>wincmd resize 10<CR>", "Move to right split")
set("", "<C-->", "<cmd>wincmd resize -10<CR>", "Move to right split")

-- Load config
vim.g.VIMRC = "~/.config/nvim/"
wk.add({
	{ "<leader>l", group = "Edit Config" },
	{ "<leader>lc", "<cmd>e " .. VIMUSERDIR .. "lua/plugin_config.lua<cr>", desc = "Plugin config" },
	{ "<leader>li", "<cmd>e " .. VIMUSERDIR .. "init.lua<cr>", desc = "Init.lua" },
	{ "<leader>lm", "<cmd>e " .. VIMUSERDIR .. "lua/mappings.lua<cr>", desc = "Key mappings" },
	{ "<leader>lp", "<cmd>e " .. VIMUSERDIR .. "lua/plugins.lua<cr>", desc = "Plugins" },
})

-- Search for selected term
set("v", "//", 'y/<c-r>"<cr>', "Search for selection")

-- Set spell checker
wk.add({
	{ "<leader>L", group = "Spell checker" },
	{ "<leader>Ld", "<cmd>set spell spelllang=de_de<cr>", desc = "Language DE_DE" },
	{ "<leader>Le", "<cmd>set spell spelllang=en_us<cr>", desc = "Language EN_US" },
	{ "<leader>Lg", "<cmd>set spell spelllang=de_de<cr>", desc = "Language DE_DE" },
	{ "<leader>Lo", "<cmd>set nospell<cr>", desc = "Disable" },
})

-- # Basics
-- Use semicolon and colon
set("n", ";", "<cmd>", "Switch to command mode")

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
set("n", "<leader>sq", "<cmd>nohlsearch<cr>", "Disable search highlighting")

-- gv highlights last selected text
-- gV now highlights last entered text
set("v", "gV", "`[v`]", "Highlight last entered text")

-- Copy to system register
set({ "n", "v" }, "<leader>y", '"+y', "Copy to system register")

-- Paste from system register
set("n", "<leader>v", '"+p', "Paste from system register")

-- Testing (vim-test not installed; wire up neotest when configured)
-- wk.add({
-- 	{ "<leader>T", group = "Testing" },
-- 	{ "<leader>Tf", "<cmd>TestFile<CR>", desc = "File" },
-- 	{ "<leader>Tl", "<cmd>TestLast<CR>", desc = "Last" },
-- 	{ "<leader>Ts", "<cmd>TestSuite<CR>", desc = "Suite" },
-- 	{ "<leader>Tt", "<cmd>TestNearest<CR>", desc = "Nearest" },
-- 	{ "<leader>Tv", "<cmd>TestVisit<CR>", desc = "Visit" },
-- })

-- Access via fzf
wk.add({
	{ "<leader>a", group = "Access (fzf)" },
	{ "<leader>ag", fzflua.grep_visual, desc = "Grep", mode = "v" },
	{ "<leader>aG", fzflua.grep_cword, desc = "Grep word under cursor" },
	{ "<leader>ab", fzflua.buffers, desc = "Buffers" },
	{ "<leader>af", fzflua.files, desc = "Files" },
	{ "<leader>ag", fzflua.grep, desc = "Grep" },
	{ "<leader>al", fzflua.grep_last, desc = "Man pages" },
	{ "<leader>ao", fzflua.oldfiles, desc = "Last files" },
	{ "<leader>aq", fzflua.quickfix, desc = "Quickfix" },
	{ "<leader>as", fzflua.lsp_document_symbols, desc = "Grep" },
})

set("n", "<F36>", "<cmd>FzfLua lsp_document_symbols<cr>", "Browse symbols")
set("n", "<C-F12>", "<cmd>FzfLua lsp_document_symbols<cr>", "Browse symbols")

-- Terminal
wk.add({
	{ "<leader>e", group = "Terminal" },
	{ "<leader>ee", "<cmd>ToggleTermSendCurrentLine<cr>", desc = "Execute" },
	{ "<leader>ef", "<cmd>ToggleTerm direction=float<cr>", desc = "Float" },
	{ "<leader>eh", "<cmd>ToggleTerm size=20 direction=horizontal<cr>", desc = "Horizontal" },
	{ "<leader>es", "<cmd>ToggleTermSendVisualSelection<cr>", desc = "Execute", mode = "v" },
	{ "<leader>ev", "<cmd>ToggleTerm size=50 direction=vertical<cr>", desc = "Vertical" },
})

set("t", "jk", [[<C-\><C-n>]], "Exit terminal mode")

-- Sessions (session_manager plugin disabled)
-- wk.add({
-- 	{ "<leader>S", group = "Session" },
-- 	{ "<leader>Sc", "<cmd>SessionManager load_current_dir_session<cr>", desc = "Load current dir" },
-- 	{ "<leader>Sd", "<cmd>SessionManager delete_session<cr>", desc = "Delete" },
-- 	{ "<leader>Sl", "<cmd>SessionManager load_session<cr>", desc = "Load" },
-- 	{ "<leader>Ss", "<cmd>SessionManager save_current_session`<cr>", desc = "Store" },
-- })
set("n", "QQ", "<cmd>qa<cr>", "Quit all")
set({ "n", "i", "v" }, "<C-q>", "<cmd>q<cr>", "Close buffer")
set("n", "XX", "<cmd>BDelete this<cr>", "Remove buffer")

-- Errors
set("n", "T", "<cmd>Trouble diagnostics toggle focus=false filter.buf=0<cr>", "Errors & warnings (this file)")
-- this overrides tags, but I haven't used them so far
set("n", "<C-T>", "<cmd>Trouble diagnostics toggle focus=true filter.buf=0<cr>", "Errors & warnings")

-- Undotree
set("n", "<leader>U", "<cmd>UndotreeToggle<cr>", "Undo tree")

-- LSP
wk.add({
	{ "<leader>d", group = "Errors" },
	{ "<leader>df", vim.diagnostic.open_float, desc = "Float" },
	{ "<leader>dl", vim.diagnostic.setloclist, desc = "Loclist" },
	{ "<leader>dt", "<cmd>TroubleToggle<cr>", desc = "Trouble" },
})
set("n", "<S-Up>", vim.diagnostic.goto_prev, "Previous issue")
set("n", "<S-Down>", vim.diagnostic.goto_next, "Next issue")

-- Debug
local open_sidebar = function()
	local widgets = require("dap.ui.widgets")
	local sidebar = widgets.sidebar(widgets.scopes)
	sidebar.open()
end
local dap = require("dap")
local dapui = require("dapui")
wk.add({
	{ "<leader>D", group = "Debug" },
	{ "<leader>DU", dapui.toggle, desc = "Toggle UI" },
	{
		"<leader>DE",
		function()
			dapui.eval(vim.fn.input("[Expression] > "))
		end,
		desc = "Evaluate Input",
	},
	{ "<leader>De", dapui.eval, desc = "Evaluate" },
	{
		"<leader>DC",
		function()
			dap.set_breakpoint(vim.fn.input("[Condition] > "))
		end,
		desc = "Conditional Breakpoint",
	},
	{ "<leader>Db", dap.toggle_breakpoint, desc = "Toggle Breakpoint" },
	{ "<leader>Dc", dap.continue, desc = "Continue" },
	{ "<leader>Dr", dap.repl.toggle, desc = "Toggle Repl" },
	{ "<leader>Dm", group = "Debug manage session" },
	{ "<leader>Dmd", dap.disconnect, desc = "Disconnect" },
	{ "<leader>Dmx", dap.terminate, desc = "Terminate" },
	{ "<leader>Dmp", dap.pause, desc = "Pause" },
	{ "<leader>Dmq", dap.close, desc = "Quit" },
	{ "<leader>Dms", dap.session, desc = "Get Session" },
	{ "<leader>Dml", dap.run_last, desc = "Run last" },
	{ "<leader>Dmr", dap.run_to_cursor, desc = "Run to Cursor" },
	{ "<leader>Ds", group = "Debug step" },
	{ "<leader>Dsi", dap.step_into, desc = "Step Into" },
	{ "<leader>Dso", dap.step_over, desc = "Step Over" },
	{ "<leader>Dsb", dap.step_back, desc = "Step Back" },
	{ "<leader>Dsu", dap.step_out, desc = "Step Out" },
	{ "<leader>Dl", function() require("dap-go").debug_last() end, desc = "Debug last" },
	{ "<leader>Dt", function() require("dap-go").debug_test() end, desc = "Debug test" },
	-- { "<leader>Dh", dapui.widgets.hover, desc="Hover Variables"}
	-- { "<leader>DS", dapui.widgets.scopes, desc="Scopes"}
})

--  External commands
wk.add({
	{ "<leader>G", group = "Git" },
	{ "<leader>Gb", "<cmd>Git blame<cr>", desc = "blame" },
	{ "<leader>Gc", "<cmd>Git commit<cr>", desc = "commit" },
	{ "<leader>Gd", "<cmd>Git diff<cr>", desc = "diff" },
	{ "<leader>Gl", "<cmd>Git log<cr>", desc = "log" },
	{ "<leader>Go", "<cmd>Git<cr>", desc = "overview" },
	{ "<leader>Gs", "<cmd>Gdiffsplit<cr>", desc = "horizontals plit" },
	{ "<leader>Gv", "<cmd>Gvdiffsplit<cr>", desc = "vertical split" },
})

--  External commands
wk.add({
	{ "<leader>C", group = "Tools" },
	{ "<leader>Cg", "<cmd>LazyGit<cr>", desc = "Lazy Git" },
})

-- Conflicts
wk.add({
	{ "<leader>i", group = "Conflict" },
	{ "<leader>ic", "<cmd>Conflict current<cr>", desc = "keep current" },
	{ "<leader>ii", "<cmd>Conflict incoming<cr>", desc = "keep incoming" },
	{ "<leader>ib", "<cmd>Conflict both<cr>", desc = "keep both" },
	{ "<leader>ia", "<cmd>Conflict base<cr>", desc = "keep base" },
	{ "<leader>in", "<cmd>Conflict none<cr>", desc = "keep none" },
	{ "<leader>i]", "<cmd>Conflict next<cr>", desc = "next conflict" },
	{ "<leader>i[", "<cmd>Conflict prev<cr>", desc = "prev conflict" },
	{ "<leader>il", "<cmd>Conflict list<cr>", desc = "list files" },
	{ "<leader>iq", "<cmd>Conflict qflist<cr>", desc = "quickfix list" },
	{ "<leader>ir", "<cmd>Conflict refresh<cr>", desc = "refresh" },
})

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

		-- TODO: Requires section names
		-- Go tos
		wk.add({
			{ "<leader>g", group = "Goto" },
			{ "<leader>gD", fzflua.lsp_declarations, desc = "declaration" },
			{ "<leader>gd", "<cmd>Glance definitions<cr>", desc = "definition" },
			{ "<leader>gi", "<cmd>Glance implementations<cr>", desc = "implementation" },
			{ "<leader>gI", fzflua.lsp_incoming_calls, desc = "Go to incoming calls" },
			{ "<leader>gO", fzflua.lsp_outgoing_calls, desc = "Go to outgoing calls" },
			{ "<leader>gt", "<cmd>Glance type_definitions<cr>", desc = "Go to type definition" },
			{ "<leader>gr", "<cmd>Glance references<cr>", desc = "Show references" },
			{ "<leader>gs", vim.lsp.buf.document_symbol, desc = "Show symbols" },
			{ "<leader>gW", fzflua.lsp_workspace_symbols, desc = "Workspace symbols" },
		})

		-- Workspace
		wk.add({
			{ "<leader>w", group = "Workspace" },
			{ "<leader>wa", vim.lsp.buf.add_workspace_folder, desc = "add workspace folder" },
			{ "<leader>wr", vim.lsp.buf.remove_workspace_folder, desc = "remove workspace folder" },
			{
				"<leader>wl",
				function()
					print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
				end,
				desc = "list workspace folders",
			},
		})

		-- in-place info
		setHere("n", "K", vim.lsp.buf.hover, "Hover")
		setHere("n", "<C-K>", vim.lsp.buf.signature_help, "Signature help")

		-- Refactor actions
		wk.add({
			{ "<leader>r", group = "Refactor" },
			{ "<leader>rn", vim.lsp.buf.rename, desc = "Rename" },
			{ "<leader>ra", vim.lsp.buf.code_action, desc = "Code action" },
			{
				"<leader>rf",
				function()
					vim.lsp.buf.format({ async = true })
				end,
				desc = "Format",
			},
		})
	end,
})
local refactoring = require("refactoring")
wk.add({
	{ "<leader>r", group = "Refactor" },
	{ "<leader>rn", vim.lsp.buf.rename, desc = "Rename" },
	{ "<leader>ra", vim.lsp.buf.code_action, desc = "Code action" },
	{
		"<leader>rf",
		function()
			vim.lsp.buf.format({ async = true })
		end,
		desc = "Format",
	},
	{
		"<leader>re",
		function()
			refactoring.refactor("Extract Variable")
		end,
		desc = "Extract variable",
	},
	{
		"<leader>rE",
		function()
			refactoring.refactor("Extract Function")
		end,
		desc = "Extract function",
	},
	{
		"<leader>rb",
		function()
			refactoring.refactor("Extract Block")
		end,
		desc = "Extract block",
	},
	{
		"<leader>ri",
		function()
			refactoring.refactor("Inline Variable")
		end,
		desc = "Inline variable",
	},
	{
		"<leader>rI",
		function()
			refactoring.refactor("Inline Function")
		end,
		desc = "Inline function",
	},
	{
		"<leader>rs",
		function()
			refactoring.select_refactor()
		end,
		desc = "Select action",
	},
	{
		"<leader>rf",
		function()
			vim.lsp.buf.format({ async = true })
		end,
		desc = "Format",
	},
})

-- Claude Code
wk.add({
	{ "<leader>c", group = "AI/Claude Code" },
	{ "<leader>cc", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude" },
	{ "<leader>cf", "<cmd>ClaudeCodeFocus<cr>", desc = "Focus Claude" },
	{ "<leader>cr", "<cmd>ClaudeCode --resume<cr>", desc = "Resume Claude" },
	{ "<leader>cC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },
	{ "<leader>cm", "<cmd>ClaudeCodeSelectModel<cr>", desc = "Select Claude model" },
	{ "<leader>cb", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add current buffer" },
	{ "<leader>cs", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send to Claude" },
	{ "<leader>ca", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
	{ "<leader>cd", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny diff" },
})
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
	callback = function()
		vim.keymap.set(
			"n",
			"<leader>gS",
			"<cmd>LspTypescriptGoToSourceDefinition<cr>",
			{ buffer = true, desc = "Go to source definition (TS)" }
		)
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "NvimTree", "neo-tree", "oil", "minifiles", "netrw" },
	callback = function()
		vim.keymap.set("n", "<leader>cs", "<cmd>ClaudeCodeTreeAdd<cr>", { buffer = true, desc = "Add file" })
	end,
})

-- Symbols
set("n", "S", "<cmd>Outline<cr>", "Show symbols")

-- Yanky
require("yanky")
set({ "n", "x" }, "p", "<Plug>(YankyPutAfter)", "Paste after")
set({ "n", "x" }, "P", "<Plug>(YankyPutBefore)", "Paste before")
set({ "n", "x" }, "gp", "<Plug>(YankyGPutAfter)", "Paste after & move cursor")
set({ "n", "x" }, "gP", "<Plug>(YankyGPutBefore)", "Paste before & move cursor")
set("n", "<c-n>", "<Plug>(YankyCycleForward)", "Cycle forward")
set("n", "<c-p>", "<Plug>(YankyCycleBackward)", "Cycle backward")


-- lua snip
-- local ls = require("luasnip")
-- wk.add({
--  { "<leader>i", group = "Snips" },
--  {
--    "<leader>ic",
--    function()
--      if ls.choice_active() then
--        ls.change_choice(1)
--      end
--    end,
--    desc = "change choice",
--  },
--  { "<leader>ie", ls.expand, desc = "expand" },
--  {
--    "<leader>ii",
--    function()
--      ls.jump(1)
--    end,
--    desc = "jump forward",
--  },
--  {
--    "<leader>il",
--    function()
--      ls.jump(-1)
--    end,
--    desc = "jump backward",
--  },
-- })
