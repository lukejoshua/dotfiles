local wezterm = require("wezterm")

local config = wezterm.config_builder()

--------------
-- WSL ONLY --
--------------
config.default_domain = "WSL:Ubuntu-22.04"
-- config.wsl_domains = wezterm.default_wsl_domains()
---------------
-- /WSL ONLY --
---------------

-- config.default_prog = { "fish" }

config.font = wezterm.font("JetBrains Mono")
config.color_scheme = "Tokyo Night"

config.window_background_gradient = {
	orientation = "Vertical",
	colors = {
		"#222436",
		"#1E2030",
		"#1a1b26",
		"#16161e",
		"#0C0E14",
		"#0C0E14",
		"#0C0E14",
		"#16161e",
		"#1a1b26",
		"#1E2030",
		"#222436",
	},
	--
	-- colors = {
	-- 	"#0C0E14",
	-- 	"#16161e",
	-- 	"#1a1b26",
	-- 	"#1E2030",
	--
	-- 	"#222436",
	--
	-- 	"#1E2030",
	-- 	"#1a1b26",
	-- 	"#16161e",
	-- 	"#0C0E14",
	-- },
}

-- config.background = {
-- 	{
-- 		source = {
-- 			File = "/Users/luke.joshua/Downloads/abstract-gradient-swirl.jpg",
-- 		},
-- 		attachment = {
-- 			Parallax = 0.01,
-- 		},
-- 		vertical_align = "Middle",
-- 		horizontal_align = "Center",
-- 		repeat_x = "Mirror",
-- 		repeat_y = "Mirror",
-- 		hsb = {
-- 			-- saturation = 0.5,
-- 		},
-- 		opacity = 0.05,
-- 	},
-- }
--
-- config.window_background_opacity = 1
-- config.macos_window_background_blur = 20

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
		tabline_b = { "workspace" },
		tabline_c = { " " },
		tab_active = {
			"index",
			{ "parent", padding = 0 },
			"/",
			{ "cwd", padding = { left = 0, right = 1 } },
			{ "zoomed", padding = 0 },
		},
		tab_inactive = { "index", { "process", padding = { left = 0, right = 1 } } },
		tabline_x = { "ram", "cpu" },
		tabline_y = { "datetime", "battery" },
		tabline_z = { "domain" },
	},
})

tabline.apply_to_config(config)

return config
