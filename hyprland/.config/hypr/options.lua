hl.on("hyprland.start", function()
	hl.exec_cmd("dms run")
	hl.exec_cmd("ystemctl --user start hyprland-session.target")
	hl.exec_cmd("ystemctl --user import-environment XDG_SESSION_TYPE XDG_CURRENT_DESKTOP")
	hl.exec_cmd("bus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
	hl.exec_cmd("bus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=Hyprland")
	hl.exec_cmd("/home/mohammed/dotfiles/.bin/battery-alert &")
end)

hl.env("XDG_CURRENT_DESKTOP", "Hyprland")


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
		gaps_in = 5,
		gaps_out = 5,
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

})
hl.workspace_rule({
	workspace = "w[tv1]",
	gaps_in = 0,
	gaps_out = 0,
	no_border = true
})
