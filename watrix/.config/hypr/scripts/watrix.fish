#!/usr/bin/fish

if test (count $argv) -lt 1
    echo "Usage: watrix <action> <dir>"
    echo "Actions: workspace, movetoworkspace"
    echo "Dir: left, right, up, down"
    exit 1
end

set action $argv[1]
set dir $argv[2]

# Check args
if test $action != "workspace" -a $action != "movetoworkspace"
    echo "Invalid action"
    exit 1
end

if test $dir != "left" -a $dir != "right" -a $dir != "up" -a $dir != "down"
    echo "Invalid direction"
    exit 1
end

set matrix 3
set clamp true
set speed 2
set num_workspaces (math "$matrix * $matrix")

# Monitor NAMES (stable across hibernate/resume), sorted for a consistent logical order
function get_monitors
    hyprctl monitors -j | jq -r 'sort_by(.name) | .[].name'
end

set monitors (get_monitors)
set num_monitors (count $monitors)

# Cycle index in range [0, matrix[
function cycle
    set -l i $argv[1]

    if $clamp
        math "min($matrix - 1, max(0, $i))"
    else
        math "($argv[1] + $matrix) % $matrix"
    end
end

# Convert the logical id to the actual workspace id for a given monitor
function logical_to_actual
    set -l id $argv[1]
    set -l mon $argv[2]

    math "$id + $mon * $num_workspaces + 1"
end

# Move all monitors to the logical id
function move_workspaces
    set -l id $argv[1]

    # All hyprland dispatch commands appended
    set -l hypr_disp ""

    # Currently focused monitor NAME, mapped to its logical (0-based) index
    set cur_name (hyprctl activeworkspace -j | jq -r '.monitor')
    set cur (math (contains -i $cur_name $monitors) - 1)

    # Move focused window to the target logical id
    if test "$action" = "movetoworkspace"
        set hypr_disp "dispatch movetoworkspacesilent $(logical_to_actual $id $cur) ; "
    end

    # Focus and move all monitors
    for i in (seq 1 $num_monitors)
        set mon_name $monitors[$i]
        set mon (math "$i - 1")
        set hypr_disp "$hypr_disp dispatch focusmonitor $mon_name ; dispatch workspace $(logical_to_actual $id $mon) ; "
    end

    # Focus back to current monitor
    set hypr_disp "$hypr_disp dispatch focusmonitor $cur_name ; "

    echo $hypr_disp
end

# Current logical workspace index [0, 9[
set id (hyprctl activeworkspace -j | jq '.id')
set id (math "($id - 1) % $num_workspaces")

# logical row and column
set row (math "floor($id / $matrix)")
set col (math "$id % $matrix")

# Decide movement + animation direction
switch $dir
    case left
        set col (cycle (math "$col - 1"))
        set slide "slide"
    case right
        set col (cycle (math "$col + 1"))
        set slide "side"
    case up
        set row (cycle (math "$row - 1"))
        set slide "slidevert"
    case down
        set row (cycle (math "$row + 1"))
        set slide "slidevert"
    case '*'
        exit 1
end

# Set correct animation for moving
hyprctl keyword animation "workspaces,1,$speed,almostLinear,$slide"

# Target logical id [0, 9[
set id (math "$row * $matrix + $col")

# Move all monitors to the target logical id
set hypr_disp (move_workspaces $id)

# Dispatch full command
hyprctl --batch $hypr_disp

# Reset animation to fade in case jumping to workspace
hyprctl keyword animation "workspaces,1,$speed,almostLinear,fade"
