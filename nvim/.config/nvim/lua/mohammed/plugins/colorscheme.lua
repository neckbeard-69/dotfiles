return {
	{ "neanias/everforest-nvim" },
	{ "projekt0n/caret.nvim" },
	{
		"catppuccin/nvim",
		config = function()
			require("catppuccin").setup({
				transparent_background = false,
			})
			vim.cmd("colorscheme catppuccin")
		end,
	},
	{ "ellisonleao/gruvbox.nvim" },
}
