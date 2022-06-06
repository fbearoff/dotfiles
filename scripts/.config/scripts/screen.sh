#!/bin/bash
lid_state=$(cat /proc/acpi/button/lid/LID/state | awk '{print $2}')
DP2_state=$(xrandr|grep "DP2"|awk '{print $2}')

if [ "$DP2_state" == "disconnected" ]; then
    xrandr --output LVDS1 --primary --mode 1440x900 --rotate normal --output DP2 --off
elif [ "$lid_state" == "closed" -a "$DP2_state" == "connected" ]; then
    xrandr --output LVDS1 --off --output DP2 --primary --mode 2560x1440 --rotate normal
else
    xrandr --output LVDS1 --primary --mode 1440x900 --rotate normal --output DP2 --mode 2560x1440 --right-of LVDS1 --rotate normal
    sleep 5s
    xrandr --output LVDS1 --mode 1440x900 --rotate normal --output DP2 --primary --mode 2560x1440 --right-of LVDS1 --rotate normal
fi
