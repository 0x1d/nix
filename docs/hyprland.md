# Hyprland Desktop Configuration

This directory contains the Hyprland desktop configuration for NixOS with i3-style keybindings.

## What is Hyprland?

Hyprland is a dynamic tiling Wayland compositor that doesn't sacrifice on its looks. It supports multiple layouts, window rules, and a highly customizable configuration system.

## Features

- **Dynamic Tiling**: Automatic window management with multiple layout options
- **Wayland Native**: Modern display protocol support
- **Highly Customizable**: Extensive configuration options
- **Performance**: Optimized for smooth animations and responsiveness
- **Swiss Keyboard Layout**: Pre-configured for Swiss German layout (ch)
- **i3-Style Keybindings**: Familiar navigation for i3 users

## Included Components

### Core Applications
- **Hyprland**: The compositor itself
- **Waybar**: Status bar with workspace management
- **Dunst**: Notification daemon
- **Alacritty**: Terminal emulator (with transparency)
- **Thunar**: File manager (XFCE)
- **Wofi**: Application launcher

### Utilities
- **Grim + Slurp**: Screenshot tools
- **Hyprpicker**: Color picker
- **Swww**: Wallpaper utility
- **Wl-clipboard**: Clipboard management
- **Cliphist**: Clipboard history
- **Pavucontrol**: Volume control
- **Brightnessctl**: Brightness control

## Usage

### Building the Configuration

To build the Hyprland configuration:

```bash
cd /home/master/src/nix
nix build .#hyprland
```

### Switching to Hyprland

After building, you can switch to the Hyprland configuration:

```bash
sudo nixos-rebuild switch --flake .#hyprland
```

### Logging In

When you log in, select "Hyprland" from your display manager. If you're using a tty, you can start Hyprland directly with:

```bash
Hyprland
```

## Key Bindings (i3-Style)

### **Navigation & Focus:**
- **Super + h/j/k/l** OR **Super + arrow keys** - Move focus (vim-style, like i3)
- **Super + 1-0** - Switch to workspace 1-10
- **Super + Shift + 1-0** - Move window to workspace 1-10

### **Window Management:**
- **Super + Control + h/j/k/l** OR **Super + Control + arrow keys** - Resize windows
- **Super + Shift + h/j/k/l** OR **Super + Shift + arrow keys** - Move windows
- **Super + f** - Toggle fullscreen
- **Super + v** - Toggle floating mode
- **Super + s** - Toggle split direction

### **Applications:**
- **Super + d** - Application launcher (wofi)
- **Super + Return** - Terminal (alacritty)
- **Super + Q** - Close active window

### **System Controls:**
- **Super + Shift + q** - Exit Hyprland
- **Super + Shift + r** - Reload Hyprland config
- **Super + p** - Screenshot selected area
- **Volume keys** - Audio control
- **Brightness keys** - Screen brightness

### **Mouse:**
- **Super + Left Click** - Move windows
- **Super + Right Click** - Resize windows

## Customization

### Hyprland Configuration

The main configuration is in `/etc/xdg/hypr/hyprland.conf`. You can modify this file to customize:

- Window decorations and animations
- Key bindings
- Workspace behavior
- Monitor configuration
- Input settings

### Waybar Configuration

The status bar configuration is in `/etc/xdg/waybar/config` and styling in `/etc/xdg/waybar/style.css`.

### Dunst Configuration

Notification settings are in `/etc/xdg/dunst/dunstrc`.

## Configuration Files

The system automatically creates these configuration files:

- **Hyprland**: `/etc/xdg/hypr/hyprland.conf`
- **Waybar**: `/etc/xdg/waybar/config` and `/etc/xdg/waybar/style.css`
- **Dunst**: `/etc/xdg/dunst/dunstrc`

## Troubleshooting

### Common Issues

1. **Applications not starting**: Ensure the application supports Wayland
2. **Screen tearing**: Check if `allow_tearing = true` is set in hyprland.conf
3. **Performance issues**: Try disabling animations or reducing blur effects
4. **Keybindings not working**: Check if there are conflicts with other applications

### Logs

Hyprland logs are available in:
- `journalctl --user -f` (for user session)
- `~/.local/share/hyprland/hyprland.log`

### XWayland Support

XWayland is enabled by default for compatibility with X11 applications. If you experience issues, you can disable it by setting `xwayland.enable = false` in the configuration.

## Building as VM

To build and test the Hyprland configuration as a virtual machine:

```bash
./ctl.sh os rebuild hyprland
```

## Resources

- [Hyprland Wiki](https://wiki.hyprland.org/)
- [Waybar Documentation](https://github.com/Alexays/Waybar/wiki)
- [Dunst Documentation](https://dunst-project.org/documentation/)
- [i3 User's Guide](https://i3wm.org/docs/userguide.html) (for keybinding reference)

## Notes

- This configuration is optimized for Swiss German keyboard layout
- All configuration files are managed by NixOS and will be restored on rebuild
- Custom user configurations should be placed in `~/.config/hypr/` to override system defaults
- Keybindings follow i3 conventions for easy transition from i3wm
- **Dual navigation**: Both vim-style (h/j/k/l) and arrow keys work for all functions
- **Intuitive modifiers**: Control for resizing, Shift for moving windows
- Monitor configuration is set for a 1920x1080@144 display (customize as needed) 