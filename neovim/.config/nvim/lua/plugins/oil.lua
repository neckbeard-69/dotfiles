return {
	{
		"stevearc/oil.nvim",
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

			local is_open = false
			vim.keymap.set("n", "<C-b>", function()
				if is_open then
					require("oil").close()
					is_open = false
					return
				end
				require("oil").open()
				is_open = true
			end)
		end,
	},
}
