return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("lualine").setup({
			options = {
				globalstatus = true,
				section_separators = { right = "", left = "" },
				color = {
					gui = "bold",
				},
			},
		})
	end,
}
