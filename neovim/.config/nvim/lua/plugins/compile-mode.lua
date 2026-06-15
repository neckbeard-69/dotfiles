vim.pack.add({
	"https://github.com/ej-shafran/compile-mode.nvim",

	-- dependencies
	"https://github.com/nvim-lua/plenary.nvim",
})

vim.g.compile_mode = {
	default_command = "", 	
	focus_compilation_buffer = true,
	use_diagnostics = true,
}
vim.keymap.set("n", "<leader>cc", ":Compile<CR>")
vim.keymap.set("n", "<leader>ck", ":Recompile<CR>")
