class mysensu (
    $role = '',
  ) {

  if($role == 'server'){
    include mysensu::server
  }else{
    include mysensu::agent
  }
}
