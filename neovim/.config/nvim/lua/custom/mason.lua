require("mason").setup({
	ui = {
		icons = {
			package_pending = " ",
			package_installed = " ",
			package_uninstalled = " ",
		},
	},
})
require("mason-lspconfig").setup({
	ensure_installed = {
		"ts_ls",
		"gopls",
		"lua_ls",
		"emmet_ls",
		"clangd",
	},
})
