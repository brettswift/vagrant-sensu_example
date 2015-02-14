#Vagrant Sensu Server

This project bootstraps a Vagrant box with Puppet and r10k

It consists of sample nodes to monitor with Sensu.

## Requirements
* `vagrant plugin install vagrant-hostmanager`  this manages /etc/hosts


#### Project Structure
* `manifests/site.pp` node classification
* `site` local module code
* `modules` installed by r10k from the Puppetfile
* `modules_site`  roles and profiles local to this project.
* `live_modules`  a placeholder folder used by Vagrant and put in the front of the modulepath for integrated development on 'Puppetfile' modules.
* `shell` bootstrap provisioners.
		* so you can use a clean base vagrant box that doesn't have puppet if you want


### TODO
* add graphite config.
		* Use `WizardVan` ? : http://www.joemiller.me/2013/12/07/sensu-and-graphite-part-2
