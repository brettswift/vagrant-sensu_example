#!/bin/sh

# Directory in which librarian-puppet should manage its modules directory
PUPPET_DIR='/vagrant'

echo "running r10k"

GIT=/usr/bin/git
APT_GET=/usr/bin/apt-get
YUM=/usr/bin/yum
if [ ! -x $GIT ]; then
    if [ -x $YUM ]; then
        yum -q -y install git-core
    elif [ -x $APT_GET ]; then
        apt-get -q -y install git-core
    else
        echo "No package installer available. You may need to install git manually."
    fi
fi

# gem list <name> -i will return the string true if the gem is installed and false otherwise. Also, the return codes are what you would expect.
 cd $PUPPET_DIR
if [ `gem list r10k -i` != true ]; then
	echo 'installing r10k'
  gem install r10k --no-ri --no-rdoc
  echo 'running r10k, please be patient while I fill up your ./modules directory.'
  r10k -v debug puppetfile install  
else
	echo 'r10k already installed'
	echo 'running r10k puppetfile install'
  r10k -v debug puppetfile install
fi

echo "#########  r10k bootstrap complete"
