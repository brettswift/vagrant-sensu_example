class mysensu::reporting {

  class { 'graphite':
    gr_web_server               => 'none',
    gr_web_cors_allow_from_all	=> true, #do we need this?
  }

  class { 'apache': default_vhost => false }

  apache::vhost { 'my.grafana.dev':
  servername      => 'my.grafana.dev',
  port            => 8080,
  docroot         => '/opt/grafana',
  error_log_file  => 'grafana-error.log',
  access_log_file => 'grafana-access.log',
  directories     => [
      {
        path            => '/opt/grafana',
        options         => [ 'None' ],
        allow           => 'from All',
        allow_override  => [ 'None' ],
        order           => 'Allow,Deny',
      }
  ]
  }->
  class { 'grafana': }

  Class['graphite']->
  Class['grafana']
}
