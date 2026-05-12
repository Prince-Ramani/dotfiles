hl.monitor({
        output   = "eDP-1",
        mode     = "1920x1080@60",
        position = "0x0",
        scale    = "1",
})


local terminal    = "alacritty"
local fileManager = "thunar"


hl.on("hyprland.start", function()
        hl.exec_cmd("mako")
        hl.exec_cmd(terminal)
        hl.exec_cmd("$HOME/.config/hypr/utils/wall.sh")
        hl.exec_cmd("$HOME/.config/hypr/utils/battery.sh")
        hl.exec_cmd("$HOME/.config/hypr/utils/eye.sh")
end)


hl.bind("SUPER + SHIFT + B", hl.dsp.exec_cmd("$HOME/.config/hypr/utils/toggle-waybar.sh"))
hl.bind("SUPER + SHIFT + Print", hl.dsp.exec_cmd("$HOME/.config/hypr/utils/screenshot.sh"))
hl.bind("SUPER + SHIFT + Backspace", hl.dsp.exec_cmd("$HOME/.config/hypr/utils/toggle-bluelight.sh"))


hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

hl.config({
        general = {
                gaps_in          = 7,
                gaps_out         = 6,

                border_size      = 2,

                col              = {
                        active_border   = "rgba(88c0d0ff)",
                        inactive_border = "rgba(3a3a3aff)",
                },

                resize_on_border = false,
                allow_tearing    = false,
                layout           = "dwindle",
        },

        decoration = {
                rounding         = 4,
                rounding_power   = 2,

                active_opacity   = 1.0,
                inactive_opacity = 1.0,

                shadow           = {
                        enabled = false,
                },

                blur             = {
                        enabled = false,
                        --size      = 4,
                        --passes    = 1,
                        --vibrancy  = 0.1696,
                },
        },

        animations = {
                enabled = false,
        },
})

-- "Smart gaps"

hl.workspace_rule({ workspace = "w[tv1]", gaps_out = 0, gaps_in = 0 })
hl.workspace_rule({ workspace = "f[1]", gaps_out = 0, gaps_in = 0 })
hl.window_rule({
        name        = "no-gaps-wtv1",
        match       = { float = false, workspace = "w[tv1]" },
        border_size = 0,
        rounding    = 0,
})
hl.window_rule({
        name        = "no-gaps-f1",
        match       = { float = false, workspace = "f[1]" },
        border_size = 0,
        rounding    = 0,
})

hl.config({
        dwindle = {
                preserve_split = true,
        },
})

hl.config({
        master = {
                new_status = "master",
        },
})


hl.config({
        misc = {
                force_default_wallpaper   = 0,
                disable_hyprland_logo     = true,
                disable_splash_rendering  = true,
                on_focus_under_fullscreen = false
        },
})


--input
hl.config({
        input = {
                kb_layout    = "us",
                kb_variant   = "",
                kb_model     = "",
                kb_options   = "caps:escape",
                kb_rules     = "",

                follow_mouse = 1,

                sensitivity  = 0,

                touchpad     = {
                        natural_scroll = false,
                },
        },
})



hl.bind("SUPER + SHIFT + E",
        hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"))
hl.bind("SUPER + Q", hl.dsp.window.close())
hl.bind("SUPER + f", hl.dsp.window.fullscreen())
hl.bind("SUPER + V", hl.dsp.layout("preselect b"))
hl.bind("SUPER + H", hl.dsp.layout("preselect r"))
hl.bind("SUPER + f", hl.dsp.window.fullscreen())

hl.bind("SUPER + RETURN", hl.dsp.exec_cmd(terminal))
hl.bind("SUPER + D", hl.dsp.exec_cmd("rofi -show drun"))
hl.bind("SUPER + SHIFT + W", hl.dsp.exec_cmd("$HOME/.config/hypr/utils/wallpaper-picker.sh"))


for i = 1, 10 do
        local key = i % 10
        hl.bind("SUPER + " .. key, hl.dsp.focus({ workspace = i }))
        hl.bind("SUPER + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

hl.bind("SUPER + H", hl.dsp.focus({ direction = "left" }))
hl.bind("SUPER + L", hl.dsp.focus({ direction = "right" }))
hl.bind("SUPER + K", hl.dsp.focus({ direction = "up" }))
hl.bind("SUPER + J", hl.dsp.focus({ direction = "down" }))


hl.bind("SUPER + SHIFT + H", hl.dsp.window.swap({ direction = "left" }))
hl.bind("SUPER + SHIFT + L", hl.dsp.window.swap({ direction = "right" }))
hl.bind("SUPER + SHIFT + K", hl.dsp.window.swap({ direction = "up" }))
hl.bind("SUPER + SHIFT + J", hl.dsp.window.swap({ direction = "down" }))


hl.bind("SUPER + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind("SUPER + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

hl.bind("SUPER + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind("SUPER + mouse:273", hl.dsp.window.resize(), { mouse = true })

hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("$HOME/.config/hypr/utils/volume.sh up"),
        { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("$HOME/.config/hypr/utils/volume.sh down"),
        { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("$HOME/.config/hypr/utils/volume.sh mute"),
        { locked = true, repeating = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
        { locked = true, repeating = true })

hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("$HOME/.config/hypr/utils/brightness.sh up"),
        { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("$HOME/.config/hypr/utils/brightness.sh down"),
        { locked = true, repeating = true })


local suppressMaximizeRule = hl.window_rule({
        name           = "suppress-maximize-events",
        match          = { class = ".*" },

        suppress_event = "maximize",
})

hl.window_rule({
        name     = "fix-xwayland-drags",
        match    = {
                class      = "^$",
                title      = "^$",
                xwayland   = true,
                float      = true,
                fullscreen = false,
                pin        = false,
        },

        no_focus = true,
})


hl.window_rule({
        name  = "move-hyprland-run",
        match = { class = "hyprland-run" },

        move  = "20 monitor_h-120",
        float = true,
})
