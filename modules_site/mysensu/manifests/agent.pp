class mysensu::agent {
  contain mysensu::queue
  include mysensu::checks

  #TODO: merge hiera hash for subscriptions
  class { 'sensu':
     plugins           => [
     'puppet:///modules/mysensu/plugins/system/check-ram.rb',
     'puppet:///modules/mysensu/plugins/system/vmstat-metrics.rb',
     'puppet:///modules/mysensu/plugins/system/memory-metrics.rb',
     'puppet:///modules/mysensu/plugins/system/load-metrics.rb'
     ]
  }

  Class['mysensu::queue'] ->
  Class['sensu']
}
