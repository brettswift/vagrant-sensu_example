class mysensu (
    $roles = [],
    $sensu_host,
    $graphite_host,
    $graphite_port = $mysensu::params::graphite_port,
    $grafana_port  = $mysensu::params::grafana_port,
    $rabbitmq_password,
    $rabbitmq_vhost,
  ) inherits mysensu::params {

  #TODO: validation of roles
  # hiera structure:
  # mysensu::roles:
  #   - agent
  #   - server
  #   - dashboard
  #   - graphite
  #   - grafana

  include mysensu::agent
  if !is_array($roles){
    fail("mysensu::roles: must be an array.")
  }

  $valid_roles = ['agent','server','graphite','grafana']
  $valid_role_as_string = join($valid_roles,',')
  if !member($valid_roles, $roles){
    fail("Valid roles are: ${valid_role_as_string}, but you gave me: join(${roles},',')")
  }

  if member($roles, 'server'){
    include mysensu::server
  }

  if member($roles, 'graphite'){
    include mysensu::mygraphite
  }

  if member($roles, 'grafana'){
    include mysensu::mygrafana
  }

  if member($roles, 'graphite','grafana'){

    Class['mysensu::agent']->
    Class['mysensu::mygraphite']->
    Class['mysensu::mygrafana']
  }

}
