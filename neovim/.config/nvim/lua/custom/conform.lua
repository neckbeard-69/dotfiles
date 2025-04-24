require("conform").setup({
    formatters_by_ft = {
        lua = { "stylua" },
        go = { "gofumpt" },
        -- js = { "ts_ls" },
        -- ts = { "ts_ls" },
    },
    format_on_save = {
        timeout_ms = 500,
        lsp_format = "fallback",
    },
})
