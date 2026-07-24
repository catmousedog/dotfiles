#!/usr/bin/fish

set matrix 3
set num_workspaces (math "$matrix * $matrix")

# Get monitor NAMES (stable across hibernate/resume), sorted for a consistent logical order
function get_monitors
    hyprctl monitors -j | jq -r 'sort_by(.name) | .[].name'
end

set monitors (get_monitors)

# Loop over all monitors by logical index (0-based), using their real name for hyprctl calls
for i in (seq 1 (count $monitors))
    set mon_name $monitors[$i]
    set mon (math "$i - 1")

    # Loop over logical ids [0, 9[
    for id in (seq 0 (math "$num_workspaces - 1"))
        set -l mid (math "$id + $mon * $num_workspaces + 1")

        if test $id -eq 4 # Set middle
            hyprctl keyword workspace "$mid, monitor:$mon_name, default:true"
            hyprctl dispatch workspace "$mid"
        else
            hyprctl keyword workspace "$mid, monitor:$mon_name"
        end
    end
end
