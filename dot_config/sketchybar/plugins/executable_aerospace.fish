#!/usr/bin/env fish

set -l prev_drawing on
set -l prev_other off
if test (aerospace list-windows --count --workspace $PREV_WORKSPACE) = 0
    set prev_drawing off
    set prev_other on
end

#TODO: just add a border if visible?
sketchybar \
    --set $FOCUSED_WORKSPACE \
    drawing=on \
    background.drawing=on \
    --set $PREV_WORKSPACE \
    drawing=$prev_drawing \
    icon.highlight=$prev_other \
    background.drawing=$prev_other \
    label.highlight=$prev_other
