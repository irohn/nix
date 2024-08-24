local opt = vim.opt

-- Preview substitutions live, as you type!
opt.inccommand = "split"

-- Search options
opt.smartcase = true
opt.ignorecase = true

-- Line numbers
opt.number = true
opt.relativenumber = true

-- Splits options
opt.splitbelow = true
opt.splitright = true

-- Keep signcolumn on by default
opt.signcolumn = "yes"

-- Sync clipboard with OS
opt.clipboard = "unnamedplus"

-- Show trailing spaces
vim.opt.list = true
vim.opt.listchars = { trail = '·'}

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Enable 24-bit colour
vim.opt.termguicolors = true

