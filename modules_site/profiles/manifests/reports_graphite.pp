class profiles::reports_graphite (

){

  include epel

  class { 'mysensu':
    roles => ['graphite'],
  }
}
