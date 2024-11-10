local data_path = vim.fn.stdpath("data")
local patched_font_path = data_path .. "/user/patched_font.lua"

local M = {}

M.check_patched_font = function()
  -- Check if the file exists before attempting to load
  local file_exists = vim.fn.filereadable(patched_font_path) == 1

  if not file_exists then
    return nil  -- File does not exist, return nil to trigger fallback
  end

  -- Attempt to load the Lua file safely
  local ok, result = pcall(dofile, patched_font_path)

  -- Return the result if loading was successful and the result is boolean
  if ok and (result == true or result == false) then
    return result
  else
    return nil  -- Loading failed or didn't return a valid boolean, fallback to default
  end
end

M.set_patched_font = function(value)
  -- Ensure the directory exists
  vim.fn.mkdir(vim.fn.fnamemodify(patched_font_path, ":h"), "p")

  -- Open the file for writing
  local success, file = pcall(io.open, patched_font_path, "w")
  if not success or not file then
    vim.api.nvim_err_writeln("Error: Could not open or write to " .. patched_font_path)
    return
  end

  -- Write the boolean value to the file
  file:write("return " .. tostring(value) .. "\n")
  file:close()

  vim.notify("Patched font setting updated to " .. tostring(value), vim.log.levels.INFO)
end

-- Create the user commands for PatchedFontToggle, PatchedFontEnable, PatchedFontDisable
vim.api.nvim_create_user_command("PatchedFontToggle", function()
  local current_value = M.check_patched_font()
  if current_value == nil then
    current_value = false -- Default to false if not set
  end
  M.set_patched_font(not current_value)
end, {})

vim.api.nvim_create_user_command("PatchedFontEnable", function()
  M.set_patched_font(true)
end, {})

vim.api.nvim_create_user_command("PatchedFontDisable", function()
  M.set_patched_font(false)
end, {})

return M
