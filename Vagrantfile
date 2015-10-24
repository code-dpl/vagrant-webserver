# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|

# Create a CentOS 7 VM
  config.vm.define "cent7" do |box|
# This is the path to the box.  It can be a URL, or a box that's already been added with "vagrant box add", but in this case, it's a box on Hashicorp Atlas.
# https://atlas.hashicorp.com/boxes/search
    box.vm.box = "puppetlabs/centos-7.0-64-nocm"
# This is what Vagrant will configure the hostname to be on the VM's OS
    box.vm.hostname = "cent7"
# Set a local IP for the OS.  DPL happens to be at 10 W 14th street, so I used 10.14.x.x.  Any range may be used for private_network, since the subnet is limited to this machine.  Still, you might as well use non-routable IPs
# https://en.wikipedia.org/wiki/Private_network#Private_IPv4_address_spaces
    box.vm.network "private_network", ip: "10.14.1.7"
# When the box is first brought up, or when "vagrant provision" is run, it runs the provisioner statements
# This statement tells the client OS to run a shell script, located at /vagrant/provision/bash
    box.vm.provision "shell" do |p|
      p.path = "provision/bash"
    end
# This tells the client OS to use Puppet
    box.vm.provision "puppet" do |p|
      p.manifests_path = "provision/puppet/manifests" 
      p.manifest_file = "site.pp"
      p.module_path = "provision/puppet/modules"
      p.options = "--verbose --debug"
    end
  end

# Create an Ubuntu Trusty VM
  config.vm.define "trusty" do |box|
    box.vm.box = "puppetlabs/ubuntu-14.04-64-nocm"
    box.vm.hostname = "trusty"
    box.vm.network "private_network", ip: "10.14.1.8"
    box.vm.provision "shell" do |p|
      p.path = "provision/bash"
    end
    box.vm.provision "puppet" do |p|
      p.manifests_path = "provision/puppet/manifests" 
      p.manifest_file = "site.pp"
      p.module_path = "provision/puppet/modules"
      p.options = "--verbose --debug"
    end
  end

end
