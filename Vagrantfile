# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|

  config.vm.define "cent7" do |box|
    box.vm.box = "puppetlabs/centos-7.0-64-nocm"
    box.vm.hostname = "cent7"
    box.vm.network "private_network", ip: "10.14.1.9"
    box.vm.provision "shell" do |p|
      p.path = "provision/bash"
    end
  end

  config.vm.define "trusty" do |box|
    box.vm.box = "puppetlabs/ubuntu-14.04-64-nocm"
    box.vm.hostname = "trusty"
    box.vm.network "private_network", ip: "10.14.1.10"
    box.vm.provision "shell" do |p|
      p.path = "provision/bash"
    end
  end

end
