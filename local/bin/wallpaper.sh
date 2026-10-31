
#!/usr/bin/env bash
set -Eeuo pipefail

# Configuration
WALLPAPER_DIR="${WALLPAPER_DIR:-$HOME/Pictures/Wallpapers}"
THUMB_SIZE="${THUMB_SIZE:-180}"
COLUMNS="${COLUMNS:-4}"
VISIBLE_ROWS="${VISIBLE_ROWS:-3}"
TRANSITION_TYPE="${TRANSITION_TYPE:-wave}"
TRANSITION_DURATION="${TRANSITION_DURATION:-0.5}"

notify() {
    if command -v notify-send >/dev/null 2>&1; then
        notify-send "Wallpaper" "$1" || true
    fi
}

# Check dependencies
for cmd in rofi awww matugen find sort; do
    if ! command -v "$cmd" >/dev/null 2>&1; then
        printf 'Missing dependency: %s\n' "$cmd" >&2
        notify "Missing dependency: $cmd"
        exit 1
    fi
done

if [[ ! -d "$WALLPAPER_DIR" ]]; then
    printf 'Wallpaper directory not found: %s\n' "$WALLPAPER_DIR" >&2
    notify "Wallpaper directory not found"
    exit 1
fi

# Discover wallpapers
mapfile -d '' wallpapers < <(
    find "$WALLPAPER_DIR" -type f \
        \( -iname '*.jpg' -o -iname '*.jpeg' \
        -o -iname '*.png' -o -iname '*.webp' \
        -o -iname '*.bmp' -o -iname '*.avif' \) \
        -print0 | sort -z -f
)

if ((${#wallpapers[@]} == 0)); then
    notify "No wallpapers found in $WALLPAPER_DIR"
    exit 0
fi

# Build an icon-only Rofi grid.
selected="$(
    for i in "${!wallpapers[@]}"; do
        printf '%s\0icon\x1f%s\n' "$i" "${wallpapers[$i]}"
    done |
    rofi -dmenu \
        -i \
        -show-icons \
        -p "Wallpapers" \
        -format s \
        -theme-str "
            window {
                width: 85%;
                padding: 12px;
            }
            mainbox {
                children: [ listview ];
            }
            listview {
                columns: $COLUMNS;
                lines: $VISIBLE_ROWS;
                fixed-height: false;
                spacing: 10px;
                scrollbar: false;
            }
            element {
                orientation: vertical;
                padding: 4px;
                border: 0px;
                children: [ element-icon ];
            }
            element-icon {
                size: ${THUMB_SIZE}px;
                horizontal-align: 0.5;
                vertical-align: 0.5;
            }
            element-text {
                enabled: false;
            }
        "
)" || true

# Cancel if Rofi was dismissed.
[[ "$selected" =~ ^[0-9]+$ ]] || exit 0
((selected < ${#wallpapers[@]})) || exit 1

wallpaper="${wallpapers[$selected]}"

# Apply wallpaper.
if ! awww img "$wallpaper" \
    --transition-type "$TRANSITION_TYPE" \
    --transition-duration "$TRANSITION_DURATION"; then
    notify "awww could not set the wallpaper"
    exit 1
fi

# Generate the palette using Matugen.
if ! matugen image --source-color-index 0 "$wallpaper"; then
    notify "Wallpaper set, but Matugen failed to generate colors"
    exit 1
fi

notify "Wallpaper applied and Matugen colors generated"
printf 'Wallpaper: %s\n' "$wallpaper"
printf 'Matugen configuration: %s\n' "$HOME/.config/matugen/"
