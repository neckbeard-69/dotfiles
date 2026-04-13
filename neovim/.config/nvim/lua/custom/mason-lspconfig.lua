local handlers = {
	function(server_name)
		local capabilities = require("blink.cmp").get_lsp_capabilities()
		require("lspconfig")[server_name].setup { capabilities = capabilities }
	end,
	["html"] = function()
		require("lspconfig").html.setup({
			filetypes = { "html" },
		})
	end,
	["ts_ls"] = function()
		require("lspconfig").ts_ls.setup({
		})
	end,
	["emmet_ls"] = function()
		require("lspconfig").emmet_ls.setup({
			filetypes = { "html", "php", "javascriptreact", "typescriptreact" },
		})
	end,
	["tailwindcss"] = function()
		require("lspconfig").tailwindcss.setup({})
	end
}

require("mason-lspconfig").setup({ handlers = handlers })
