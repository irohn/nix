local set = vim.keymap.set

-- Clear highlights on search when pressing <Esc> in normal mode
set("n", "<esc>", "<cmd>noh<cr><esc>", { desc = "Clear highlights" })

-- Enter command mode pressing `;`
set("n", ";", ":", { desc = "CMD enter command mode" })

-- Diagnostic keymaps
set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- Exit terminal mode in the builtin terminal
set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Buffers control
set("n", "<S-h>", "<cmd>bp<CR>", { desc = "Previous buffer" })
set("n", "<S-l>", "<cmd>bn<CR>", { desc = "Next buffer" })
set("n", "<S-x>", "<cmd>bd<CR>", { desc = "Delete buffer" })

-- Move between splits
set("n", "<C-h", "<C-w>h")
set("n", "<C-j", "<C-w>j")
set("n", "<C-k", "<C-w>k")
set("n", "<C-l", "<C-w>l")
set("t", "<C-h", "C-\\><C-n><C-w>h")
set("t", "<C-j", "C-\\><C-n><C-w>j")
set("t", "<C-k", "C-\\><C-n><C-w>k")
set("t", "<C-l", "C-\\><C-n><C-w>l")

-- Stay in visual mode when indenting/dedenting
set("v", "<", "<gv")
set("v", ">", ">gv")

-- Better movement in wrapped lines
set("n", "j", "gj")
set("n", "k", "gk")

