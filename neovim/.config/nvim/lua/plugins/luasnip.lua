vim.pack.add({"https://github.com/L3MON4D3/LuaSnip"})

local ls = require("luasnip")
local set = vim.keymap.set

set({ "i", "s" }, "<C-k>", function()
	ls.jump(1)
end, { silent = true })
set({ "i", "s" }, "<C-j>", function()
	ls.jump(-1)
end, { silent = true })

require("luasnip.loaders.from_vscode").lazy_load()

-- go
require("luasnip.session.snippet_collection").clear_snippets("go")
local s = ls.snippet
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

ls.add_snippets("go", {
	s("ie", fmt("if err != nil {{\n\t{}\n}}", { i(0) })),
})
