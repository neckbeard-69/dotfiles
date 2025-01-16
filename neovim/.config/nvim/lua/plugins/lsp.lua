return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "stevearc/conform.nvim",
            {
                "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
                config = function()
                    vim.diagnostic.config({ virtual_lines = false })
                end
            },
            {
                "nvimdev/lspsaga.nvim",
                config = function()
                    require("lspsaga").setup({
                        symbol_in_winbar = {
                            enable = false,
                        },
                        code_action = {
                            show_server_name = true,
                        },
                        lightbulb = {
                            enable = false,
                        },
                    })
                    vim.keymap.set("n", "<leader>tt", ":Lspsaga term_toggle<CR>")
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
