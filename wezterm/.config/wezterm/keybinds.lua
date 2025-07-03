local wezterm = require("wezterm")
local MOD = "ALT"

wezterm.on("show_tab_bar", function(window, _)
    local overrides = window:get_config_overrides() or {}
    overrides.enable_tab_bar = true
    window:set_config_overrides(overrides)
    wezterm.sleep_ms(2000)
    overrides.enable_tab_bar = false
    window:set_config_overrides(overrides)
end)

local M = {
    {
        key = "c",
        mods = MOD,
        action = wezterm.action.SpawnTab("CurrentPaneDomain"),
    },
    {
        key = "q",
        mods = MOD,
        action = wezterm.action.CloseCurrentTab({ confirm = true }),
    },
    {
        key = "J",
        mods = MOD,
        action = wezterm.action.ActivateTabRelative(1),
    },
    {
        key = "K",
        mods = MOD,
        action = wezterm.action.ActivateTabRelative(-1),
    },
    {
        key = "H",
        mods = MOD,
        action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
    },
    {
        key = "V",
        mods = MOD,
        action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
    },
    {
        key = "h",
        mods = MOD,
        action = wezterm.action.ActivatePaneDirection("Left"),
    },
    {
        key = "l",
        mods = MOD,
        action = wezterm.action.ActivatePaneDirection("Right"),
    },
    {
        key = "k",
        mods = MOD,
        action = wezterm.action.ActivatePaneDirection("Up"),
    },
    {
        key = "j",
        mods = MOD,
        action = wezterm.action.ActivatePaneDirection("Down"),
    },
    {
        key = 'Space',
        mods = 'CTRL|ALT',
        action = wezterm.action.ActivateCopyMode,
    },
    {
        key = "s",
        mods = MOD,
        action = wezterm.action.EmitEvent("show_tab_bar"),
    },
    {
        key = "R",
        mods = MOD,
        action = wezterm.action.PromptInputLine({
            description = "Enter new tab name",
            action = wezterm.action_callback(function(window, _, line)
                if line then
                    window:active_tab():set_title(line)
                end
            end),
        }),
    },
}
for i = 1, 8 do
    table.insert(M, {
        key = tostring(i),
        mods = MOD,
        action = wezterm.action.ActivateTab(i - 1),
    })
end
return M
