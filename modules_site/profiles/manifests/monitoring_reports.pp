class profiles::monitoring_reports (

){

  include epel
  
  class { 'mysensu':
    role => 'reports',
  }
}
