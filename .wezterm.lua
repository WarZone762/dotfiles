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
config.background = {
    {
        source = {
            File = os.getenv("DOTFILES") .. "/rcw-106.jpg",
        },
        opacity = 0.125,
    },
    {
        source = {
            File = os.getenv("DOTFILES") .. "/posture-ironic.jpg",
        },
        height = "750",
        width = "750",
        hsb = {
            brightness = 0.02,
        },
        horizontal_align = "Right",
        vertical_align = "Middle",
        horizontal_offset = "-50px",
        repeat_x = "NoRepeat",
        repeat_y = "NoRepeat",
    },
}

return config
