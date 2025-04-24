return {
    'saghen/blink.cmp',
    dependencies = {
        "L3MON4D3/LuaSnip",
        dependencies = { "rafamadriz/friendly-snippets" }
    },
    version = "1.1.1",
    opts = {
        keymap = {
            ["<C-j>"] = { "select_next", "fallback" },
            ["<C-k>"] = { "select_prev", "fallback" },
            ["<CR>"] = { "accept", "fallback" }
        },
        appearance = {
            nerd_font_variant = 'mono',
            use_nvim_cmp_as_default = true,
        },

        completion = {
            documentation = { auto_show = true, auto_show_delay_ms = 0 },
            menu = {
                draw = {
                    columns = {
                        { "label",     "label_description", gap = 1 },
                        { "kind_icon", "kind" }
                    }
                }
            }
        },

        sources = {
            default = { 'lsp', 'path', 'snippets', 'buffer' },
        },
        snippets = { preset = 'luasnip' },

        fuzzy = { implementation = "prefer_rust_with_warning" },
        signature = { enabled = true },

    },
}
