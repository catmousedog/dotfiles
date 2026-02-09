#!/usr/bin/fish

set matrix_size 3
set clamp true
set speed 2

set matrix_max (math $matrix_size - 1)

function cycle
    if $clamp
        math "min($matrix_max, max(0, $argv[1]))"
    else
        math "($argv[1] + $matrix_size) % $matrix_size"
    end
end

# Get active workspace ID (JSON, reliable)
function active_ws
    hyprctl activeworkspace -j | jq '.id'
end

function anim -a dir
    switch $dir
        case hor
            set slide slide
        case ver
            set slide slidevert
        case '*'
            exit 1
    end
    echo $slide
    hyprctl keyword animation "workspaces,1,$speed,almostLinear,$slide"
end

# Convert workspace ID → row / col
set row (math "floor(($(active_ws) - 1) / $matrix_size)")
set col (math "($(active_ws) - 1) % $matrix_size")

# Decide movement + animation direction
switch $argv[2]
    case left
        set col (cycle (math "$col - 1"))
        anim hor
    case right
        set col (cycle (math "$col + 1"))
        anim hor
    case up
        set row (cycle (math "$row - 1"))
        anim ver
    case down
        set row (cycle (math "$row + 1"))
        anim ver
    case '*'
        exit 1
end

# Convert row / col → workspace ID
set target_ws (math "round($row * $matrix_size + $col + 1)")

# Switch workspace
hyprctl dispatch $argv[1] $target_ws
hyprctl keyword animation "workspaces,1,$speed,almostLinear,fade"



