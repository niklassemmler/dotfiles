local globals = vim.g
globals.mapleader = ' '
globals.email = "niklas.semmler@mailbox.org"
globals.username = "Niklas Semmler"

local options = vim.o
options.clipboard = "unnamed"
options.cmdheight = 2

-- old
options.number = true
options.wrap = true
options.linebreak = true

-- Tabulators
options.tabstop = 2
options.shiftwidth = 2
options.expandtab = true
options.shiftround = true

-- Set splits to below and bottom.
options.splitbelow = true
options.splitright = true

-- Ignore some files for wildcard operations
options.wildignore = "*.swp,*.bak,*.pyc,*.class,*.aux,*.pdf,*.bbl,*.blg"

-- Search options
options.ignorecase = true
options.smartcase = true
options.showmatch = true  -- highlight parenthesis

-- Show tabs
options.encoding = "utf-8"
vim.opt.listchars["tab"] = "»»"
vim.opt.listchars["trail"] = "··"
vim.opt.listchars["nbsp"] = "nbsp"
options.list = true

-- Undofile
vim.opt.undofile = true 
