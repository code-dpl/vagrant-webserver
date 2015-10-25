## 2015/11/9 - Build Your Own Web Server with Vagrant, VirtualBox, and Puppet

If you  have any questions or problems, please post them on [the Meetup site](http://www.meetup.com/learntocodedenver/events/226301743/), since other people might have the same ones.

### What You Need
- A laptop with a CPU that supports hardware virtualization.  Most do, but it also needs to be enabled in the BIOS.  If you're not sure, you can continue with the steps and see if it fails.
- Since our time in the IdeaLab is limited and so is their bandwidth, complete the What to Do section in advance.

### What to Do
1. Download and install [Git](https://git-scm.com/downloads).
    - On Windows, in the "Adjusting your PATH environment" part of the install, select the 3rd option, "Use Git and optional Unix tools from the Windows Command Prompt."  The defaults for the other options are probably good, unless you find yourself running into problems with line endings (line feed vs. carriage-return line feed.  It doesn't matter for this class)
1. Download and install [VirtualBox](https://www.virtualbox.org/wiki/Downloads).
1. Download and install [Vagrant](http://www.vagrantup.com/downloads).
1. Open a command line/terminal window.
1. Clone this repository.  
`git clone https://github.com/code-dpl/vagrant-webserver`
1. Change to the new directory.  
`cd vagrant-webserver`
1. Bring up the environment.  This will probably take 20-30 minutes.  
`vagrant up`
1. At this point, you should be able to access the 2 web servers that were just created.  The directory listings will be identical, as they're both pointing to the same place.
http://10.14.1.7/vagrant  
http://10.14.1.8/vagrant
1. Feel free to mess around with things, if you want.  When you're done, type `vagrant halt` to stop the running VMs.
