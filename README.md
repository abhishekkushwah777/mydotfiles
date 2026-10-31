# mydotfiles

A personal Arch Linux + Hyprland dotfiles repository with a modern desktop setup built around Waybar, Rofi, Kitty, SwayNC, Fastfetch, and Matugen.

This repo contains configuration files and small helper scripts I use to customize my Linux desktop environment.

Preview video here - "https://youtu.be/LpL3YX5GxWI"
## Overview

This setup is tuned for:

- Arch Linux
- Hyprland window manager
- Waybar top bar
- Rofi launcher
- Kitty terminal
- Sway Notification Center
- Fastfetch system overview
- Matugen color generation
- Custom local utility scripts

## Repository structure

```text
.
├── fastfetch/
│   ├── config.jsonc
│   └── FastfetchPngs/
├── hypr/
│   └── hyprland.lua
├── kitty/
│   └── kitty.conf
├── local/
│   └── bin/
│       ├── fastfetch-responsive
│       ├── power.sh
│       ├── project-launcher.sh
│       ├── record-toggle.sh
│       ├── system-monitor-toggle
│       └── wallpaper.sh
├── matugen/
│   ├── config.toml
│   └── templates/
│       ├── colors.css
│       └── rofi-colors.rasi
├── rofi/
│   └── config.rasi
├── swaync/
│   ├── config.json
│   └── style.css
├── wallpapers/
├── waybar/
│   ├── cava.sh
│   ├── config.jsonc
│   ├── style.css
│   ├── colors/
│   ├── menus/
│   └── scripts/
└── README.md
```

## Included components

### Hyprland
- Main desktop configuration in `hypr/hyprland.lua`
- Includes monitor setup, environment variables, animations, window rules, and autostart commands

### Waybar
- `waybar/config.jsonc` configures the bar layout and modules
- `waybar/style.css` handles visual styling
- `waybar/colors/` includes custom theme colors
- `waybar/scripts/launch.sh` is used to start or reload the bar setup

### Rofi
- `rofi/config.rasi` defines app launcher styling and behavior

### Kitty
- `kitty/kitty.conf` contains terminal configuration, fonts, colors, and window behavior

### SwayNC
- `swaync/config.json` and `swaync/style.css` control notification center appearance and behavior

### Fastfetch
- `fastfetch/config.jsonc` custom system info display
- `fastfetch/FastfetchPngs/` holds image assets used by the fetch output

### Matugen
- `matugen/config.toml` and templates generate dynamic color themes for GTK/desktop styling

### Utilities
The `local/bin` folder contains small helper scripts:

- `project-launcher.sh` opens a project directory in VS Code and a terminal
- `wallpaper.sh` manages wallpaper changes
- `power.sh` handles power-related actions
- `record-toggle.sh` toggles screen recording
- `system-monitor-toggle` toggles a monitoring panel or script
- `fastfetch-responsive` is a quick system info fetch utility

## Requirements

Install the following packages depending on your setup:

- hyprland
- kitty
- waybar
- rofi
- swaync
- fastfetch
- matugen
- playerctl
- wl-clipboard or clipboard tools if needed
- network-manager-applet / relevant desktop services

You may also need fonts/icons for Waybar, Rofi, and notifications.

## Installation

1. Clone the repo:

```bash
git clone https://github.com/your-user/mydotfiles.git ~/.dotfiles
```

2. Copy or symlink the config folders into your home config paths:

```bash
mkdir -p ~/.config
cp -r ./hypr ~/.config/
cp -r ./kitty ~/.config/
cp -r ./rofi ~/.config/
cp -r ./swaync ~/.config/
cp -r ./waybar ~/.config/
cp -r ./fastfetch ~/.config/
cp -r ./matugen ~/.config/
```

3. Copy the scripts into your local bin folder:

```bash
mkdir -p ~/.local/bin
cp -r ./local/bin/* ~/.local/bin/
chmod +x ~/.local/bin/*
```

4. Ensure the paths in the config files match your system.

> This repo currently contains machine-specific paths such as `/home/baby/...`, so update them before using it on another machine.

5. Start Hyprland and reload the relevant services.

## Customization

This repository is designed to be easy to modify:

- Edit `hypr/hyprland.lua` for window manager behavior
- Edit `waybar/config.jsonc` for status bar modules
- Edit `waybar/style.css` for visual tweaks
- Adjust `matugen/config.toml` for color themes
- Change `kitty/kitty.conf` for terminal look and feel
- Update helper scripts in `local/bin` to match your workflow

## Notes

This is a personal config repo, so some values are intentionally customized for one machine. If you want to reuse it, review the config and adjust paths, device names, and app preferences before using it as-is.

## License

This project is provided as-is for personal use. If you plan to redistribute or adapt it, check local licensing terms for bundled packages and assets.

## Credits

This setup is based on common Arch Linux + Hyprland configuration patterns and personal customizations for a streamlined desktop experience.
