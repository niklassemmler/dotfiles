-- nvim-tree requires these commands
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local utils = require("utils")
VIMUSERDIR = utils.getLinuxDirPath(os.getenv("MYVIMRC"))

require("options")
require("lazy_install")
require("lazy").setup("plugins", nil)
require("plugin_config")
require("mappings")

-- TODO
-- * Use exrc to define code runner, dap, testing
-- * Define cwd in exrc -- override project.nvim
-- * Use neotests to start tests
-- * Replace trouble.nvim with https://github.com/kevinhwang91/nvim-bqf
-- * Set up neovim to develop hammerspoon code
-- * Split plugin config to make it easier to maintain
