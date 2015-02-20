  # apache::vhost { 'my.grafana.dev':
  #   servername      => 'my.grafana.dev',
  #   port            => 8080,
  #   docroot         => '/opt/grafana',
  #   error_log_file  => 'grafana-error.log',
  #   access_log_file => 'grafana-access.log',
  #   directories     => [
  #       {
  #         path            => '/opt/grafana',
  #         options         => [ 'None' ],
  #         allow           => 'from All',
  #         allow_override  => [ 'None' ],
  #         order           => 'Allow,Deny',
  #       }
  #   ]
  # }
