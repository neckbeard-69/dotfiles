require("binds.applications")
require("binds.window_management")
require("binds.multimedia")

local exec = hl.dsp.exec_cmd

local main_mod = "SUPER"
local function reload_config(_)
	return function()
		hl.exec_cmd("hyprctl reload")
		hl.notification.create({
			text = "\n\tConfig Reloaded\t\n",
			timeout = 2500,
			color = "#a00aff",
			font_size = 16,
		})
	end
end

---@type Bind[]
local binds = {
	{ key = "SUPER + SHIFT + r", action = reload_config() },
	{ key = main_mod .. " + c",  action = hl.dsp.exec_raw("dms color pick -a") },
	{ key = "Print",             action = exec("~/dotfiles/.bin/screenshot --edit") },
	{ key = main_mod .. " + s",  action = exec("~/dotfiles/.bin/screenshot") },
	{ key = "SUPER + SHIFT + b", action = exec("gammastep -l 0:0 -O 4500:4500") },
	{
		key = "SUPER + SHIFT + x",
		action = hl.dsp.exec_raw(
			"hyprctl keyword monitor eDP-1,disable; hyprctl keyword monitor HDMI-A-1,1920x1080@120,auto,auto"
		),
	},
}

for _, b in ipairs(binds) do
	hl.bind(b.key, b.action, b.opts)
end
