class profiles::sensu_monitor (

){

  class { 'mysensu':
    role => 'server',
  }

}
