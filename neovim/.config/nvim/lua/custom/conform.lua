require("conform").setup({
    formatters_by_ft = {
        lua = { "stylua" },
        go = { "gofumpt" },
        typescriptreact = { "prettier" },
        javascriptreact = { "prettier" },
    },
    formatters = {
    },
    format_on_save = {
        timeout_ms = 2000,
        lsp_fallback = true,
        lsp_format = "last",
    },
})
