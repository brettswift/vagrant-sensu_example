class profiles::sensu_agent {


  package { 'json':
    ensure   => 'installed',
    provider => 'gem',
  }

  include mysensu

}
