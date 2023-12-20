local wezterm = require("wezterm")

local config = {}

if wezterm.config_builder then
    config = wezterm.config_builder()
end

config.default_prog = { "tmux-with-config" }
config.term = "wezterm"
config.audible_bell = "Disabled"
config.font = wezterm.font "CaskaydiaCove Nerd Font"
-- config.color_scheme = "rose-pine"
local bg = "#0D0800"
local fg = "#FFA6A6"
config.colors = {
    background = bg,
    foreground = fg,

    cursor_bg = "#FFC3A6",
    cursor_fg = "#0F0D00",
    cursor_border = "#FFCBB3",

    selection_fg = bg,
    selection_bg = fg,

    scrollbar_thumb = "#331F00",
    split = "#663D00",

    ansi = {
        "#1A0F00",
        "#993D3D",
        "#3D993D",
        "#99993D",
        "#3D3D99",
        "#993D99",
        "#3D9999",
        "#B36F5F",
    },

    brights = {
        "#66381C",
        "#CC2929",
        "#29CC29",
        "#CCCC29",
        "#2929CC",
        "#CC29CC",
        "#29CCCC",
        "#FFCCCC",
    },
}
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
