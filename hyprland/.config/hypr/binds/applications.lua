local exec = hl.dsp.exec_cmd

local main_mod = "SUPER"
local terminal = "ghostty"
local browser = "brave"
local file_manager = "nautilus"
local launcher = "dms ipc call spotlight toggle"

---@type Bind[]
local binds = {
	{ key = main_mod .. " + Return", action = exec(terminal) },
	{ key = main_mod .. " + b",      action = exec(browser) },
	{ key = main_mod .. " + f",      action = exec(file_manager) },
	{ key = main_mod .. " + Space",  action = exec(launcher) },
}

for _, b in ipairs(binds) do
	hl.bind(b.key, b.action, b.opts)
end
