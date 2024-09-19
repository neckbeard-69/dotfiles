return {
	{ "neanias/everforest-nvim" },
	{ "projekt0n/caret.nvim" },
	{
		"catppuccin/nvim",
		config = function()
			require("catppuccin").setup({
				transparent_background = false,
			})
			vim.cmd("colorscheme monokai-pro")
		end,
	},
	{ "ellisonleao/gruvbox.nvim" },
	{ "folke/tokyonight.nvim" },
    {"cpea2506/one_monokai.nvim"},
    {"loctvl842/monokai-pro.nvim",
    config = function()
        require("monokai-pro").setup()
    end
    },
}
