vim.pack.add({
	{
		src = "https://github.com/ellisonleao/gruvbox.nvim",
		name = "gruvbox.nvim",
	}})

pcall(vim.cmd, "colorscheme gruvbox")
