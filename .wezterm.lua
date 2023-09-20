local wezterm = require("wezterm")

local config = {}

if wezterm.config_builder then
    config = wezterm.config_builder()
end

config.term = "wezterm"
config.audible_bell = "Disabled"
config.font = wezterm.font "CaskaydiaCove Nerd Font"
config.color_scheme = "rose-pine"
config.hide_tab_bar_if_only_one_tab = true
config.window_background_image = os.getenv("DOTFILES") .. "/rcw-106.jpg"
config.window_background_opacity = 0.125

return config
