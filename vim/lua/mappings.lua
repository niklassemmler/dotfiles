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
        d = { "<cmd> :BDelete this<cr>", "Delete current buffer" },
        D = { "<cmd> :BDelete hidden<cr>", "Delete hidden buffers" },
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
set("n", "J", "<cmd> tabn<cr>", "Next tab")
set("n", "K", "<cmd> tabp<cr>", "Previous tab")

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
set({ "n", "v", "i" }, "<C-s>", "<cmd> w<cr>", "Save")
set("n", "F", Open_tree, "Directory")

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
        i = { "<cmd> e " .. VIMUSERDIR .. "/init.lua<cr>", "Init.lua" },
        p = { "<cmd> e " .. VIMUSERDIR .. "/lua/plugins.lua<cr>", "Plugins" },
        c = { "<cmd> e " .. VIMUSERDIR .. "/lua/plugin_config.lua<cr>", "Plugin config" },
        m = { "<cmd> e " .. VIMUSERDIR .. "/lua/mappings.lua<cr>", "Key mappings" },
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
        s = { "<cmd> lua require('fzf-lua').document_symbols()<cr>", "Grep" },
    },
}, { prefix = "<leader>" })

set("n", "<F36>", ":FzfLua lsp_document_symbols<cr>", "Browse symbols")


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

set("t", "jk", [[<C-\><C-n>]], "Exit terminal mode")

-- Sessions
wk.register({
    S = {
        name = "Session",
        s = { "<cmd> SessionManager save_current_session`<cr>", "Store" },
        l = { "<cmd> SessionManager load_session<cr>", "Load" },
        c = { "<cmd> SessionManager load_current_dir_session<cr>", "Load current dir" },
        d = { "<cmd> SessionManager delete_session<cr>", "Delete" },
    },
}, { prefix = "<leader>" })
set("n", "QQ", "<cmd> qa<cr>", "Quit all")
set({ "n", "i", "v" }, "<C-q>", "<cmd> q<cr>", "Close buffer")
set("n", "XX", "<cmd> bd<cr>", "Remove buffer")

-- Errors
set("n", "T", ":TroubleToggle document_diagnostics<cr>", "Errors & warnings (this file)")
-- this overrides tags, but I haven't used them so far
set("n", "<C-T>", ":Trouble<cr>", "Errors & warnings")

-- Undotree
-- set("n", "U", "<cmd> UndotreeToggle<cr>", "Undo tree")

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
local dap = require("dap")
local dapui = require("dapui")
wk.register({
    D = {
        name = "Debug",
        R = { dap.run_to_cursor, "Run to Cursor" },
        E = {
            function()
                dapui.eval(vim.fn.input("[Expression] > "))
            end,
            "Evaluate Input",
        },
        C = {
            function()
                dap.set_breakpoint(vim.fn.input("[Condition] > "))
            end,
            "Conditional Breakpoint",
        },
        U = { dapui.toggle, "Toggle UI" },
        b = { dap.step_back, "Step Back" },
        c = { dap.continue, "Continue" },
        d = { dap.disconnect, "Disconnect" },
        e = { dapui.eval, "Evaluate" },
        g = { dap.session, "Get Session" },
        -- h = { dapui.widgets.hover, "Hover Variables" },
        -- S = { dapui.widgets.scopes, "Scopes" },
        i = { dap.step_into, "Step Into" },
        o = { dap.step_over, "Step Over" },
        p = { dap.pause, "Pause" },
        q = { dap.close, "Quit" },
        r = { dap.repl.toggle, "Toggle Repl" },
        s = { dap.continue, "Start" },
        t = { dap.toggle_breakpoint, "Toggle Breakpoint" },
        x = { dap.terminate, "Terminate" },
        u = { dap.step_out, "Step Out" },
        -- l = { require("dap-go").debug_last, "Debug last" },
        -- t = { require("dap-go").debug_test, "Debug test" },
    },
}, { prefix = "<leader>" })

--  External commands
wk.register({
    G = {
        name = "Git",
        c = { ":Git commit<cr>", "commit" },
        d = { ":Git diff<cr>", "diff" },
        l = { ":Git log<cr>", "log" },
        b = { ":Git blame<cr>", "blame" },
        o = { ":Git<cr>", "overview" },
        s = { ":Gdiffsplit<cr>", "horizontals plit" },
        v = { ":Gvdiffsplit<cr>", "vertical split" },
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

        -- TODO: Requires section names
        -- Go tos
        wk.register({
            g = {
                name = "Goto",
                D = { vim.lsp.buf.declaration, "declaration" },
                d = { "<cmd> Glance definitions<cr>", "definition" },
                i = { "<cmd> Glance implementations<cr", "implementation" },
                I = { vim.lsp.buf.incoming_calls, "Go to incoming calls" },
                O = { vim.lsp.buf.outgoing_calls, "Go to outgoing calls" },
                t = { "<cmd> Glance type_definition<cr>", "Go to type definition" },
                r = { "<cmd> Glance references<cr>", "Show references" },
                s = { vim.lsp.buf.document_symbol, "Show symbols" },
            },
        }, { prefix = "<leader>" })

        -- Workspace
        wk.register({
            w = {
                name = "Workspace",
                a = { vim.lsp.buf.add_workspace_folder, "add workspace folder" },
                r = { vim.lsp.buf.remove_workspace_folder, "remove workspace folder" },
                l = { function()
                    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                end, "list workspace folders" },
            },
        }, { prefix = "<leader>" })

        -- in-place info
        setHere("n", "K", vim.lsp.buf.hover, "Hover")
        setHere("n", "<C-K>", vim.lsp.buf.signature_help, "Signature help")

        -- Refactor actions
        --
        wk.register({
            r = {
                name = "Refactor",
                n = { vim.lsp.buf.rename, "Rename" },
                a = { vim.lsp.buf.code_action, "Code action" },
                f = { function() vim.lsp.buf.format({ async = true }) end, "Format" }
            },
        }, { prefix = "<leader>" })
    end
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

-- cmp
local cmp = require("cmp")
cmp.setup({
    mapping = {
        -- Shift+TAB to go to the Previous Suggested item
        ["<S-Tab>"] = cmp.mapping.select_prev_item(),
        -- Tab to go to the next suggestion
        ["<Tab>"] = cmp.mapping.select_next_item(),
        -- CTRL+SHIFT+f to scroll backwards in description
        ["<C-S-f>"] = cmp.mapping.scroll_docs(-4),
        -- CTRL+F to scroll forwards in the description
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        -- CTRL+SPACE to bring up completion at current Cursor location
        ["<C-Space>"] = cmp.mapping.complete(),
        -- CTRL+e to exit suggestion and close it
        ["<C-e>"] = cmp.mapping.close(),
        -- CR (enter or return) to CONFIRM the currently selection suggestion
        -- We set the ConfirmBehavior to insert the Selected suggestion
        ["<CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Insert,
            select = true,
        }),
    },
})
