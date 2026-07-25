local exec = hl.dsp.exec_cmd

---@type Bind[]
local binds = {
	{
		key = "XF86AudioRaiseVolume",
		action = exec("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),
		opts = { locked = true, repeating = true },
	},
	{
		key = "XF86AudioLowerVolume",
		action = exec("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
		opts = { locked = true, repeating = true },
	},
	{
		key = "XF86AudioMute",
		action = exec("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
		opts = { locked = true },
	},
	{
		key = "F4",
		action = exec("dms ipc call audio micmute"),
		opts = { locked = true, repeating = true },
	},
	{
		key = "XF86MonBrightnessUp",
		action = exec("brightnessctl s 10%+"),
		opts = { locked = true, repeating = true },
	},
	{
		key = "XF86MonBrightnessDown",
		action = exec("brightnessctl s 10%-"),
		opts = { locked = true, repeating = true },
	},
	{ key = "XF86AudioNext",  action = exec("playerctl next"),       opts = { locked = true } },
	{ key = "XF86AudioPrev",  action = exec("playerctl previous"),   opts = { locked = true } },
	{ key = "XF86AudioPlay",  action = exec("playerctl play-pause"), opts = { locked = true } },
	{ key = "XF86AudioPause", action = exec("playerctl play-pause"), opts = { locked = true } },
}

for _, b in ipairs(binds) do
	hl.bind(b.key, b.action, b.opts)
end
