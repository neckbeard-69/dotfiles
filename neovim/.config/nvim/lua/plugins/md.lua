vim.pack.add({
	"https://github.com/MeanderingProgrammer/render-markdown.nvim",
	
	-- dependencies
	'https://github.com/nvim-treesitter/nvim-treesitter', 
	'https://github.com/nvim-mini/mini.nvim',
})

require('render-markdown').setup({
	completions = { lsp = { enabled = false }, blink = { enabled = false }, },
	ignore = function(buf)
		if vim.bo[buf].buftype ~= "" then
			return true
		end
	end
})
