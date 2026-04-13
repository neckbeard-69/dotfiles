return {
	"navarasu/onedark.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		require('onedark').setup {
			style = 'deep'
		}
		vim.cmd.colorscheme("onedark")
	end,
}
