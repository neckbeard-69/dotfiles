return {
	{
		"neovim/nvim-lspconfig",
		opts = {
			diagnostics = {
				virtual_text = false,
				signs = false,
			},
		},
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"stevearc/conform.nvim",
			{
				"https://git.sr.ht/~whynothugo/lsp_lines.nvim",
				config = function()
					vim.diagnostic.config({ virtual_lines = false })
				end,
			},
		},
		config = function()
			require("custom.mason")
			require("custom.mason-lspconfig")
			require("custom.lsp-keymaps")
			require("custom.conform")
		end,
	},
}
