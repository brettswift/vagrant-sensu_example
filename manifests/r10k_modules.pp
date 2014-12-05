exec {'r10k' :
	command 		=> 'r10k -v debug puppetfile install > r10k.log',
	path	 			=> ['/bin','/usr/bin','/opt/puppet/bin'],
	cwd 				=> '/vagrant'
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
Exec['r10k']
