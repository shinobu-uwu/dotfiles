local wezterm = require("wezterm")

local config = {}

if wezterm.config_builder then
	config = wezterm.config_builder()
end

config.color_scheme = "Catppuccin Macchiato"
config.font = wezterm.font({
	family = "JetBrains Mono",
	harfbuzz_features = { "calt=0", "clig=0", "liga=0" },
})
config.font_size = 14.0
config.freetype_load_target = "Light"
config.keys = {
	{
		key = "Enter",
		mods = "ALT",
		action = wezterm.action.DisableDefaultAssignment,
	},
	{
		key = "t",
		mods = "CTRL",
		action = wezterm.action.SpawnTab("DefaultDomain"),
	},
	{
		key = "w",
		mods = "CTRL",
		action = wezterm.action.CloseCurrentTab({ confirm = false }),
	},
}

for i = 1, 8 do
	-- CTRL + number to move to that position
	table.insert(config.keys, {
		key = tostring(i),
		mods = "CTRL",
		action = wezterm.action.ActivateTab(i - 1),
	})
	table.insert(config.keys, {
		key = tostring(i),
		mods = "CTRL|SHIFT",
		action = wezterm.action.MoveTab(i - 1),
	})
end

config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}
config.enable_scroll_bar = true
return config
