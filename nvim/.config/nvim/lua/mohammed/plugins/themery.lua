return {
	"zaldih/themery.nvim",
	config = function()
		-- Minimal config
		require("themery").setup({
			themes = { "gruvbox", "everforest", "catppuccin", "caret" }, -- Your list of installed colorschemes
			livePreview = true, -- Apply theme while browsing. Default to true.
		})
		vim.keymap.set("n", "<leader>th", ":Themery<CR>")
	end,
}
