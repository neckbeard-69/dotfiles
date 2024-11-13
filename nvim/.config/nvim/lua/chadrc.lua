local options = {
	base46 = {
		theme = "gruvchad",
		transparency = false,
		theme_toggle = { "kanagawa", "gruvbox" },
	},
	ui = {
		cmp = {
			style = "atom",
			icons_left = true,
		},
		telescope = { style = "bordered" },
		statusline = {
			theme = "default",
			separator_style = "default",
		},
		tabufline = {
			enabled = false,
		},
	},
}

local status, chadrc = pcall(require, "chadrc")
return vim.tbl_deep_extend("force", options, status and chadrc or {})
