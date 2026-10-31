
#!/usr/bin/env bash

set -u



options="⏻  Shutdown
󰤄  Suspend
󰜉  Reboot
󰍃  Logout"

chosen=$(printf '%s\n' "$options" | rofi \
    -dmenu \
    -i \
    -p "Power Menu" \
    -theme-str '
        window { width: 600px; }
        listview { lines: 4; }
        element { padding: 12px; }
        element-text { horizontal-align: 0.1; }
    ')

case "$chosen" in
    *Logout)
        action="Logout from Hyprland?"
        ;;
    *Suspend)
        action="Suspend this computer?"
        ;;
    *Reboot)
        action="Reboot this computer?"
        ;;
    *Shutdown)
        action="Shut down this computer?"
        ;;
    *)
        exit 0
        ;;
esac

# Confirm actions that close the session or power off the computer.
if [[ -n "${action:-}" ]]; then
    confirm=$(printf 'Yes\nNo\n' | rofi \
        -dmenu \
        -i \
        -p "$action" \
        -theme-str 'window { width: 600px; } listview { lines: 2; }')

    [[ "$confirm" == "Yes" ]] || exit 0
fi

case "$chosen" in
    *Logout)
        hyprctl dispatch 'hl.dsp.exit()'   
        ;;
    *Suspend)
        systemctl suspend
        ;;
    *Reboot)
        systemctl reboot
        ;;
    *Shutdown)
        systemctl poweroff
        ;;
esac
