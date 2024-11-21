return {
	"ThePrimeagen/harpoon",
	config = function()
		require("harpoon").setup()
		local keymap = vim.keymap
		keymap.set(
			"n",
			"<leader>hm",
			':lua require("harpoon.ui").toggle_quick_menu()<CR>',
			{ desc = "toggle harpoon menu" }
		)
		keymap.set(
			"n",
			"<leader>ha",
			':lua require("harpoon.mark").add_file()<CR>',
			{ desc = "harpoon - add current file" }
		)
		keymap.set("n", "<C-n>", ':lua require("harpoon.ui").nav_next()<CR>', { desc = "harpoon - next" })
		keymap.set("n", "<C-m>", ':lua require("harpoon.ui").nav_prev()<CR>', { desc = "harpoon - previous" })

		for i = 1, 9 do
			keymap.set(
				"n",
				string.format("<leader>%d", i),
				string.format(":lua require('harpoon.ui').nav_file(%d)<CR>", i)
			)
		end
	end,
}
