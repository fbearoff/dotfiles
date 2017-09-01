#!/bin/bash

if  xrandr -q | grep "HDMI1 con";
    then xrandr --output VIRTUAL1 --off --output DP3 --off --output DP2 --off --output DP1 --off --output HDMI3 --off --output HDMI2 --off --output HDMI1 --mode 1280x1024 --pos 1440x0 --rotate normal --output LVDS1 --primary --mode 1440x900 --pos 0x0 --rotate normal --output VGA1 --off
    else echo "HDMI1 not connected"
    fi
