class mysensu::server  (
    $graphite_host = $mysensu::graphite_host,
  ){

    contain redis
    contain mysensu::queue
    include mysensu::checks
    include mysensu::dashboard

    sensu::handler { 'default':
      command => 'mail -s \'sensu alert\' brett@brettswift.com',
    }

    file { 'graphite relay config':
      path    => '/etc/sensu/conf.d/relay.json',
      content => template('mysensu/relay.json.erb'),
    }

    sensu::extension { 'graphite_metrics':
      source  => "puppet:///modules/mysensu/extensions/graphite/metrics.rb",
    }

    sensu::extension { 'graphite_relay':
      source  => "puppet:///modules/mysensu/extensions/graphite/relay.rb",
    }

    Class['redis'] ->
    Class['mysensu::queue'] ->
    Class['sensu'] ->
    Class['mysensu::dashboard']

}
