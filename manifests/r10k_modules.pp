exec {'r10k' :
	command 		=> 'r10k -v debug puppetfile install > r10k.log',
	path	 			=> ['/bin','/usr/bin','/opt/puppet/bin'],
	cwd 				=> '/vagrant',
	unless 			=> "diff /tmp/puppetfile_hash_new /tmp/puppetfile_hash_old",
}

exec {'create new hash':
	command => '/usr/bin/md5sum /vagrant/Puppetfile > /tmp/puppetfile_hash_new',
}

exec {'create old hash':
	command => '/usr/bin/md5sum /vagrant/Puppetfile > /tmp/puppetfile_hash_old',
	subscribe   => Exec["r10k"],
	refreshonly => true
}

package { "r10k":
	ensure 		=> latest,
	provider 	=> 'gem',
}

package { "git":
	ensure 		=> latest,
}

notify {"starting r10k deployment": }->
Package['git']->
Package['r10k']->
Exec['create new hash']->
Exec['r10k']
