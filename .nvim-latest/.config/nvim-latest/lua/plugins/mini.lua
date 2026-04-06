vim.pack.add({
	{
		src = "https://github.com/echasnovski/mini.nvim",
		name = "mini.nvim",
	}
})

require("mini.ai").setup()
require("mini.statusline").setup()
require("mini.surround").setup()
require("mini.pairs").setup()
require("mini.icons").setup()
