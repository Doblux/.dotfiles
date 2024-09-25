-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

config.window_background_opacity = 0.9

-- This is where you actually apply your config choices
config.keys = {
  -- Turn off the default CMD-m Hide action, allowing CMD-m to
  -- be potentially recognized and handled by the tab
  {
    key = '1',
    mods = 'ALT',
    action = wezterm.action.ActivateTab(0),
  },
  {
    key = '2',
    mods = 'ALT',
    action = wezterm.action.ActivateTab(1),
  },
  {
    key = '3',
    mods = 'ALT',
    action = wezterm.action.ActivateTab(2),
  },
  {
    key = '4',
    mods = 'ALT',
    action = wezterm.action.ActivateTab(3),
  },
  {
    key = '5',
    mods = 'ALT',
    action = wezterm.action.ActivateTab(4),
  },
  {
    key = '6',
    mods = 'ALT',
    action = wezterm.action.ActivateTab(5),
  },
  {
    key = '7',
    mods = 'ALT',
    action = wezterm.action.ActivateTab(6),
  },
  {
    key = '8',
    mods = 'ALT',
    action = wezterm.action.ActivateTab(7),
  },
  {
    key = '9',
    mods = 'ALT',
    action = wezterm.action.ActivateTab(8),
  },
  {
    key = '0',
    mods = 'ALT',
    action = wezterm.action.ActivateTab(9),
  },
}

-- Set background to same color as neovim
--config.colors = {}
--config.colors.background = '#111111'
config.color_scheme = 'GruvboxDarkHard'

config.font = wezterm.font_with_fallback {
  'IosevkaTerm Nerd Font',
}
config.font_size = 15.0


-- default is true, has more "native" look
config.use_fancy_tab_bar = false

-- I don't like putting anything at the ege if I can help it.
config.enable_scroll_bar = false
config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}

config.tab_bar_at_bottom = true
config.freetype_load_target = "HorizontalLcd"

-- and finally, return the configuration to wezterm
return config
