# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.require_version ">= 1.6.0"

unless Vagrant.has_plugin?("vagrant-hostmanager")
  raise 'Missing plugin: please run `vagrant plugin install vagrant-hostmanager`'
end

nodes = {
			    "sensuserver" => 10,
			    "agent1" => 2,
			    "agent2" => 3,
			    "grafana" => 4
			  }
nodes.each { |nodename, nodeip| puts "#{nodename} --> 33.33.33.#{nodeip}" }

Vagrant.configure("2") do |config|

nodes.each do |nodename, nodeip|
	config.vm.define "#{nodename}" do |nodeconfig|
	# config.vm.define :sensuserver do |nodeconfig|
			config.vm.provision :hostmanager
			#virtualbox (cloud providers redefine this)
			nodeconfig.vm.box      = "centos-65-x64-virtualbox-puppet"
			nodeconfig.vm.box_url  = "http://puppet-vagrant-boxes.puppetlabs.com/centos-65-x64-virtualbox-puppet.box"

			hostname               = "#{nodename}"
			nodeconfig.vm.hostname = "#{nodename}"

			# nodeconfig.vm.provision :shell, :path => "./shell/bootstrap-vagrant-centos.sh"

			nodeconfig.vm.network :private_network, ip: "33.33.33.#{nodeip}"
			# nodeconfig.vm.network :forwarded_port, guest: 15672, host: 15672
			# nodeconfig.vm.network :forwarded_port, guest: 28017, host: 28017
			# nodeconfig.vm.network :forwarded_port, guest: 18017, host: 18017


			nodeconfig.vm.provision :puppet do |puppet|
				puppet.manifests_path 		= "manifests"
				puppet.manifest_file  		= "r10k_modules.pp"
				puppet.working_directory	= "/vagrant"
				puppet.options 						= "--verbose" # --debug"
			end

			#in 'live_modules', move module here to do live development
			nodeconfig.vm.provision :puppet do |puppet|
				puppet.manifests_path         = "manifests"
				puppet.manifest_file          = "site.pp"
				puppet.module_path 		        = ['live_modules','modules','modules_site']
				puppet.working_directory			= "/vagrant"
				puppet.options        				= "--verbose --trace"#--graph --graphdir /vagrant/graphs"
			end

			################################
			########  Providers ############
			nodeconfig.vm.provider :virtualbox do |vb, override|

				vb.customize [
					'modifyvm', :id,
					'--name', "#{nodename}",
					'--memory', 768
				]
			end
		end
	end
end
