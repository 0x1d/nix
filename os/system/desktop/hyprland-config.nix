{ pkgs, ... }: {
  # Create Hyprland configuration directory and files
  environment.etc."xdg/hypr/hyprland.conf".text = ''
    # Hyprland Configuration
    # This is a basic configuration that you can customize

    # Monitor configuration
    #monitor=,preferred,auto,auto
    monitor = eDP-1, 1920x1080@144, 0x0, 1

    # Execute your favorite apps at startup
    exec-once = waybar
    exec-once = dunst
    exec-once = swww init
    exec-once = wl-paste --watch cliphist store

    # Source a file (multi-file configs)
    # source = ~/.config/hypr/myColors.conf

    # Some default env vars
    env = XCURSOR_SIZE,24
    env = QT_QPA_PLATFORM,wayland

    # For all categories, see https://wiki.hyprland.org/Configuring/Variables/
    input {
        kb_layout = ch
        kb_variant =
        kb_model =
        kb_options =
        kb_rules =

        follow_mouse = 1

        touchpad {
            natural_scroll = no
        }

        sensitivity = 0 # -1.0 - 1.0, 0 means no modification.
    }

    general {
        # See https://wiki.hyprland.org/Configuring/Variables/ for more

        gaps_in = 5
        gaps_out = 20
        border_size = 2
        col.active_border = rgba(33ccffee) rgba(00ff99ee) 45deg
        col.inactive_border = rgba(595959aa)

        layout = dwindle

        # Please see https://wiki.hyprland.org/Configuring/Tearing/ before you turn this on
        allow_tearing = false
    }

    decoration {
        # See https://wiki.hyprland.org/Configuring/Variables/ for more

        rounding = 10
        #blur = yes
        #blur_size = 3
        #blur_passes = 1
        #blur_new_optimizations = on

        #drop_shadow = yes
        #shadow_range = 4
        #shadow_render_power = 3
        #col.shadow = rgba(1a1a1aee)
    }

    animations {
        enabled = yes

        # Some default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more

        bezier = myBezier, 0.05, 0.9, 0.1, 1.05

        animation = windows, 1, 7, myBezier
        animation = windowsOut, 1, 7, default, popin 80%
        animation = border, 1, 10, default
        animation = borderangle, 1, 8, default
        animation = fade, 1, 7, default
        animation = workspaces, 1, 6, default
    }

    dwindle {
        # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
        pseudotile = yes # master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
        preserve_split = yes # you probably want this
    }

    master {
        # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
    }

    gestures {
        # See https://wiki.hyprland.org/Configuring/Variables/ for more
        workspace_swipe = off
    }

    # Example windowrule v1
    # rule to add support for window titles
    # windowrule = noblur,^(kitty)$
    # Example windowrule v2
    # windowrulev2 = float,class:^(Rofi)$,title:^(rofi - Launcher)$
    # See https://wiki.hyprland.org/Configuring/Window-Rules/ for more

    # i3-style keybindings
    # Application launcher and terminal
    bind = SUPER, d, exec, wofi --show drun
    bind = SUPER, RETURN, exec, alacritty
    bind = SUPER, Q, killactive,
    
    # Window management (vim-style + arrow keys)
    bind = SUPER, h, movefocus, l
    bind = SUPER, j, movefocus, d
    bind = SUPER, k, movefocus, u
    bind = SUPER, l, movefocus, r
    bind = SUPER, left, movefocus, l
    bind = SUPER, down, movefocus, d
    bind = SUPER, up, movefocus, u
    bind = SUPER, right, movefocus, r
    
    # Window resizing (vim-style + arrow keys) - Control modifier
    bind = SUPER CTRL, h, resizeactive, -20 0
    bind = SUPER CTRL, j, resizeactive, 0 20
    bind = SUPER CTRL, k, resizeactive, 0 -20
    bind = SUPER CTRL, l, resizeactive, 20 0
    bind = SUPER CTRL, left, resizeactive, -20 0
    bind = SUPER CTRL, down, resizeactive, 0 20
    bind = SUPER CTRL, up, resizeactive, 0 -20
    bind = SUPER CTRL, right, resizeactive, 20 0
    
    # Window moving (vim-style + arrow keys) - Shift modifier
    bind = SUPER SHIFT, h, movewindow, l
    bind = SUPER SHIFT, j, movewindow, d
    bind = SUPER SHIFT, k, movewindow, u
    bind = SUPER SHIFT, l, movewindow, r
    bind = SUPER SHIFT, left, movewindow, l
    bind = SUPER SHIFT, down, movewindow, d
    bind = SUPER SHIFT, up, movewindow, u
    bind = SUPER SHIFT, right, movewindow, r
    
    # Workspace management
    bind = SUPER, 1, workspace, 1
    bind = SUPER, 2, workspace, 2
    bind = SUPER, 3, workspace, 3
    bind = SUPER, 4, workspace, 4
    bind = SUPER, 5, workspace, 5
    bind = SUPER, 6, workspace, 6
    bind = SUPER, 7, workspace, 7
    bind = SUPER, 8, workspace, 8
    bind = SUPER, 9, workspace, 9
    bind = SUPER, 0, workspace, 10
    
    # Move windows to workspaces
    bind = SUPER SHIFT, 1, movetoworkspace, 1
    bind = SUPER SHIFT, 2, movetoworkspace, 2
    bind = SUPER SHIFT, 3, movetoworkspace, 3
    bind = SUPER SHIFT, 4, movetoworkspace, 4
    bind = SUPER SHIFT, 5, movetoworkspace, 5
    bind = SUPER SHIFT, 6, movetoworkspace, 6
    bind = SUPER SHIFT, 7, movetoworkspace, 7
    bind = SUPER SHIFT, 8, movetoworkspace, 8
    bind = SUPER SHIFT, 9, movetoworkspace, 9
    bind = SUPER SHIFT, 0, movetoworkspace, 10
    
    # Layout controls
    #bind = SUPER, f, fullscreen, 1
    #bind = SUPER, SHIFT, f, fullscreen, 0
    bind = SUPER, v, togglefloating,
    bind = SUPER, s, togglesplit, # dwindle
    
    # Exit and reload
    bind = SUPER SHIFT, q, killactive,
    bind = SUPER SHIFT, r, exec, hyprctl reload
    
    # Screenshot
    bind = SUPER, p, exec, grim -g "$(slurp)" - | wl-copy
    
    # Volume control
    bind = , XF86AudioRaiseVolume, exec, pactl set-sink-volume @DEFAULT_SINK@ +5%
    bind = , XF86AudioLowerVolume, exec, pactl set-sink-volume @DEFAULT_SINK@ -5%
    bind = , XF86AudioMute, exec, pactl set-sink-mute @DEFAULT_SINK@ toggle
    
    # Brightness control
    bind = , XF86MonBrightnessUp, exec, brightnessctl set +5%
    bind = , XF86MonBrightnessDown, exec, brightnessctl set 5%-
    
    # Mouse bindings for window management
    bindm = SUPER, mouse:272, movewindow
    bindm = SUPER, mouse:273, resizewindow
  '';

  # Create Waybar configuration
  environment.etc."xdg/waybar/config".text = ''
    {
        // "layer": "top", // Waybar at top layer
        // "position": "bottom", // Waybar position (top|bottom|left|right)
        "height": 30, // Waybar height (to be removed for auto height)
        // "width": 1280, // Waybar width
        "spacing": 4, // Gaps between modules (4px)
        // Choose the order of the modules
        "modules-left": ["hyprland/workspaces","hyprland/window", "hyprland/mode", "hyprland/scratchpad", "custom/media"],
        //"modules-center": ["hyprland/window"],
        "modules-right": ["pulseaudio", "network", "cpu", "memory", "temperature", "backlight", "battery", "battery#bat2", "clock", "tray"],
        // Modules configuration
        // "hyprland/workspaces": {
        //     "disable-scroll": true,
        //     "all-outputs": true,
        //     "warp-on-scroll": false,
        //     "format": "{icon}",
        //     //"format": "{name}: {icon}",
        //     "format-icons": {
        //         "1": "",
        //         "2": "",
        //         "3": "",
        //         "4": "",
        //         "5": "",
        //         "urgent": "",
        //         "focused": "",
        //         "default": ""
        //     }
        // },
        "keyboard-state": {
            "numlock": true,
            "capslock": true,
            "format": "{name} {icon}",
            "format-icons": {
                "locked": "",
                "unlocked": ""
            }
        },

        "hyprland/mode": {
            "format": "<span style=\"italic\">{}</span>"
        },
        "hyprland/scratchpad": {
            "format": "{icon} {count}",
            "show-empty": false,
            "format-icons": ["", ""],
            "tooltip": true,
            "tooltip-format": "{app}: {title}"
        },
        "mpd": {
            "format": "{stateIcon} {consumeIcon}{randomIcon}{repeatIcon}{singleIcon}{artist} - {album} - {title} ({elapsedTime:%M:%S}/{totalTime:%M:%S}) ⸨{songPosition}|{queueLength}⸩ {volume}% ",
            "format-disconnected": "Disconnected ",
            "format-stopped": "{consumeIcon}{randomIcon}{repeatIcon}{singleIcon}Stopped ",
            "unknown-tag": "N/A",
            "interval": 2,
            "consume-icons": {
                "on": " "
            },
            "random-icons": {
                "off": "<span color=\"#f53c3c\"></span> ",
                "on": " "
            },
            "repeat-icons": {
                "on": " "
            },
            "single-icons": {
                "on": "1 "
            },
            "state-icons": {
                "paused": "",
                "playing": ""
            },
            "tooltip-format": "MPD (connected)",
            "tooltip-format-disconnected": "MPD (disconnected)"
        },
        "idle_inhibitor": {
            "format": "{icon}",
            "format-icons": {
                "activated": "",
                "deactivated": ""
            }
        },
        "tray": {
            // "icon-size": 21,
            "spacing": 10
        },
        "clock": {
            // "timezone": "America/New_York",
            "tooltip-format": "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>",
            "format-alt": "{:%Y-%m-%d}"
        },
        "cpu": {
            "format": "{usage}% ",
            "tooltip": false
        },
        "memory": {
            "format": "{}% "
        },
        "temperature": {
            // "thermal-zone": 2,
            // "hwmon-path": "/sys/class/hwmon/hwmon2/temp1_input",
            "critical-threshold": 80,
            // "format-critical": "{temperatureC}°C {icon}",
            "format": "{temperatureC}°C {icon}",
            "format-icons": ["", "", ""]
        },
        "backlight": {
            // "device": "acpi_video1",
            "format": "{percent}% {icon}",
            "format-icons": ["", "", "", "", "", "", "", "", ""]
        },
        "battery": {
            "states": {
                // "good": 95,
                "warning": 30,
                "critical": 15
            },
            "format": "{capacity}% {icon}",
            "format-charging": "{capacity}% ",
            "format-plugged": "{capacity}% ",
            "format-alt": "{time} {icon}",
            // "format-good": "", // An empty format will hide the module
            // "format-full": "",
            "format-icons": ["", "", "", "", ""]
        },
        "battery#bat2": {
            "bat": "BAT2"
        },
        "network": {
            // "interface": "wlp2*", // (Optional) To force the use of this interface
            "format-wifi": "{essid} ({signalStrength}%) ",
            "format-ethernet": "{ipaddr}/{cidr} ",
            "tooltip-format": "{ifname} via {gwaddr} ",
            "format-linked": "{ifname} (No IP) ",
            "format-disconnected": "Disconnected ⚠",
            "format-alt": "{ifname}: {ipaddr}/{cidr}"
        },
        "pulseaudio": {
            // "scroll-step": 1, // %, can be a float
            "format": "{volume}% {icon} {format_source}",
            "format-bluetooth": "{volume}% {icon} {format_source}",
            "format-bluetooth-muted": " {icon} {format_source}",
            "format-muted": " {format_source}",
            "format-source": "{volume}% ",
            "format-source-muted": "",
            "format-icons": {
                "headphone": "",
                "hands-free": "",
                "headset": "",
                "phone": "",
                "portable": "",
                "car": "",
                "default": ["", "", ""]
            },
            "on-click": "pavucontrol"
        },
        "custom/media": {
            "format": "{icon} {}",
            "return-type": "json",
            "max-length": 40,
            "format-icons": {
                "spotify": "",
                "default": "🎜"
            },
            "escape": true,
            "exec": "$HOME/.config/waybar/mediaplayer.py 2> /dev/null" // Script in resources folder
            // "exec": "$HOME/.config/waybar/mediaplayer.py --player spotify 2> /dev/null" // Filter player based on name
        }
    }
  '';

  # Create Waybar style
  environment.etc."xdg/waybar/style.css".text = ''
    * {
        border: none;
        border-radius: 0;
        /*font-family: "Hack", "Noto Color Emoji", sans-serif;*/
        font-size: 12px;
        /*font-weight: bold;*/
        min-height: 0;

    }

    window#waybar {
        /*background: rgba(0,0,0,.2);*/
        background: transparent;
        /*border-bottom: 1px solid rgba(100, 114, 125, 0.5);*/
        color: #e5e9f0;
        margin-bottom: 0px;
        padding-bottom:0px;
    }

    /* https://github.com/Alexays/Waybar/wiki/FAQ#the-workspace-buttons-have-a-strange-hover-effect */
    #workspaces button {
        padding: 5px 5px;
        background: transparent;
        color: #ffffff;
        /*border-bottom: 3px solid transparent;*/
        border-radius: 10px;
    }

    #workspaces button.active {
        /*background: #4c566a;*/
        background: rgba(0,0,0,.5);
        padding: 5px;
        margin: 5px;
        /*border-bottom: 3px solid #e5e9f0;*/
    }

    #workspaces button.urgent {
        background-color: #bf616a;
    }

    #mode {
        background: #64727D;
        border-bottom: 3px solid #ffffff;
    }

    #clock, #battery, #cpu, #memory, #temperature, #backlight, #network, #pulseaudio, #custom-media, #tray, #mode, #idle_inhibitor {
        padding: 5px 8px;
        margin: 5px;
        border-radius: 10px;
        background: rgba(0,0,0,.5);
    }

    #clock {
        /*background-color: #64727D;*/
        color: #e5e9f0;
        font-weight: bold;
    }

    #battery {
        /*background-color: #000000;*/
        color: #e5e9f0;
    }

    #battery.charging {
        /*background-color: #000000;*/
        color: #e5e9f0;
    }

    @keyframes blink {
        to {
            /*background-color: #ffffff;*/
            color: #000000;
        }
    }

    #battery.critical:not(.charging) {
        background: #f53c3c;
        color: #ffffff;
        animation-name: blink;
        animation-duration: 0.5s;
        animation-timing-function: linear;
        animation-iteration-count: infinite;
        animation-direction: alternate;
    }

    #cpu {
        /*background: #2ecc71;*/
        color: #e5e9f0;
    }

    #memory {
        /*background: #9b59b6;*/
        color: #e5e9f0;
    }

    #backlight {
        /*background: #90b1b1;*/
        color: #e5e9f0;
    }

    #network {
        /*background: #2980b9;*/
        color: #e5e9f0;
    }

    #network.disconnected {
        /*background: #f53c3c;*/
        color: #e5e9f0;
    }

    #pulseaudio {
        /*background: #000000;*/
        color: #e5e9f0;
    }

    #pulseaudio.muted {
        /*background: #000000;*/
        color: #e5e9f0;
    }

    #custom-media {
        background: #66cc99;
        color: #2a5c45;
    }

    .custom-spotify {
        background: #66cc99;
    }

    .custom-vlc {
        background: #ffa000;
    }

    #temperature {
        /*background: #f0932b;*/
    }

    #temperature.critical {
        background: #eb4d4b;
    }

    #tray {
        /*background-color: #2980b9;*/
        color: #e5e9f0;
    }

    #idle_inhibitor {
        background-color: #2d3436;
    }

    #idle_inhibitor.activated {
        background-color: #ecf0f1;
        color: #2d3436;
    }

  '';

  # Create Dunst configuration
  environment.etc."xdg/dunst/dunstrc".text = ''
    [global]
        font = "JetBrainsMono Nerd Font 10"
        markup = yes
        format = "<b>%s</b>\\n%b"
        sort = yes
        indicate_hidden = yes
        alignment = left
        show_age_threshold = 60
        word_wrap = yes
        ignore_newline = no
        geometry = "300x5-30+20"
        transparency = 10
        idle_threshold = 120
        monitor = 0
        follow = mouse
        sticky_history = yes
        line_height = 0
        separator_height = 2
        padding = 8
        horizontal_padding = 8
        separator_color = frame
        startup_notification = false
        dmenu = /usr/bin/dmenu
        browser = /usr/bin/xdg-open
        always_run_script = true
        title = Dunst
        class = Dunst
        corner_radius = 0
        force_xinerama = false
        mouse_left_click = close_current
        mouse_middle_click = do_action
        mouse_right_click = close_all

    [shortcuts]
        close = ctrl+space
        close_all = ctrl+shift+space
        history = ctrl+grave
        context = ctrl+shift+period

    [urgency_low]
        timeout = 10
        background = "#222222"
        foreground = "#888888"
        frame_color = "#3b7c7c"

    [urgency_normal]
        timeout = 10
        background = "#285577"
        foreground = "#ffffff"
        frame_color = "#4c7899"

    [urgency_critical]
        timeout = 0
        background = "#900000"
        foreground = "#ffffff"
        frame_color = "#ff0000"
  '';

  # Create Alacritty configuration with transparency
  environment.etc."xdg/alacritty/alacritty.yml".text = ''
    # Alacritty Configuration
    # Colors (Tokyo Night theme)
    colors:
      primary:
        background: '#1a1b26'
        foreground: '#c0caf5'
      cursor:
        text: '#1a1b26'
        cursor: '#c0caf5'
      normal:
        black: '#15161e'
        red: '#f7768e'
        green: '#9ece6a'
        yellow: '#e0af68'
        blue: '#7aa2f7'
        magenta: '#bb9af7'
        cyan: '#7dcfff'
        white: '#a9b1d6'
      bright:
        black: '#414868'
        red: '#f7768e'
        green: '#9ece6a'
        yellow: '#e0af68'
        blue: '#7aa2f7'
        magenta: '#bb9af7'
        cyan: '#7dcfff'
        white: '#c0caf5'

    # Window settings
    window:
      opacity: 0.85
      background_opacity: 0.85
      decorations: buttonless
      padding:
        x: 10
        y: 10
      dynamic_padding: true
      startup_mode: Maximized

    # Font settings
    font:
      normal:
        family: JetBrainsMono Nerd Font
        style: Regular
      bold:
        family: JetBrainsMono Nerd Font
        style: Bold
      italic:
        family: JetBrainsMono Nerd Font
        style: Italic
      size: 12.0

    # Cursor settings
    cursor:
      style: Block
      unfocused_hollow: true

    # Selection settings
    selection:
      save_to_clipboard: true

    # Scrolling
    scrolling:
      history: 10000
      multiplier: 3

    # Live config reload
    live_config_reload: true

    # Shell integration
    shell:
      args:
        - -l

    # Key bindings
    key_bindings:
      - { key: V, mods: Control|Shift, action: Paste }
      - { key: C, mods: Control|Shift, action: Copy }
      - { key: Key0, mods: Control, action: ResetFontSize }
      - { key: Equals, mods: Control, action: IncreaseFontSize }
      - { key: Minus, mods: Control, action: DecreaseFontSize }
      
      # Arrow key navigation (for applications that support it)
      - { key: Up, action: ScrollLineUp }
      - { key: Down, action: ScrollLineDown }
      - { key: PageUp, action: ScrollPageUp }
      - { key: PageDown, action: ScrollPageDown }
      
      # Home/End keys
      - { key: Home, action: ScrollToTop }
      - { key: End, action: ScrollToBottom }
  '';
} 