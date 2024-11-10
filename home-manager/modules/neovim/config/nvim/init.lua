-- [[ globals ]]
-- NOTE: load before anything else
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.patched_font = require("custom.fonts").check_patched_font()

-- [[ user configuration ]]
require("config.autocmds")
require("config.options")
require("config.keymaps")

-- [[ plugin manager `lazy.nvim` installation ]]
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
	local repo = "https://github.com/folke/lazy.nvim.git"
	vim.fn.system({ "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath })
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require("config.lazy")
local lazy_plugins_dir = {{ import = "plugins" }}

require("lazy").setup(lazy_plugins_dir, lazy_config)
require("custom.theme-picker").setup()
