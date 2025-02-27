local capabilities = require("cmp_nvim_lsp").default_capabilities()

local handlers = {
	function(server_name)
		require("lspconfig")[server_name].setup({
			capabilities = capabilities,
		})
	end,
	["lua_ls"] = function()
		local lspconfig = require("lspconfig")
		lspconfig.lua_ls.setup({
			capabilities = capabilities,
			settings = {
				Lua = {
					runtime = {
						version = "LuaJIT",
						path = vim.split(package.path, ";"),
					},
					diagnostics = {
						globals = { "vim" },
					},
					workspace = {
						library = vim.api.nvim_get_runtime_file("", true),
						checkThirdParty = false,
					},
					telemetry = {
						enable = false,
					},
				},
			},
		})
	end,
	["emmet_ls"] = function()
		require("lspconfig").emmet_ls.setup({
			filetypes = { "html", "php", "javascriptreact", "typescriptreact" },
		})
	end,
}

require("mason-lspconfig").setup({ handlers = handlers })
