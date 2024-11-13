local function map(mode, lhs, rhs, opts)
	local options = { noremap = true, silent = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	vim.keymap.set(mode, lhs, rhs, options)
end

map("n", "<esc>", "<cmd>noh<cr><esc>", {
  desc = "Clear highlights"
})
map("t", "<esc><esc>", "<c-\\><c-n>", {
  desc = "Exit terminal mode"
})

map("n", "<leader>q", vim.diagnostic.setloclist, {
  desc = "diagnostics quicklist"
})

map("v", "<", "<gv", {
  desc = "stay in visual mode on dedent"
})
map("v", ">", ">gv", {
  desc = "stay in visual mode on indent"
})

map({"n", "v"}, "<s-p>", "\"*p", {
  desc = "paste from system clipboard"
})
map({"n", "v"}, "<s-y>", "\"*y", {
  desc = "yank to system clipboard"
})

map("n", "<s-h>", "<cmd>bprev<cr>", { desc = "Next buffer" })
map("n", "<s-l>", "<cmd>bnext<cr>", { desc = "Previous buffer" })

map("n", "<leader>tc", "<cmd>tabnew<cr>", { desc = "Create new tab" })
map("n", "<leader>tp", "<cmd>tabprevious<cr>", { desc = "Previous tab" })
map("n", "<leader>tn", "<cmd>tabnext<cr>", { desc = "Next tab" })
