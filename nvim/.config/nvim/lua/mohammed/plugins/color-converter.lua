return {
	-- converts between color formats (hex, rgb, hsl...etc)
	"NTBBloodbath/color-converter.nvim",
	config = function()
		vim.keymap.set("n", "<leader>cc", "<Plug>ColorConvertCycle")
	end,
}
