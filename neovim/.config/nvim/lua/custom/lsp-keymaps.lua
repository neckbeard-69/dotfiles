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

        if client.supports_method("textDocument/rename") then
            set_lsp_keymap("n", "<leader>rn", require("nvchad.lsp.renamer"))
        end

        if client.supports_method("textDocument/implementation") then
            set_lsp_keymap("n", "<leader>im", builtin.lsp_implementations)
        end

        if client.supports_method("textDocument/codeAction") then
            set_lsp_keymap({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action)
        end

        if client.supports_method("textDocument/declaration") then
            set_lsp_keymap("n", "<leader>gD", vim.lsp.buf.declaration)
        end

        if client.supports_method("textDocument/definition") then
            set_lsp_keymap("n", "<leader>gd", builtin.lsp_definitions)
        end

        if client.supports_method("textDocument/typeDefinition") then
            set_lsp_keymap("n", "<leader>td", builtin.lsp_type_definitions)
        end

        if client.supports_method("textDocument/references") then
            set_lsp_keymap("n", "<leader>gr", builtin.lsp_references)
        end

        if client.supports_method("textDocument/documentSymbol") then
            set_lsp_keymap("n", "<leader>ds", builtin.lsp_document_symbols)
        end

        if client.supports_method("workspace/symbol") then
            set_lsp_keymap("n", "<leader>ws", builtin.lsp_workspace_symbols)
        end

        if client.supports_method("textDocument/signatureHelp") then
            set_lsp_keymap("i", "<C-s>", vim.lsp.buf.signature_help)
        end

        if client.supports_method("workspace/diagnostic/refresh") then
            set_lsp_keymap("n", "<leader>dr", builtin.diagnostics)
        end
    end,
    vim.keymap.set("n", "<leader>l", function()
        local config = vim.diagnostic.config() or {}
        if config.virtual_text then
            vim.diagnostic.config({ virtual_text = false, virtual_lines = true })
        else
            vim.diagnostic.config({ virtual_text = true, virtual_lines = false })
        end
    end, { desc = "Toggle lsp_lines" }),
})
