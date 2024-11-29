local ls = require("luasnip")
local set = vim.keymap.set

set({ "i", "s" }, "<C-l>", function()
	ls.jump(1)
end, { silent = true })
set({ "i", "s" }, "<C-h>", function()
	ls.jump(-1)
end, { silent = true })

require("luasnip.loaders.from_vscode").lazy_load()
