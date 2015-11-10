Installs Apache, MySQL, PHP, and Drupal in a Vagrant environment  

This is a variant of [vagrant-webserver](https://github.com/code-dpl/vagrant-webserver), branch 2015-10-24, with a few demonstrative changes:

 - Vagrant's Puppet provisioner functionality, previously in the Vagrantfile, has been replaced with a line in provision/bash
 - The /vagrant URL is no longer created/accessible
 - The init.pp instantiates the webserver::drupal class and passes parameters to it
 - drupal.pp has been added to the webserver module, defining the parameterized webserver::drupal class
 - Doesn't include the DPL favicon.ico
 - Uses .gitignore to prevent checkins of the .vagrant directory that's created when doing `vagrant up`

To use:

1. Install VirtualBox and Vagrant, then run `vagrant up`  
1. Open a web browser to http://$ip/drupal.  
IP addresses are in the Vagrantfile, e.g. [http://10.14.1.9/drupal](http://10.14.1.9/drupal)
