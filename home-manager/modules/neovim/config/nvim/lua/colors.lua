local function set_colorscheme(name)
  local success, _ = pcall(function() vim.cmd("colorscheme " .. name) end)
  if success then
    -- Save the colorscheme name to a file in the cache directory
    local cache_dir = vim.fn.stdpath("cache")
    local color_file = cache_dir .. "/last_colorscheme"
    local file = io.open(color_file, "w")
    if file then
      file:write(name)
      file:close()
      -- print("Colorscheme " .. name .. " set and saved.")
    else
      print("Failed to save colorscheme.")
    end
  else
    print("Failed to set colorscheme " .. name .. ". Falling back to default.")
    pcall(function() vim.cmd("colorscheme default") end)
  end
end

-- Create user command to set and save colorscheme
vim.api.nvim_create_user_command("SetColorScheme", function(opts)
  set_colorscheme(opts.args)
end, { nargs = 1, complete = "color" })

-- Load the last used colorscheme on startup
local cache_dir = vim.fn.stdpath("cache")
local color_file = cache_dir .. "/last_colorscheme"
local file = io.open(color_file, "r")
if file then
  local last_colorscheme = file:read("*all")
  file:close()
  set_colorscheme(last_colorscheme)
else
  -- If no saved colorscheme, use a default one
  set_colorscheme("default")
end

