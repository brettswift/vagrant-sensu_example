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

function run_r10k {

  echo $(md5sum /vagrant/Puppetfile) > /tmp/puppetfile_hash_new

  if diff /tmp/puppetfile_hash_new /tmp/puppetfile_hash_old; then
    exit 0 #hashes didn't differ, puppetfile hasn't changed.
  fi

  echo "running r10k puppetfile install"
  r10k -v debug puppetfile install
  #update old hash
  echo $(md5sum /vagrant/Puppetfile) > /tmp/puppetfile_hash_old
}

# gem list <name> -i will return the string true if the gem is installed and false otherwise. Also, the return codes are what you would expect.
cd $PUPPET_DIR
if [ `gem list r10k -i` != true ]; then
  echo 'installing r10k'
  gem install r10k --no-ri --no-rdoc
  echo 'running r10k, please be patient while I fill up your ./modules directory.'
  run_r10k
else
  echo 'r10k already installed'
  echo 'running r10k puppetfile install'
  run_r10k
fi

echo "#########  r10k bootstrap complete"
