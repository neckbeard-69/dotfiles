return {
	{
		"stevearc/oil.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			CustomOilBar = function()
				local path = vim.fn.expand("%")
				path = path:gsub("oil://", "")

				return "  " .. vim.fn.fnamemodify(path, ":.")
			end

			require("oil").setup({
				columns = { "icon" },
				keymaps = {
					["<C-h>"] = false,
					["<C-l>"] = false,
					["<C-k>"] = false,
					["<C-j>"] = false,
					["<M-h>"] = "actions.select_split",
				},
				win_options = {
					winbar = "%{v:lua.CustomOilBar()}",
				},
				view_options = {
					show_hidden = true,
				},
				skip_confirm_for_simple_edits = true,
				delete_to_trash = true,
			})

			-- Open parent directory in current window
			-- vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

			-- Open parent directory in floating window
			vim.keymap.set("n", "<C-b>", require("oil").toggle_float)
		end,
	},
}