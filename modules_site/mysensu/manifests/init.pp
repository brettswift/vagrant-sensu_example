class mysensu (
    $role = '',
  ) {

  if($role == 'server'){
    include mysensu::server
  }
  elsif($role == 'agent'){
    include mysensu::agent
  }
  elsif($role == 'graphite'){
    include mysensu::mygraphite
  }
  elsif($role == 'grafana'){
    include mysensu::mygrafana
  }
  else{
    fail("mysensu role: '${role}' is not supported")
  }
}
