#!/bin/bash

if  xrandr -q | grep "DP1";
then
    xrandr --output VIRTUAL1 --off --output DP3 --off --output DP2 --off --output DP1 --mode 1920x1080 --pos 1720x0 --rotate normal --output HDMI3 --off --output HDMI2 --off --output HDMI1 --off --output LVDS1 --primary --mode 1440x900 --pos 0x496 --rotate normal --output VGA1 --off
else
    echo "DP1 not connected"
fi
