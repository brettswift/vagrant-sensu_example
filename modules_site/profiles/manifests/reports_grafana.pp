class profiles::reports_grafana (

){

  include epel

  class { 'mysensu':
    roles => ['grafana'],
  }
}
