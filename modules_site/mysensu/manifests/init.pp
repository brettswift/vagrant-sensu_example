class mysensu (
    $roles = [],
    $sensu_host,
    $graphite_host,
    $rabbitmq_password,
    $rabbitmq_vhost,
  ) {

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

  if member($roles, 'server'){
    include mysensu::server
  }

  if member($roles, 'graphite'){
    include mysensu::mygraphite
  }

  if member($roles, 'grafana'){
    include mysensu::mygrafana
  }

}
