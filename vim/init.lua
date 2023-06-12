-- nvim-tree requires these commands
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("options")
require("lazy_install")
require("lazy").setup("plugins", nil)
require("plugin_config")
require("mappings")

-- TODO
-- * Per project test and code runner
--   * Create new Build, Run, Test, & Debug commands that can be defined per project
--   * Build & Run command can use toggleterm
--   * Debug should trigger DAP
--   * Test should trigger neotests
--   * Set per project settings using exrc
-- * neotests
-- * Replace trouble.nvim with https://github.com/kevinhwang91/nvim-bqf
