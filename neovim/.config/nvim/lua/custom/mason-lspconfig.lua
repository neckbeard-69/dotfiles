local handlers = {
    function(server_name)
        local capabilities = require("blink.cmp").get_lsp_capabilities()
        require("lspconfig")[server_name].setup { capabilities = capabilities }
    end,
    ["lua_ls"] = function()
        local lspconfig = require("lspconfig")
        lspconfig.lua_ls.setup({
            settings = {
                Lua = {
                    runtime = {
                        version = "LuaJIT",
                        path = vim.split(package.path, ";"),
                    },
                    diagnostics = {
                        globals = { "vim" },
                    },
                    workspace = {
                        library = vim.api.nvim_get_runtime_file("", true),
                        checkThirdParty = false,
                    },
                    telemetry = {
                        enable = false,
                    },
                },
            },
        })
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
