local exec = hl.dsp.exec_cmd

local main_mod = "SUPER"

---@type Bind[]
local binds = {
	{ key = main_mod .. " + q",         action = hl.dsp.window.close() },
	{ key = main_mod .. " + m",         action = hl.dsp.window.fullscreen() },
	{ key = main_mod .. " + SHIFT + v", action = hl.dsp.window.float() },

	{
		key = main_mod .. " + SHIFT + e",
		action = exec("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"),
	},

	{ key = main_mod .. " + p",         action = hl.dsp.exec_raw("hyprctl dispatch pseudo") },
	{ key = main_mod .. " + j",         action = hl.dsp.exec_raw("hyprctl dispatch togglesplit") },

	{ key = main_mod .. "+ period",     action = hl.dsp.layout("move +col") },
	{ key = main_mod .. "+ comma",      action = hl.dsp.layout("move -col") },
	{ key = main_mod .. " + equal",     action = hl.dsp.layout("colresize 1.0") },
	{ key = main_mod .. " + minus",     action = hl.dsp.layout("colresize 0.5") },

	{ key = main_mod .. " + h",         action = hl.dsp.layout("focus l") },
	{ key = main_mod .. " + l",         action = hl.dsp.layout("focus r") },

	{ key = main_mod .. " + w",         action = hl.dsp.group.toggle() },

	{ key = main_mod .. " + SHIFT + h", action = hl.dsp.window.move({ direction = "left" }) },
	{ key = main_mod .. " + SHIFT + l", action = hl.dsp.window.move({ direction = "right" }) },
	{ key = main_mod .. " + SHIFT + k", action = hl.dsp.window.move({ direction = "up" }) },
	{ key = main_mod .. " + SHIFT + j", action = hl.dsp.window.move({ direction = "down" }) },
}

for _, b in ipairs(binds) do
	hl.bind(b.key, b.action, b.opts)
end

for i = 1, 10 do
	local key = i % 10
	hl.bind(main_mod .. " + " .. key, hl.dsp.focus({ workspace = i }))
	hl.bind(main_mod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end
