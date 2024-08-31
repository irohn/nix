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
opt.list = true
opt.listchars = { trail = '·'}

-- Show which line your cursor is on
opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
opt.scrolloff = 10

-- Enable break indent
opt.breakindent = true

-- Save undo history
opt.undofile = true

-- Disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Enable 24-bit colour
opt.termguicolors = true

-- show only 1 status line
opt.laststatus = 3
