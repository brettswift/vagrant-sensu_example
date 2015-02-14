class mysensu::checks {


    package { 'nagios-plugins-procs': ensure => installed; }

    sensu::check { 'mem_usage':
      command     => 'PATH=$PATH;/etc/sensu/plugins/check-ram.rb -w 50 -c -25',
      interval    => 5,
      handlers    => 'default',
      subscribers => 'all',
    }
}
