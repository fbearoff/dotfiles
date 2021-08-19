#!/bin/bash

xrandr --output LVDS1 --primary --mode 1440x900 --rotate normal --output DP2 --mode 1920x1080 --right-of LVDS1 --rotate normal
sleep 10s
xrandr --output LVDS1 --mode 1440x900 --rotate normal --output DP2 --primary --mode 1920x1080 --right-of LVDS1 --rotate normal
