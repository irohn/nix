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

-- Toggle netrw if enabled
local function is_netrw_enabled()
    return vim.g.loaded_netrw ~= 1 and vim.g.loaded_netrwPlugin ~= 1
end
if is_netrw_enabled() then
  map("n", "<leader>e", function()
    if vim.bo.filetype == "netrw" then
      vim.cmd("Rex")
    else
      vim.cmd("Ex")
    end
  end, { desc = "Toggle file explorer" })
end

-- Exit terminal mode in the builtin terminal
map("t", "<esc><esc>", "<c-\\><c-n>", { desc = "Exit terminal mode" })
map("t", "<C-w>", "<C-\\><C-o><C-w>", { desc = "Enter C-w mode in terminal" })
map("t", "::", "<C-\\><C-n>:", { desc = "Enter command mode from terminal mode" })

-- Buffers control
map("n", "<s-h>", "<cmd>bp<cr>", { desc = "Previous buffer" })
map("n", "<s-l>", "<cmd>bn<cr>", { desc = "Next buffer" })
map("n", "<s-x>", "<cmd>bd<cr>", { desc = "Delete buffer" })

-- Move between splits
map({"n", "t"}, "<c-h>", "<c-\\><c-n><c-w><left>")
map({"n", "t"}, "<c-j>", "<c-\\><c-n><c-w><down>")
map({"n", "t"}, "<c-k>", "<c-\\><c-n><c-w><up>")
map({"n", "t"}, "<c-l>", "<c-\\><c-n><c-w><right>")

-- Stay in visual mode when indenting/dedenting
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Better movement in wrapped lines
map("n", "j", "gj")
map("n", "k", "gk")

