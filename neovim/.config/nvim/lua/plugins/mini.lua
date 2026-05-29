return {
	{
		"echasnovski/mini.nvim",
		config = function()
			require("mini.ai").setup()
			require("mini.statusline").setup()
			require("mini.surround").setup()
			require("mini.pairs").setup()
			require("mini.icons").setup()
			require("mini.files").setup({
				mappings = {
					go_in = "",
					go_out = "",
					go_out_plus = "-",
					close = "<C-b>",
					synchronize = "=",
				},
				options = {
					permanent_delete = false,
				},
				windows = {
					preview = false,
				},
			})
			vim.keymap.set("n", "<C-b>", function()
				MiniFiles.open(vim.api.nvim_buf_get_name(0), false)
			end)

			vim.keymap.set("n", "<CR>", function()
				MiniFiles.go_in({ close_on_file = true })
				-- MiniFiles.trim_left()
			end)
		end,

	},
}
