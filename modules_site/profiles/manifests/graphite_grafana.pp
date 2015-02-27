class profiles::graphite_grafana (

){

  include epel
  include mysensu
  
  #
  # class { 'mysensu':
  #   roles => [
  #           'graphite',
  #           'grafana'],
  # }
}
