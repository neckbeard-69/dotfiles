vim.pack.add({"https://github.com/romus204/go-tagger.nvim"})

require("go-tagger").setup({
	casing = "snake_case",
	skip_private = true,
})

vim.keymap.set({"v", "n"}, "<C-t>", ":AddGoTags<CR>")
