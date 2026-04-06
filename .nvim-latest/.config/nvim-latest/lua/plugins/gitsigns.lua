vim.pack.add({ "https://github.com/lewis6991/gitsigns.nvim", })

require("gitsigns").setup({
	current_line_blame = true,
	current_line_blame_opts = {
		virt_text = true,
		virt_text_pos = 'eol',
		delay = 100
	}
})

vim.api.nvim_set_hl(0, "GitSignsCurrentLineBlame", { fg = "#7a7a7a", italic = true })

vim.keymap.set("n", "<leader>bt", function()
	-- require("gitsigns").blame_line({ full = true })
	require("gitsigns").toggle_current_line_blame()
end)
