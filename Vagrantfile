# -*- mode: ruby -*-
# vi: set ft=ruby :
Vagrant.configure("2") do |config|
  config.vm.box = "debian/stretch64"

  config.vm.network "private_network", ip: "192.168.33.10"
  config.vm.synced_folder '.', '/vagrant', disabled: true

   config.vm.provider "virtualbox" do |vb|
     vb.gui = true
     vb.memory = "1024"
   end
  config.vm.provision "shell", inline: <<-SHELL
     apt-get update
     apt-get install -y --no-install-recommends xorg lightdm openbox chromium chromedriver ruby-ffi
     id -u kiosk &>/dev/null || useradd -m kiosk
     sed -i  s/#autologin-user=/autologin-user=kiosk/ /etc/lightdm/lightdm.conf

     mkdir -p /etc/lightdm/lightdm.conf.d
     cat<<EOF>/etc/lightdm/lightdm.conf.d/50-myconfig.conf
[SeatDefaults]
autologin-user=kiosk
user-session=openbox
EOF

    mkdir -p /home/kiosk/.config/openbox && chown kiosk /home/kiosk -R
    cat<<EOF> /home/kiosk/.config/openbox/autostart
#!/bin/sh
# Run this script in display 0 - the monitor
export DISPLAY=:0
 
# Hide the mouse from the display
unclutter -idle 0.1
 
# If Chromium crashes (usually due to rebooting), clear the crash flag so we don't have the annoying warning bar
#sed -i 's/"exited_cleanly":false/"exited_cleanly":true/' /home/kiosk/.config/chromium/Default/Preferences
#sed -i 's/"exit_type":"Crashed"/"exit_type":"Normal"/' /home/kiosk/.config/chromium/Default/Preferences

/usr/bin/chromedriver --whitelisted-ips 0.0.0.0

/usr/bin/chromium --no-first-run \
#    --disable \
#    --disable-translate \
#    --disable-features=TranslateUI \
#    --disable-infobars \
#    --disable-suggestions-service \
#    --disable-save-password-bubble \
#    --kiosk --start-fullscreen https://jobteaser.com
EOF

systemctl restart display-manager

  SHELL
end
