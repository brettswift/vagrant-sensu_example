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

    sensu::handler { 'default':
      command => 'mail -s \'sensu alert\' brett@brettswift.com',
    }

    #
    # file { 'graphite relay':
    #   path    => ' /etc/sensu/conf.d/config_relay.json',
    #   content => template('mysensu/config_relay.json.erb'),
    # }

    # not available in this version of sensu-puppet
    # sensu::extension { 'graphite_metrics':
    #   source  => "puppet:///modules/mysensu/extensions/metrics_relay/metrics.rb",
    #   config  => {
    #     'metrics_foobar' => 'value',
    #   }
    # }

    # sensu::extension { 'graphite_metrics':
    #   source  => "puppet:///modules/mysensu/extensions/metrics_relay/relay.rb",
    #   config  => {
    #     'foobar_setting' => 'value',
    #   }
    # }



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

    include mysensu::checks

    include mysensu::dashboard

    Class['redis'] ->
    Class['mysensu::queue'] ->
    Class['sensu'] ->
    Class['mysensu::dashboard']

}
