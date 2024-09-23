local opt = vim.opt

-- Set leader keys
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- netrw settings
vim.g.netrw_banner = 0

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
opt.listchars = { tab = '  ', trail = '·', nbsp = '␣'}

opt.fillchars = { eob = " " }

-- Show which line your cursor is on
opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
opt.scrolloff = 10

-- Enable break indent
opt.breakindent = true

-- Save undo history
opt.undofile = true

-- Enable 24-bit colour
opt.termguicolors = true

-- show only 1 status line
opt.laststatus = 3

-- Allow going past end of lines in visual block mode
opt.virtualedit = "block"
