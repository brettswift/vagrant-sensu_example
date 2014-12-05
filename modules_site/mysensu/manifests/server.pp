class mysensu::server {

    contain redis
    contain mysensu::queue

    class { 'sensu':
      rabbitmq_user     => 'sensu',
      rabbitmq_password => 'password',
      rabbitmq_host     => 'sensuserver',
      rabbitmq_vhost     => '/sensu',
      server            => true,
      client            => true,
      api               => true,
      client_name       => $::hostname,
      client_address    => $::ipaddress_eth1,
      use_embedded_ruby => true,
      plugins           => [
      #   'puppet:///mysensu/plugins/ntp.rb',
      #   'puppet:///mysensu/plugins/postfix.rb'
          'puppet:///modules/mysensu/check-ram.rb'
      ]
    }

    package { 'nagios-plugins-procs': ensure => installed; }


    sensu::handler { 'default':
      command => 'mail -s \'sensu alert\' brett@brettswift.com',
    }

    # sensu::check { 'check_for_puppet':
    #   command     => 'PATH=$PATH:/usr/lib/nagios/plugins check_procs -w 1:1 -C puppet',
    #   handlers    => 'default',
    #   subscribers => 'sensu-test'
    # }
    #
    # file { '/etc/sensu/plugins/check-ram.rb':
    #   ensure => 'present',
    #   source => 'puppet:///modules/mysensu/check-ram.rb',
    #   mode   => 0755,
    # }

    sensu::check { 'mem_usage':
      command     => 'PATH=$PATH;/etc/sensu/plugins/check-ram.rb -w 50 -c -25',
      interval    => 5,
      handlers    => 'default',
      subscribers => 'all',
    }

    include mysensu::dashboard

    Class['redis'] ->
    Class['mysensu::queue'] ->
    Class['sensu'] ->
    Class['mysensu::dashboard']

}
