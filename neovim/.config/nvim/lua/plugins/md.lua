return {
	'MeanderingProgrammer/render-markdown.nvim',
	dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.nvim' }, -- if you use the mini.nvim suite
	ft = { "markdown" },
	-- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.icons' },        -- if you use standalone mini plugins
	-- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
	---@module 'render-markdown'
	---@type render.md.UserConfig
	opts = {
	},
	config = function()
		require('render-markdown').setup({
			completions = { lsp = { enabled = false }, blink = { enabled = false }, },
			ignore = function(buf)
				if vim.bo[buf].buftype ~= "" then
					return true
				end
			end
		})
	end
}
