vim.pack.add({
	"https://github.com/L3MON4D3/LuaSnip",
	"https://github.com/rafamadriz/friendly-snippets",
})

vim.pack.add({
	{
		src = "https://github.com/Saghen/blink.cmp",
		name = "blink.cmp",
	},
})
require("blink.cmp").setup({
	keymap = {
		["<C-j>"] = { "select_next", "fallback" },
		["<C-k>"] = { "select_prev", "fallback" },
		["<CR>"] = { "accept", "fallback" },
		["<TAB>"] = { "accept", "fallback" },
		["<A-CR>"] = { "show", "fallback" },
	},
	appearance = {
		nerd_font_variant = "mono",
		use_nvim_cmp_as_default = false,
	},
	completion = {
		documentation = { auto_show = true, auto_show_delay_ms = 0 },
		menu = {
			draw = {
				columns = {
					{ "label",     "label_description", gap = 3 },
					{ "kind_icon", "kind" },
				},
			},
		},
	},
	sources = {
		default = { "lsp", "path", "snippets", "buffer" },
	},
	snippets = { preset = "luasnip" },
	fuzzy = {
		implementation = "prefer_rust",
		prebuilt_binaries = { force_version = "v*" }
	},
	signature = { enabled = true },
})
