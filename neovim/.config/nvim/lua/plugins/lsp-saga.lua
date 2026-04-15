return {
	'nvimdev/lspsaga.nvim',
	init = function()
		require('lspsaga').setup({
			symbol_in_winbar = {
				enable = false
			},
			lightbulb = {
				virtual_text = false
			}
		})
	end,
	config = function()
		vim.keymap.set("n", "<A-t>", "<cmd>Lspsaga term_toggle<CR>")
	end

}
