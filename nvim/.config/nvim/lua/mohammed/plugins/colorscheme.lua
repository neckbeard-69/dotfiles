return {
	-- "neanias/everforest-nvim",
	-- "dgox16/oldworld.nvim",
	"catppuccin/nvim",
	-- "ellisonleao/gruvbox.nvim",
	config = function()
		vim.cmd("colorscheme catppuccin")
		require("catppuccin").setup({
			transparent_background = false,
		})
	end,
}
