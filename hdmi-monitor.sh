#!/bin/bash

set -u

# startup for hdmi-monitor-daemon.sh script
# use from Xfce4 autostart menu
start-stop-daemon --start --oknodo --user hinxx --name HDMI-setup \
                   --pidfile /tmp/hdmi.pid --make-pidfile \
                   --startas /home/hinxx/bin/hdmi-monitor-daemon.sh \
                   --chuid hinxx --background --
exit 0

