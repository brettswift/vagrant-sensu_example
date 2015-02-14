class mysensu (
    $role = '',
  ) {

  if($role == 'server'){
    include mysensu::server
  }
  elsif($role == 'agent'){
    include mysensu::agent
  }
  elsif($role == 'reports'){
    include mysensu::reporting
  }
}
