local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- WSL ONLY
config.default_domain = "WSL:Ubuntu-22.04"

-- config.default_prog = { "fish" }

config.font = wezterm.font("JetBrains Mono")
config.color_scheme = "Tokyo Night"

config.window_background_gradient = {
	orientation = "Vertical",
	colors = {
		"#1a1b26",
		"#16161e",
		"#0C0E14",
		"#0C0E14",
		"#0C0E14",
		"#16161e",
		"#1a1b26",
	},
}

config.tab_bar_at_bottom = true

config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}

config.animation_fps = 120
config.max_fps = 120

config.window_decorations = "RESIZE"

config.quick_select_alphabet = "arstqwfpzxcvneioluymdhgjbk"

local tabline = wezterm.plugin.require("https://github.com/michaelbrusegard/tabline.wez")
tabline.setup({
	options = {
		section_separators = {
			left = wezterm.nerdfonts.pl_left_hard_divider,
			right = wezterm.nerdfonts.pl_right_hard_divider,
		},
		component_separators = {
			left = wezterm.nerdfonts.pl_left_soft_divider,
			right = wezterm.nerdfonts.pl_right_soft_divider,
		},
		tab_separators = {
			left = wezterm.nerdfonts.pl_left_hard_divider,
			right = wezterm.nerdfonts.pl_right_hard_divider,
		},
	},
	sections = {
		tabline_a = { "mode" },
		tabline_b = {},
		tabline_c = {},
		tab_active = {
			"index",
			-- { "parent", padding = 0 },
			-- "/",
			-- { "cwd", padding = { left = 0, right = 1 } },
			"tab",
			{ "zoomed", padding = 0 },
			"output",
		},
		tab_inactive = { "index", { "process", padding = { left = 0, right = 1 } } },
		tabline_x = { " " },
		tabline_y = { "window" },
		tabline_z = { "workspace" },
	},
})

tabline.apply_to_config(config)

return config
