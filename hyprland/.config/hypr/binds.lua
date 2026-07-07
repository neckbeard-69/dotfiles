local terminal = "ghostty"
local browser = "brave"
local menu = "dms ipc call spotlight toggle"
local file_manager = "nautilus"
local main_mod = "SUPER"
local exec = hl.dsp.exec_cmd
local bind = hl.bind

-- Basic Launchers & Window Management
bind(main_mod .. " + Return", exec(terminal))
bind(main_mod .. " + q", hl.dsp.window.close())
bind(main_mod .. " + m", hl.dsp.window.fullscreen())
bind(main_mod .. " + b", exec(browser))
bind(main_mod .. " + f", exec(file_manager))
bind(main_mod .. " + Space", exec(menu))
bind(main_mod .. " + SHIFT + e",
	hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"))
bind(main_mod .. " + SHIFT + v", hl.dsp.window.float())

-- System & Utilities
bind("SUPER + SHIFT + r", hl.dsp.exec_raw("hyprctl reload"))
bind(main_mod .. " + c", hl.dsp.exec_raw("dms color pick -a"))
bind("Print", exec("~/dotfiles/.bin/screenshot --edit"))
bind(main_mod .. " + s", exec("~/dotfiles/.bin/screenshot"))
bind("SUPER + SHIFT + b", exec("gammastep -l 0:0 -O 4500:4500"))

-- Dwindle / Layout Controls
bind(main_mod .. " + p", hl.dsp.exec_raw("hyprctl dispatch pseudo"))
bind(main_mod .. " + j", hl.dsp.exec_raw("hyprctl dispatch togglesplit"))

-- Monitor Switching Logic
bind("SUPER + SHIFT + x",
	hl.dsp.exec_raw("hyprctl keyword monitor eDP-1,disable; hyprctl keyword monitor HDMI-A-1,1920x1080@120,auto,auto"))

-- Focus Movement
-- bind(main_mod .. " + h", hl.dsp.focus({ direction = "left" }))
-- bind(main_mod .. " + l", hl.dsp.focus({ direction = "right" }))
-- bind(main_mod .. " + k", hl.dsp.focus({ direction = "up" }))
-- bind(main_mod .. " + j", hl.dsp.focus({ direction = "down" }))

-- Window Swapping
bind(main_mod .. " + SHIFT + h", hl.dsp.window.move({ direction = "left" }))
bind(main_mod .. " + SHIFT + l", hl.dsp.window.move({ direction = "right" }))
bind(main_mod .. " + SHIFT + k", hl.dsp.window.move({ direction = "up" }))
bind(main_mod .. " + SHIFT + j", hl.dsp.window.move({ direction = "down" }))

-- Group / Tab Controls
bind(main_mod .. " + w", hl.dsp.group.toggle())
-- Reusing h/l for group cycling as per your original config
bind(main_mod .. " + h", hl.dsp.group.prev())
bind(main_mod .. " + l", hl.dsp.group.next())


-- Multimedia Keys
hl.bind("XF86AudioRaiseVolume", exec("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),
	{ locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", exec("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { locked = true, repeating = true })
hl.bind("f4", exec("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), { locked = true, repeating = true })
hl.bind("XF86AudioMute", exec("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true })
hl.bind("XF86MonBrightnessUp", exec("brightnessctl s 10%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", exec("brightnessctl s 10%-"), { locked = true, repeating = true })

-- Media Player Controls
hl.bind("XF86AudioNext", exec("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", exec("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", exec("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", exec("playerctl previous"), { locked = true })

-- Workspaces 1-10
for i = 1, 10 do
	local key = i % 10
	bind(main_mod .. " + " .. key, hl.dsp.focus({ workspace = i }))
	bind(main_mod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end
hl.bind(main_mod .. "+ period", hl.dsp.layout("move +col"))
hl.bind(main_mod .. "+ comma", hl.dsp.layout("move -col"))

hl.bind(main_mod .. " + l", hl.dsp.layout("focus r"))
hl.bind(main_mod .. " + h", hl.dsp.layout("focus l"))
