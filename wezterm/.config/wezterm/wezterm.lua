local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.keys = require("keybinds")

config.color_scheme = "Tokyo Night"
config.font = wezterm.font("JetBrainsMono Nerd Font")
config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}
config.enable_tab_bar = false
config.bold_brightens_ansi_colors = false
config.font_size = 12
config.window_background_opacity = 0.8

config.harfbuzz_features = { "calt=0", "clig=0", "liga=0" }
config.max_fps = 120
return config
