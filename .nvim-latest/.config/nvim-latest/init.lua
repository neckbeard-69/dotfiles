require("options")
require("keymaps")

local plugins = vim.fn.stdpath("config") .. "/lua/plugins"

for _, file in ipairs(vim.fn.readdir(plugins)) do
	if file:match("%.lua$") then
		local module = "plugins." .. file:gsub("%.lua$", "")
		require(module)
	end
end

vim.cmd([[
  hi Normal guibg=none ctermbg=none
  hi NormalNC guibg=none ctermbg=none
  hi NormalFloat guibg=none ctermbg=none
  hi FloatBorder guibg=none ctermbg=none
  hi SignColumn guibg=none ctermbg=none
  hi LineNr guibg=none ctermbg=none
  hi EndOfBuffer guibg=none ctermbg=none
]])
