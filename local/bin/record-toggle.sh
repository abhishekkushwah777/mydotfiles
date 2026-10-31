#!/bin/bash

VIDEO_DIR="$HOME/Videos"
LOG="/tmp/wf-recorder.log"

mkdir -p "$VIDEO_DIR"

# Check whether recording is running
if pgrep -x wf-recorder >/dev/null; then
    # Stop recording gracefully
    pkill -INT -x wf-recorder
    exit 0
fi

# Start recording
OUTPUT="$VIDEO_DIR/recording-$(date +%Y-%m-%d_%H-%M-%S).mp4"

nohup wf-recorder -f "$OUTPUT" > "$LOG" 2>&1 </dev/null &

exit 0
