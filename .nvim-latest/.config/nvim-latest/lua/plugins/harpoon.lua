vim.pack.add({ "https://github.com/nvim-lua/plenary.nvim" })
vim.pack.add({
	{
		src = "https://github.com/ThePrimeagen/harpoon",
		version = "harpoon2",
		name = "harpoon"
	}
})

local harpoon = require("harpoon")
harpoon:setup()

local set = vim.keymap.set
set("n", "<leader>hm", function()
	harpoon.ui:toggle_quick_menu(harpoon:list())
end)
set("n", "<leader>ha", function()
	harpoon:list():add()
	print("buffer added")
end)
set("n", "<A-n>", function()
	harpoon:list():next({ ui_nav_wrap = true })
end)
set("n", "<A-p>", function()
	harpoon:list():prev({ ui_nav_wrap = true })
end)

for i = 1, 9 do
	set("n", string.format("<A-%d>", i), function()
		harpoon:list():select(i)
	end)
end
