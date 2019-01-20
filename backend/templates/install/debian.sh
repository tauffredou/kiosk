#!/usr/bin/env bash

apt-get update
apt-get install -y --no-install-recommends xorg lightdm openbox chromium chromedriver ruby-ffi

# Create kiosk user
id -u kiosk &>/dev/null || useradd -m kiosk
sed -i  s/#autologin-user=/autologin-user=kiosk/ /etc/lightdm/lightdm.conf

# autologin at startup
mkdir -p /etc/lightdm/lightdm.conf.d
cat <<EOF >/etc/lightdm/lightdm.conf.d/50-kiosk.conf
[SeatDefaults]
autologin-user=kiosk
user-session=openbox
EOF

# Start chromedriver on startup
mkdir -p /home/kiosk/.config/openbox
cat <<EOF >/home/kiosk/.config/openbox/autostart
#!/bin/sh

# Run this script in display 0 - the monitor
export DISPLAY=:0
# Hide the mouse from the display
unclutter -idle 0.1
/usr/bin/chromedriver --whitelisted-ips 0.0.0.0
EOF

chown kiosk /home/kiosk -R

# Restart X
systemctl restart display-manager