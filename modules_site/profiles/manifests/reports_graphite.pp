class profiles::reports_graphite (

){

  include epel

  class { 'mysensu':
    role => 'graphite',
  }
}
