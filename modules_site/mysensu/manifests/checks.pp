class mysensu::checks {


    #TODO: allow hiera injection of schemes

    package { 'nagios-plugins-procs': ensure => installed; }

    sensu::check { 'mem_usage':
      command     => 'PATH=$PATH;/opt/sensu/embedded/bin/ruby /etc/sensu/plugins/check-ram.rb -c -15 -w 30',
      interval    => 5,
      handlers    => ['default','relay'],
      subscribers => 'all',
    }


    sensu::check { 'vm_stat':
      type        => 'metric',
      command     => 'PATH=$PATH;/opt/sensu/embedded/bin/ruby /etc/sensu/plugins/vmstat-metrics.rb',
      interval    => 5,
      handlers    => ['default','relay'],
      subscribers => 'all',
    }

    sensu::check { 'cpu_load':
      type        => 'metric',
      command     => 'PATH=$PATH;/opt/sensu/embedded/bin/ruby /etc/sensu/plugins/load-metrics.rb',
      interval    => 5,
      handlers    => ['relay'],
      subscribers => 'all',
    }


    sensu::check { 'memory_metrics':
      type        => 'metric',
      command     => 'PATH=$PATH;/opt/sensu/embedded/bin/ruby /etc/sensu/plugins/memory-metrics.rb',
      interval    => 5,
      handlers    => ['relay'],
      subscribers => 'all',
    }


    # sensu::check { 'check_for_puppet':
    #   command     => 'PATH=$PATH:/usr/lib/nagios/plugins; /opt/sensu/embedded/bin/ruby /etc/sensu/plugins/check_procs -w 1:1 -C puppet',
    #   handlers    => 'default',
    #   subscribers => 'sensu-test'
    # }


}
