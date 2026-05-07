local terminal = "ghostty"
local browser = "zen-browser"
local menu = "dms ipc call spotlight toggle"
local file_manager = "nautilus"
local main_mod = "SUPER"
local exec = hl.dsp.exec_cmd
local bind = hl.bind

bind(main_mod .. " + Return", exec(terminal))
bind(main_mod .. " + q", hl.dsp.window.kill())
bind(main_mod .. " + m", hl.dsp.window.fullscreen())
bind(main_mod .. " + b", exec(browser))
bind(main_mod .. " + f", exec(file_manager))
bind(main_mod .. " + Space", exec(menu))
bind("SUPER_SHIFT" .. " + v", hl.dsp.window.float())
bind("SUPER_SHIFT" .. " + r", hl.dsp.exec_raw("bash -c hyprctl reload"))
bind("SUPER_SHIFT" .. " + c", hl.dsp.exec_raw("bash -c dms color pick -a"))
bind("SUPER_SHIFT" .. " + h", hl.dsp.focus({ direction = "left" }))
bind("SUPER_SHIFT" .. " + l", hl.dsp.focus({ direction = "right" }))
bind("SUPER_SHIFT" .. " + j", hl.dsp.focus({ direction = "down" }))
bind("SUPER_SHIFT" .. " + k", hl.dsp.focus({ direction = "up" }))

for i = 1, 10 do
	local key = i % 10
	bind(main_mod .. " + " .. key, hl.dsp.focus({ workspace = i }))
	bind(main_mod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end
