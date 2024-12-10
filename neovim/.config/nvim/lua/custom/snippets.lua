local ls = require("luasnip")
local set = vim.keymap.set

set({ "i", "s" }, "<C-k>", function()
	ls.jump(1)
end, { silent = true })
set({ "i", "s" }, "<C-j>", function()
	ls.jump(-1)
end, { silent = true })

require("luasnip.loaders.from_vscode").lazy_load()
