#Vagrant Sensu Server

This project bootstraps a Vagrant box with Puppet and r10k

It consists of sample nodes to monitor with Sensu.

## Requirements
* `vagrant plugin install vagrant-hostmanager`  this manages /etc/hosts

## What you get

* sensu server
* graphite & grafana dashboards
* two sample agents
* sample grafana dashboards you can import manually (see `./grafana_dashboards`)

## Getting started
* `vagrant up sensuserver agent1 graphite grafana` will bring everything up to run the sample grafana dashboards up.
* `http://33.33.33.5:8080/` is the grafana dashboard

## Project Structure
* `manifests/site.pp` node classification
* `site` local module code
* `modules` installed by r10k from the Puppetfile
* `modules_site`  roles and profiles local to this project.
* `live_modules`  a placeholder folder used by Vagrant and put in the front of the modulepath for integrated development on 'Puppetfile' modules.
* `manifests/r10k_modules.pp` executes the Puppetfile before running `site.pp`
* `shell` bootstrap provisioners.
	* so you can use a clean base vagrant box that doesn't have puppet if you want

## Contributing
* must use a feature/bugfix branch ie: `feature/cool_thing`
* squash all commits before the pull request if possible
*
