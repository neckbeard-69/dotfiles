local wezterm = require("wezterm")
local config = wezterm.config_builder()
config.keys = require("keybinds")

config.color_scheme = "Everforest Dark (Gogh)"
config.font = wezterm.font("JetBrainsMono Nerd Font")
config.window_padding = {
	left = 0,
	right = 0,
	top = 2,
	bottom = 1,
}
config.enable_tab_bar = false
config.bold_brightens_ansi_colors = false
config.font_size = 13
config.enable_wayland = false
config.window_background_opacity = 0.6
config.colors = {
	background = "#000000",
}
config.max_fps = 120
return config
