local function map(mode, lhs, rhs, opts)
    local options = { noremap = true, silent = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.keymap.set(mode, lhs, rhs, options)
end

-- Clear highlights on search when pressing <Esc> in normal mode
map("n", "<esc>", "<cmd>noh<cr><esc>", { desc = "Clear highlights" })

-- Enter command mode pressing `;`
map("n", ";", ":", { desc = "CMD enter command mode" })

-- Diagnostic keymaps
map("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- Exit terminal mode in the builtin terminal
map("t", "<esc><esc>", "<c-\\><c-n>", { desc = "Exit terminal mode" })
map("t", "<C-w>", "<C-\\><C-o><C-w>", { desc = "Enter C-w mode in terminal" })
map("t", "::", "<C-\\><C-n>:", { desc = "Enter command mode from terminal mode" })

-- Buffers control
map("n", "<s-h>", "<cmd>bp<cr>", { desc = "Previous buffer" })
map("n", "<s-l>", "<cmd>bn<cr>", { desc = "Next buffer" })
map("n", "<s-x>", "<cmd>bd<cr>", { desc = "Delete buffer" })

-- Move between splits
map("n", "<c-h>", "<c-w><left>")
map("n", "<c-j>", "<c-w><down>")
map("n", "<c-k>", "<c-w><up>")
map("n", "<c-l>", "<c-w><right>")

-- Stay in visual mode when indenting/dedenting
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Better movement in wrapped lines
map("n", "j", "gj")
map("n", "k", "gk")

