local wezterm = require("wezterm")

local config = {}

if wezterm.config_builder then
    config = wezterm.config_builder()
end

config.default_prog = { "tmux" }
config.front_end = "WebGpu"
config.term = "wezterm"
config.audible_bell = "Disabled"
config.font = wezterm.font "Iosevka Nerd Font"
config.color_scheme = "catppuccin-mocha"
config.hide_tab_bar_if_only_one_tab = true
config.background = {
    {
        source = {
            File = os.getenv("XDG_CONFIG_HOME") .. "/wezterm" .. "/rcw-106.jpg",
        },
        opacity = 0.025,
    },
}

return config
