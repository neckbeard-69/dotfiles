return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	config = function()
		local harpoon = require("harpoon")
		harpoon:setup()
		local keymap = vim.keymap
		keymap.set("n", "<leader>hm", function()
			harpoon.ui:toggle_quick_menu(harpoon:list())
		end)
		keymap.set("n", "<leader>ha", function()
			harpoon:list():add()
		end)
		keymap.set("n", "<leader>j", function()
			harpoon:list():next()
		end)
		keymap.set("n", "<leader>k", function()
			harpoon:list():prev()
		end)

		for i = 1, 9 do
			keymap.set("n", string.format("<leader>%d", i), function()
				harpoon:list():select(i)
			end)
		end
	end,
}
