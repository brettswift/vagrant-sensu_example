#!/bin/bash

###############################
# Functions

# return 1 if global command line program installed, else 0
# example
# echo "node: $(program_is_installed node)"
function program_is_installed {
  local return_=0
 	if which $1 &> /dev/null; then
   	local return_=1 #set to 1 when found
 	fi
  echo "$return_"
}
#
# # usage:  $1 = module
# function install_puppet_module_if_required {
#  output=`su root -c 'puppet module list'`
#  echo $output
#  if [[ "$output" == *"$1"* ]]; then
#    echo "module $1 already installed"
#  else
#    echo `su root -c "puppet module install $1"`
#    echo "module $1 finished installing"
#    echo "** ignore the above message about command not found**"
#  fi
# }
##############################

	echo "running bootstrap.  Installing puppet if required"

### ensure stuff is installed
#  git is probably not required.
# if [ $(program_is_installed git) == 0 ]; then
# 	su -c 'yum update -y'
# 	su -c 'yum install git -y -v'
# else
# 	echo "git already installed"
# fi
#
# if [ $(program_is_installed puppet) == 0 ]; then
# 	su -c  'rpm -ivh http://yum.puppetlabs.com/el/6/products/i386/puppetlabs-release-6-7.noarch.rpm'
# 	su -c 'yum install puppet -y -v'
# else
# 	echo "puppet already installed"
# fi

su -c 'yum install puppet -y -v'



echo "######## bootstrap completed #########"
