return {
	"sindrets/diffview.nvim",
	config = function()
		vim.keymap.set("n", "<leader>do", ":DiffviewOpen<CR>")
		vim.keymap.set("n", "<leader>dt", ":DiffviewToggleFiles<CR>")
	end
}
