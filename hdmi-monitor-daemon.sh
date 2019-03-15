#!/bin/bash

set -u

# use xrandr to get more info
# when HDMI is main monitor, left of the built-in display, eDP-1-1 gets different geometry set!
# use this to detect the state of the HDMI monitor
# should work after wake up and login..

# BEFORE HDMI monitor is main screen
# HDMI-1-1 connected 2560x1440+0+0 (normal left inverted right x axis y axis) 725mm x 428mm
# eDP-1-1 connected 1920x1080+0+0 (normal left inverted right x axis y axis) 344mm x 193mm

# AFTER HDMI monitor is main screen (on the left)
# HDMI-1-1 connected 2560x1440+0+0 (normal left inverted right x axis y axis) 725mm x 428mm
# eDP-1-1 connected 1920x1080+2560+0 (normal left inverted right x axis y axis) 344mm x 193mm

logger "starting HDMI monitor setup daemon.."
while [[ 1 ]]; do
  # assume no HDMI monitor, check!
  hdmi=0
  xrandr | grep -q 'HDMI-1-1 connected'
  [[ $? -eq 0 ]] && hdmi=1
  # we can do something only if HDMI monitor is connected
  if [[ $hdmi -eq 1 ]]; then
    # check for screen geometry by checking built-in display
    main=0
    xrandr | grep -q 'eDP-1-1 connected 1920x1080+2560+0'
    [[ $? -eq 0 ]] && main=1
    if [[ $main -eq 0 ]]; then
      # try to make HDMI as main screen (left of built-in screen)
      logger "setting up HDMI as main screen.."
      # xrandr --output RIGHT-SCREEN-ID --right-of LEFT-SCREEN-ID
      # xrandr --output HDMI-1-1 --right-of eDP-1-1
      xrandr --output HDMI-1-1 --left-of eDP-1-1
    fi
  fi
  # sleep for a while
  sleep 10
done

logger "stopped HDMI monitor setup daemon.."
exit 0

