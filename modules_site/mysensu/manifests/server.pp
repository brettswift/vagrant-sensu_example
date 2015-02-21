class mysensu::server {

    contain redis
    contain mysensu::queue

    class { 'sensu':
      rabbitmq_user        => 'sensu',
      rabbitmq_password    => 'password',
      rabbitmq_host        => 'sensuserver',
      rabbitmq_vhost       => '/sensu',
      server               => true,
      client               => true,
      subscriptions        => ['all','sensu-test'],
      api                  => true,
      client_name          => $::hostname,
      client_address       => $::ipaddress_eth1,
      # use_embedded_ruby    => true,
      # sensu_plugin_version => present,
      plugins              => [
      #   'puppet:///mysensu/plugins/ntp.rb',
      #   'puppet:///mysensu/plugins/postfix.rb'
          'puppet:///modules/mysensu/check-ram.rb',
          'puppet:///modules/mysensu/vmstat-metrics.rb'
      ]
    }

    sensu::handler { 'default':
      command => 'mail -s \'sensu alert\' brett@brettswift.com',
    }

    file { 'graphite relay config':
      path    => '/etc/sensu/conf.d/relay.json',
      content => template('mysensu/relay.json.erb'),
    }

    # not available in this version of sensu-puppet
    sensu::extension { 'graphite_metrics':
      source  => "puppet:///modules/mysensu/extensions/graphite/metrics.rb",
      # config  => {
      #   'metrics_foobar' => 'value',
      # }
    }

    sensu::extension { 'graphite_relay':
      source  => "puppet:///modules/mysensu/extensions/graphite/relay.rb",
      # config  => {
      #   'foobar_setting' => 'value',
      # }
    }



    include mysensu::checks

    include mysensu::dashboard

    Class['redis'] ->
    Class['mysensu::queue'] ->
    Class['sensu'] ->
    Class['mysensu::dashboard']

}
