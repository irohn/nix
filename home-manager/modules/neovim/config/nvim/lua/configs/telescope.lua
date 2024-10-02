local builtin = require("telescope.builtin")
local utils = require("telescope.utils")

vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
vim.keymap.set("n", "<leader>fd", function() builtin.find_files({ cwd = utils.buffer_dir() }) end, {})
vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})

vim.keymap.set("n", "<leader>fb", function()
  builtin.buffers({
    sort_mru = true,
    initial_mode = "normal",
  })
end, {})

vim.keymap.set("n", "<leader>/", function()
  builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
    winblend = 4,
    previewer = false,
    borderchars = borders,
  }))
end, { desc = "[/] Fuzzily find in current buffer" })
