class mysensu::mygraphite {

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
  }

  class { 'elasticsearch':
    autoupgrade => true
  }


  class { 'grafana':
  datasources  => {
    'graphite' => {
      'type'    => 'graphite',
      'url'     => 'http://33.33.33.4',
      'default' => 'true'
      },
      'elasticsearch' => {
        'type'      => 'elasticsearch',
        'url'       => 'http://localhost:9200',
        'index'     => 'grafana-dash',
        'grafanaDB' => 'true', # lint:ignore:quoted_booleans
        },
      }
    }

    Apache::Vhost['my.grafana.dev']->
    Class['grafana']

}
