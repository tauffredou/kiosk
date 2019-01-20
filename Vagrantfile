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
  config.vm.provision "shell", path: "http://localhost:8000/install/debian.sh"
end
