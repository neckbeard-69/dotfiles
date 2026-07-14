---@type Env[]
local env_vars = {
	{ key = "XDG_CURRENT_DESKTOP", value = "Hyprland" },
	{ key = "HYPRCURSOR_THEME",    value = "Adwaita" },
	{ key = "XCURSOR_THEME",       value = "Adwaita" },
	{ key = "HYPRCURSOR_SIZE",     value = "24" },
	{ key = "XCURSOR_SIZE",        value = "24" },
}

for _, var in ipairs(env_vars) do
	hl.env(var.key, var.value)
end
