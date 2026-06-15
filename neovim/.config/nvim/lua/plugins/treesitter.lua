vim.pack.add({
	{
		src = "https://github.com/nvim-treesitter/nvim-treesitter",
		version = "main",
	},

	-- dependencies
	{
		src = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects",
		branch = "main"
	},
	
	"https://github.com/nvim-treesitter/nvim-treesitter-context"
	
})

require("nvim-treesitter").setup({
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
})

vim.api.nvim_create_autocmd("FileType", {
	callback = function()
		pcall(vim.treesitter.start)
	end,
})

local ensureInstalled = { "go", "javascript", "html", "c", "cpp", "lua" }
local alreadyInstalled = require('nvim-treesitter.config').get_installed()
local parsersToInstall = vim.iter(ensureInstalled)
:filter(function(parser)
	return not vim.tbl_contains(alreadyInstalled, parser)
end)
:totable()
require('nvim-treesitter').install(parsersToInstall)
vim.api.nvim_create_autocmd('FileType', {
	callback = function()
		-- Enable treesitter highlighting and disable regex syntax
		pcall(vim.treesitter.start)
		-- Enable treesitter-based indentation
		vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
	end,
})
-- require("treesitter-context").setup({})
vim.keymap.set({ "n", "v" }, "<leader>jc", function()
	require("treesitter-context").go_to_context(vim.v.count1)
end, { silent = true })
