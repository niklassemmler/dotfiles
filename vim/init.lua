-- nvim-tree requires these commands
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1


require("options")
require("lazy_install")
require("lazy").setup('plugins', nil)
require("plugin_config")
require("mappings")

 -- TODO
 -- * Combine pyright with flake8 and mypy using null-ls
 -- * Set keymappings for LSP operations
 -- * Use debugger for python and go
 -- * Install nvim-autopairs
 -- * Install Java support
 -- * testobjects
