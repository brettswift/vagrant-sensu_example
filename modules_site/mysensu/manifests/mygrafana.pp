class mysensu::mygrafana (
    $graphite_host = $mysensu::graphite_host,
  ){

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

  class { 'elasticsearch' :
    autoupgrade  => true,
    manage_repo  => true,
    repo_version => '1.4',
    java_install => true,
  }

  $elastic_search_instance = 'grafana-dash'
  elasticsearch::instance { $elastic_search_instance :
    config => {'http.cors.enabled' => 'true'},
  }

  class { 'grafana':
  datasources  => {
    'graphite' => {
      'type'    => 'graphite',
      'url'     => "http://${graphite_host}",
      'default' => 'true'
      },
      'elasticsearch' => {
        'type'      => 'elasticsearch',
        'url'       => 'http://33.33.33.5:9200',
        'index'     => $elastic_search_instance,
        'grafanaDB' => 'true', # lint:ignore:quoted_booleans
        },
      }
    }

    Apache::Vhost['grafana']->
    Class['grafana']

}
