
#!/usr/bin/env bash

# Directory containing your projects
WORK_DIR="$HOME/working_dir"

# Applications
ROFI="rofi"
CODE="code"
TERMINAL="kitty"

# Verify the working directory
if [[ ! -d "$WORK_DIR" ]]; then
    notify-send "Project Launcher" "Directory not found: $WORK_DIR"
    exit 1
fi

# List directories and select one using Rofi
SELECTED=$(
    find "$WORK_DIR" \
        -mindepth 1 -maxdepth 1 -type d \
        -printf '%f\n' |
        sort |
        "$ROFI" -dmenu -i -p "Open Project"
)

# Exit if selection is cancelled
[[ -z "$SELECTED" ]] && exit 0

# Resolve the selected project path
PROJECT_DIR="$WORK_DIR/$SELECTED"

# Open VS Code in the selected project
"$CODE" --new-window "$PROJECT_DIR" >/dev/null 2>&1 &

# Open a fresh terminal at the same path
"$TERMINAL" --directory "$PROJECT_DIR" >/dev/null 2>&1 &
