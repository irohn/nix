local undotree_config = function()
  vim.cmd[[
  let g:undotree_WindowLayout = 2
  let g:undotree_SetFocusWhenToggle = 1
]]
  vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle,
    { silent = true, noremap = true, desc = "undo tree" })
end

local M = {
  {
    "mbbill/undotree",
    config = undotree_config,
  },
}

return M
