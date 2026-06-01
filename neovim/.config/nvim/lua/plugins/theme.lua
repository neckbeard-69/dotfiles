return {
	"rebelot/kanagawa.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		require('kanagawa').setup {
			terminalColors = true,
			colors = { theme = { all = { ui = { bg_gutter = "none" } } } },

			require("kanagawa").setup({
				overrides = function(colors)
					return {
						NormalFloat = { bg = "#1F1F28" },
						FloatBorder = { fg = "#3b3b4f", bg = "#1F1F28" },

						BlinkCmpMenu = { bg = "#1F1F28" },
						BlinkCmpMenuBorder = { fg = "#3b3b4f", bg = "#1F1F28" },
						BlinkCmpMenuSelection = { bg = "#363646" },

						BlinkCmpScrollBarGutter = { bg = "#1F1F28" },
						BlinkCmpScrollBarThumb = { bg = "#363646" },

						BlinkCmpLabel = { bg = "#1F1F28" },
						BlinkCmpLabelDetail = { bg = "#1F1F28" },
						BlinkCmpLabelDescription = { bg = "#1F1F28" },
						BlinkCmpSource = { bg = "#1F1F28" },

						BlinkCmpDoc = { bg = "#1F1F28" },
						BlinkCmpDocBorder = { fg = "#3b3b4f", bg = "#1F1F28" },
						BlinkCmpDocSeparator = { bg = "#1F1F28" },
						BlinkCmpDocCursorLine = { bg = "#1F1F28" },

						BlinkCmpSignatureHelp = { bg = "#1F1F28" },
						BlinkCmpSignatureHelpBorder = { fg = "#3b3b4f", bg = "#1F1F28" },
					}
				end,
			})
		}
		vim.cmd.colorscheme("kanagawa-wave")
	end,
}
