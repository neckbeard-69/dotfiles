-- put this in your main init.lua file ( before lazy setup )
vim.g.base46_cache = vim.fn.stdpath("data") .. "/base46_cache/"

-- put this after lazy setup

-- (method 2, for non lazyloaders) to load all highlights at once
for _, v in ipairs(vim.fn.readdir(vim.g.base46_cache)) do
	dofile(vim.g.base46_cache .. v)
end
require("config.lazy")
require("config.options")

require("config.keymaps")
