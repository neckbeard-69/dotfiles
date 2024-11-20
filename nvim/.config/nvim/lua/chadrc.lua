local options = {
	base46 = {
		theme = "everblush",
		transparency = false,
		theme_toggle = { "kanagawa", "gruvbox" },
	},
	ui = {
		cmp = {
			lspkind_text = true,
			style = "default", -- default/flat_light/flat_dark/atom/atom_colored
		},
		telescope = { style = "bordered" },
		statusline = {
			theme = "default",
			separator_style = "default",
		},
		tabufline = {
			enabled = false,
		},
		colorify = {
			enabled = false,
			highlight = { hex = false, hsl = false },
		},
		lsp = { signature = true },
	},
}

local status, chadrc = pcall(require, "chadrc")
return vim.tbl_deep_extend("force", options, status and chadrc or {})
