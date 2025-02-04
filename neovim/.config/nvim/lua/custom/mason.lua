require("mason").setup({
	ui = {
		icons = {
			package_pending = " ",
			package_installed = " ",
			package_uninstalled = " ",
		},
	},
    ensure_installed = {
        "ts_ls",
        "gopls",
        "lua_ls",
        "emmet_ls",
        "clangd",
    },
})
