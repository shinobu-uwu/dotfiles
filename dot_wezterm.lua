local wezterm = require("wezterm")

local config = {}

local process_icons = {
	["docker"] = {
		{ Text = wezterm.nerdfonts.linux_docker },
	},
	["docker-compose"] = {
		{ Text = wezterm.nerdfonts.linux_docker },
	},
	["kuberlr"] = {
		{ Text = wezterm.nerdfonts.linux_docker },
	},
	["kubectl"] = {
		{ Text = wezterm.nerdfonts.linux_docker },
	},
	["nvim"] = {
		{ Text = wezterm.nerdfonts.custom_vim },
	},
	["vim"] = {
		{ Text = wezterm.nerdfonts.dev_vim },
	},
	["node"] = {
		{ Text = wezterm.nerdfonts.mdi_hexagon },
	},
	["zsh"] = {
		{ Text = wezterm.nerdfonts.cod_terminal },
	},
	["bash"] = {
		{ Text = wezterm.nerdfonts.cod_terminal_bash },
	},
	["btm"] = {
		{ Text = wezterm.nerdfonts.mdi_chart_donut_variant },
	},
	["htop"] = {
		{ Text = wezterm.nerdfonts.mdi_chart_donut_variant },
	},
	["cargo"] = {
		{ Text = wezterm.nerdfonts.dev_rust },
	},
	["go"] = {
		{ Text = wezterm.nerdfonts.mdi_language_go },
	},
	["lazydocker"] = {
		{ Text = wezterm.nerdfonts.linux_docker },
	},
	["git"] = {
		{ Text = wezterm.nerdfonts.dev_git },
	},
	["lua"] = {
		{ Text = wezterm.nerdfonts.seti_lua },
	},
	["wget"] = {
		{ Text = wezterm.nerdfonts.mdi_arrow_down_box },
	},
	["curl"] = {
		{ Text = wezterm.nerdfonts.mdi_flattr },
	},
	["gh"] = {
		{ Text = wezterm.nerdfonts.dev_github_badge },
	},
	["python"] = {
		{ Text = wezterm.nerdfonts.dev_python },
	},
	["python3"] = {
		{ Text = wezterm.nerdfonts.dev_python },
	},
	["ruby"] = {
		{ Text = wezterm.nerdfonts.dev_ruby },
	},
	["beam.smp"] = {
		{ Text = wezterm.nerdfonts.custom_elixir },
	},
	["elixir"] = {
		{ Text = wezterm.nerdfonts.custom_elixir },
	},
}

local function get_current_working_dir(tab)
	local current_dir = tab.active_pane.current_working_dir
	local HOME_DIR = string.format("file://%s", os.getenv("HOME"))

	if current_dir == HOME_DIR then
		return "~"
	end

	return string.gsub(current_dir, "(.*[/\\])(.*)", "%2")
end

local function get_process(tab)
	local process_name = string.gsub(tab.active_pane.foreground_process_name, "(.*[/\\])(.*)", "%2")
	if string.find(process_name, "kubectl") then
		process_name = "kubectl"
	end

	return wezterm.format(process_icons[process_name] or { { Text = string.format("%s:", process_name) } })
end

if wezterm.config_builder then
	config = wezterm.config_builder()
end

config.color_scheme = "Catppuccin Macchiato"
config.font = wezterm.font({
	family = "JetBrains Mono Nerd Font",
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

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
	local has_unseen_output = false
	if not tab.is_active then
		for _, pane in ipairs(tab.panes) do
			if pane.has_unseen_output then
				has_unseen_output = true
				break
			end
		end
	end

	local title = string.format("%s  %s", get_process(tab), get_current_working_dir(tab))

	if tab.active_pane.is_zoomed then
		title = title .. " " .. wezterm.nerdfonts.md_alpha_z_box
	end

	if has_unseen_output then
		return {
			{ Foreground = { Color = "#bb9af7" } },
			{ Text = title },
		}
	end

	return {
		{ Text = title },
	}
end)

wezterm.on("update-status", function(window, pane)
	if window:active_key_table() == "copy_mode" then
		window:set_right_status(wezterm.format({
			{ Foreground = { Color = "#bb9af7" } },
			{ Background = { Color = "#222436" } },
			{ Text = wezterm.nerdfonts.oct_copy .. "  COPY  " },
		}))
	else
		window:set_right_status("")
	end
end)

config.hyperlink_rules = wezterm.default_hyperlink_rules()
-- make username/project paths clickable. this implies paths like the following are for github.
-- ( "nvim-treesitter/nvim-treesitter" | wbthomason/packer.nvim | wez/wezterm | "wez/wezterm.git" )
-- as long as a full url hyperlink regex exists above this it should not match a full url to
-- github or gitlab / bitbucket (i.e. https://gitlab.com/user/project.git is still a whole clickable url)
table.insert(config.hyperlink_rules, {
	regex = [[["'\s]([\w\d]{1}[-\w\d]+)(/){1}([-\w\d\.]+)["'\s]] .. "]",
	format = "https://www.github.com/$1/$3",
})

wezterm.on("gui-startup", function(cmd) -- set startup Window position
	local tab, pane, window = wezterm.mux.spawn_window(cmd or {})
	window:gui_window():set_position(60, 60)
end)

return config
