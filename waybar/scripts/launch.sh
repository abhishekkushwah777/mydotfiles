#!/bin/bash

killall -9 waybar
waybar &
notify-send "waybar reloaded"

killall -9 swaync
#!/bin/bash

# 1. Reload Waybar safely
if pgrep -x waybar > /dev/null; then
    killall -SIGUSR2 waybar
else
    waybar &
fi
notify-send "Waybar reloaded"

# 2. Reload SwayNC cleanly using its built-in client
if pgrep -x swaync > /dev/null; then
    swaync-client -R
    swaync-client -rs
else
    # Fallback to systemd if it isn't running
    systemctl --user start swaync
fi
notify-send "SwayNC reloaded"
swaync &
notify-send "swaync reloaded"
