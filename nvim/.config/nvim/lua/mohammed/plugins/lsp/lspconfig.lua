return {
    { "VonHeikemen/lsp-zero.nvim" },
    {
        "neovim/nvim-lspconfig",
        config = function()
            -- Reserve a space in the gutter
            -- This will avoid an annoying layout shift in the screen
            vim.opt.signcolumn = "yes"
            -- Add cmp_nvim_lsp capabilities settings to lspconfig
            -- This should be executed before you configure any language server
            local lspconfig_defaults = require("lspconfig").util.default_config
            lspconfig_defaults.capabilities = vim.tbl_deep_extend(
                "force",
                lspconfig_defaults.capabilities,
                require("cmp_nvim_lsp").default_capabilities()
            )

            -- This is where you enable features that only work
            -- if there is a language server active in the file
            vim.api.nvim_create_autocmd("LspAttach", {
                desc = "LSP actions",
                callback = function(event)
                    local opts = { buffer = event.buf }

                    vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)
                    vim.keymap.set("n", "<leader>gd", "<cmd>lua vim.lsp.buf.definition()<cr>", opts)
                    vim.keymap.set("n", "<leader>gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", opts)
                    vim.keymap.set("n", "<leader>gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", opts)
                    vim.keymap.set("n", "<leader>go", "<cmd>lua vim.lsp.buf.type_definition()<cr>", opts)
                    vim.keymap.set("n", "<leader>gr", "<cmd>lua vim.lsp.buf.references()<cr>", opts)
                    vim.keymap.set("n", "<leader>gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>", opts)
                    vim.keymap.set("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
                    vim.keymap.set("n", "<leader>gf", "<cmd>lua vim.lsp.buf.format({async = true})<cr>", opts)
                    vim.keymap.set("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
                end,
            })
            require("mason").setup()
            require("mason-lspconfig").setup({
                -- List of servers to ensure are installed
                ensure_installed = { "lua_ls", "pyright", "gopls" },
                automatic_installation = true,
            })

            local lspconfig = require("lspconfig")

            -- Define any common options
            local on_attach = function(client, bufnr)
                -- Your on_attach configuration (key mappings, etc.)
            end

            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

            -- Automatically set up each server installed by Mason
            require("mason-lspconfig").setup_handlers({
                function(server_name) -- Default handler for all servers
                    lspconfig[server_name].setup({
                        on_attach = on_attach,
                        capabilities = capabilities,
                    })
                end,
            })
        end,
    },
    { "hrsh7th/cmp-nvim-lsp" },
    { "hrsh7th/nvim-cmp" },
}
