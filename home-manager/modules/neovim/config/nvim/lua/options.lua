local opt = vim.opt

-- Default tab behavior (overwritten in ftplugin)
local tab_len = 4
opt.tabstop = tab_len
opt.softtabstop = tab_len
opt.shiftwidth = tab_len
opt.expandtab = true

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
opt.listchars = { tab = "  ", trail = "·", nbsp = "␣" }

-- Remove end of buffer `~` symbols
opt.fillchars = { eob = " " }

-- Highlight cursor line
opt.cursorline = true
opt.cursorlineopt = "both"

-- Minimal number of screen lines to keep above and below the cursor.
opt.scrolloff = 6

-- Enable break indent
opt.breakindent = true

-- Save undo history
opt.undofile = true

-- Enable 24-bit colour
opt.termguicolors = true

-- Make statusline global
opt.laststatus = 3

-- Allow going past end of lines in visual block mode
opt.virtualedit = "block"

