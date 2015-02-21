class mysensu::mygrafana {

  class { 'apache': default_vhost => false }

  include epel

  apache::vhost { 'grafana':
    servername      => 'grafana',
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

    Apache::Vhost['grafana']->
    Class['grafana']

}
