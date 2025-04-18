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
    ensure_installed = { "pyright", "lua_ls", "rust_analyzer" },
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
    ensure_installed = { "black", "isort", "mypy", "goimports", "golines", "stylua", "gofumpt", "google_java_format" },
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
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
                -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
                -- they way you will only jump inside the snippet region
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            elseif has_words_before() then
                cmp.complete()
            else
                fallback()
            end
        end, { "i", "s" }),

        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { "i", "s" }),
    }),
    sources = cmp.config.sources({
        { name = "copilot" },
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
            symbol_map = { Copilot = "" },

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
lspconfig.html.setup({
    capabilities = capabilities,
})
lspconfig.tailwindcss.setup({
    capabilities = capabilities,
})
lspconfig.pyright.setup({
    capabilities = capabilities,
})
lspconfig.jsonnet_language_server.setup({
    capabilities = capabilities,
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
if vim.fn.hostname() ~= "Policy1st" then
    lspconfig.lua_ls.setup({
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
local nhelpers = require("null-ls.helpers")
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
    ensure_installed = { "lua", "python", "go", "rust", "java" },
    auto_install = true,
    sync_install = false,
    highlight = {
        enable = true,
        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = false,
    },
})
require("todo-comments").setup()
require("treesitter-context").setup()

-- git
require("gitsigns").setup()
require("git-conflict").setup()

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

require("hop").setup()

require("yanky").setup()

-- configure the litee.nvim library
require("litee.lib").setup({})
-- configure litee-calltree.nvim
require("litee.calltree").setup()

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

-- copilot
require("copilot").setup({})
require("copilot_cmp").setup()

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

-- enable signs
local signs = { Error = "", Warn = "⚠", Hint = "", Info = "", Information = "" }
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
