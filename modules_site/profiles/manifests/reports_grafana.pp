class profiles::reports_grafana (

){

  include epel

  class { 'mysensu':
    role => 'grafana',
  }
}
