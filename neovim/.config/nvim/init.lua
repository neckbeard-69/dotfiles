-- put this in your main init.lua file ( before lazy setup )
vim.g.base46_cache = vim.fn.stdpath("data") .. "/base46_cache/"

for _, v in ipairs(vim.fn.readdir(vim.g.base46_cache)) do
	dofile(vim.g.base46_cache .. v)
end
require("config.lazy")
require("config.options")
require("config.keymaps")
require("custom.snippets.go")

local function makeTransparent()
	vim.cmd([[ hi Normal guibg=NONE ctermbg=NONE ]])
	vim.cmd([[ hi NormalNC guibg=NONE ctermbg=NONE ]])
	vim.cmd([[ hi EndOfBuffer guibg=NONE ctermbg=NONE ]])
end

makeTransparent()
