local harpoon_config = function()
  local harpoon = require("harpoon")

  harpoon:setup()

  vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
  vim.keymap.set("n", "<leader>l", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

  for i = 1,5 do
    vim.keymap.set("n", "<leader>" .. i, function() harpoon:list():select(i) end)
  end
end

local M = {
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = harpoon_config,
  },
}

return M
