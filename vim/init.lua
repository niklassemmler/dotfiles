-- nvim-tree requires these commands
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("options")
require("lazy_install")
require("lazy").setup("plugins", nil)
require("plugin_config")
require("mappings")

-- TODO
-- * Java support
-- * Go support
-- * Python support
-- * better bookmarks
--* neotests
