vim.pack.add({
	{ src = "https://github.com/neovim/nvim-lspconfig" },
})

local lsps = { "lua_ls", "gopls", "ts_ls", "golangci_lint_ls" }

for _, lsp in ipairs(lsps) do
	vim.lsp.enable(lsp)
end

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		if client == nil then
			return
		end
		local buf = args.buf
		local function set_lsp_keymap(mode, lhs, rhs, opts)
			opts = opts or {}
			opts.buffer = buf
			vim.keymap.set(mode, lhs, rhs, opts)
		end
		local fzf = require("fzf-lua")
		set_lsp_keymap("n", "<leader>rn", vim.lsp.buf.rename)

		set_lsp_keymap({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action)
		set_lsp_keymap("n", "<leader>gD", vim.lsp.buf.declaration)
		set_lsp_keymap("i", "<C-s>", vim.lsp.buf.signature_help)
		set_lsp_keymap("n", "<leader>gd", fzf.lsp_definitions)
		set_lsp_keymap("n", "<leader>gi", fzf.lsp_implementations)
		set_lsp_keymap("n", "<leader>gt", fzf.lsp_typedefs)
		set_lsp_keymap("n", "<leader>fr", fzf.lsp_references)
		set_lsp_keymap("n", "<leader>gO", fzf.lsp_document_symbols)
		vim.keymap.set("n", "<leader>l", function()
			vim.diagnostic.open_float({
				focusable = true,
				border = "rounded",
				source = "if_many",
				header = "",
			})
		end)
	end,
})

