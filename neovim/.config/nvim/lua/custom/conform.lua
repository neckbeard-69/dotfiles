require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		go = { "gofumpt" },
		typescriptreact = { "prettier" },
		javascriptreact = { "prettier" },
	},

	formatters = {},

	format_on_save = function(bufnr)
		local filepath = vim.api.nvim_buf_get_name(bufnr)
		local filename = vim.fn.fnamemodify(filepath, ":t")

		if filename == "Justfile" or filename == "justfile" then
			return nil
		end

		return {
			timeout_ms = 2000,
			lsp_fallback = true,
			lsp_format = "last",
		}
	end,
})
