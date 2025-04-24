return {
    "neovim/nvim-lspconfig",
    opts = {
        diagnostics = {
            virtual_text = false,
            signs = false,
        },
    },
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "stevearc/conform.nvim",
        "saghen/blink.cmp",
    },
    config = function()
        require("custom.mason")
        require("custom.mason-lspconfig")
        require("custom.lsp-keymaps")
        require("custom.conform")
        require("custom.snippets")
    end,
}
