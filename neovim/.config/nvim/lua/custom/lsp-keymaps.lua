local builtin = require("telescope.builtin")

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

		set_lsp_keymap("n", "<leader>rn", function()
			vim.cmd("Lspsaga rename")
		end)

		set_lsp_keymap("n", "<leader>im", builtin.lsp_implementations)
		set_lsp_keymap({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action)
		set_lsp_keymap("n", "<leader>gD", vim.lsp.buf.declaration)
		set_lsp_keymap("n", "<leader>gd", builtin.lsp_definitions)
		-- set_lsp_keymap("n", "K", function()
		-- 	vim.lsp.buf.hover({
		-- 		border = "rounded",
		-- 		focusable = true,
		-- 	})
		-- end)
		set_lsp_keymap("n", "<leader>td", builtin.lsp_type_definitions)
		set_lsp_keymap("n", "<leader>gr", builtin.lsp_references)
		set_lsp_keymap("n", "<leader>ds", builtin.lsp_document_symbols)
		set_lsp_keymap("n", "<leader>ws", builtin.lsp_workspace_symbols)
		set_lsp_keymap("i", "<C-s>", vim.lsp.buf.signature_help)
		set_lsp_keymap("n", "<leader>dr", builtin.diagnostics)
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
