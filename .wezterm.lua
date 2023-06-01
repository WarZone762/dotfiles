local wezterm = require("wezterm")

local config = {}

if wezterm.config_builder then
    config = wezterm.config_builder()
end

config.audible_bell = "Disabled"
config.font = wezterm.font "CaskaydiaCove Nerd Font"
config.color_scheme = "rose-pine"
config.hide_tab_bar_if_only_one_tab = true
config.window_background_image = os.getenv("DOTFILES_DIR") .. "/milky-way.jpg"
config.window_background_image_hsb = {
    brightness = 0.25,
    hue = 1.0,
    saturation = 1.0,
}

return config
