local tog = require("custom.optoggle").toggle_option

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

map("n", "<s-h>", "<cmd>bprev<cr>", {
  desc = "Next buffer"
})
map("n", "<s-l>", "<cmd>bnext<cr>", {
  desc = "Previous buffer"
})

-- toggles
map("n", "<leader>tn", function()
	tog("number")
	tog("relativenumber")
end, { desc = "Toggle numbers" })

map("n", "<leader>tw", function()
	tog("wrap")
end, { desc = "Toggle word wrap" })

map("n", "<leader>tcc", function()
	tog("cursorcolumn")
end, { desc = "Toggle cursor column" })

map("n", "<leader>tcl", function()
	tog("cursorline")
end, { desc = "Toggle cursor line" })

map("n", "<leader>t|", function()
	tog("colorcolumn", {{80}, {}})
end, { desc = "Toggle colorcolumn (80 characters)" })
