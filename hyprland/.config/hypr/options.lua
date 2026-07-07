hl.on("hyprland.start", function()
	hl.exec_cmd("dms run")
	hl.exec_cmd("ystemctl --user start hyprland-session.target")
	hl.exec_cmd("ystemctl --user import-environment XDG_SESSION_TYPE XDG_CURRENT_DESKTOP")
	hl.exec_cmd("bus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
	hl.exec_cmd("bus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=Hyprland")
	hl.exec_cmd("/home/mohammed/dotfiles/.bin/battery-alert &")
end)

hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("HYPRCURSOR_THEME", "Adwaita")
hl.env("HYPRCURSOR_SIZE", "24")


hl.config({
	input = {
		repeat_rate = 50,
		repeat_delay = 250,
		sensitivity = 0,

		touchpad = {
			natural_scroll = true
		}
	},
	general = {
		layout = "scrolling",
		gaps_in = 0,
		gaps_out = 0,
		border_size = 0
	},
	decoration = {
		inactive_opacity = 0.9,
		rounding = 4,
		blur = {
			enabled = false
		}
	},
	animations = {
		enabled = false
	},
	scrolling = {
		column_width = 1.0,
		wrap_focus = true
	}

})
hl.monitor({
  output = "eDP-1",
  mode = "1920x1080@60",
  position = "0x0",
  scale = 1.2,
})
