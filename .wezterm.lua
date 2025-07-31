-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()
local act = wezterm.action

config = {
    window_close_confirmation = "NeverPrompt",
    -- Set the default font to use
    font = wezterm.font('JetBrainsMono Nerd Font'),
    font_size = 12.0,
    color_scheme = 'Tokyo Night',
    default_cursor_style = 'SteadyBar',
    -- Enable tab bar
    window_background_opacity = 0.9,

    -- ! Ctrl+Shift+F will search case-INSENSITIVELY in the terminal
    keys = {{
        key = 'F',
        mods = 'CTRL|SHIFT',
        action = act.Search({
            CaseInSensitiveString = ''
        })
    }, {
        key = 'Backspace',
        mods = 'CTRL',
        action = act.SendKey {
            key = 'w',
            mods = 'CTRL'
        }
    }}
}

-- Finally, return the configuration to wezterm:
return config
