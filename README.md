#Vagrant Sensu Server

This project bootstraps a Vagrant box with Puppet and r10k

It consists of sample nodes to monitor with Sensu.

## Requirements
* `vagrant plugin install vagrant-hostmanager`  this manages /etc/hosts


Project Structure
-----------------
* `manifests/site.pp` node classification
* `site` local module code
* `modules` installed by librarian-puppet
* `shell` bootstrap provisioners.
		* so you can use a clean base vagrant box that doesn't have puppet if you want
