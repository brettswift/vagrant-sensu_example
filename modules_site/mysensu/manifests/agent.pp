class mysensu::agent {

  contain mysensu::queue

 class { 'sensu':
  #  purge_config       => true,
   rabbitmq_user     => 'sensu',
   rabbitmq_password => 'password',
   rabbitmq_host     => 'sensuserver',
   rabbitmq_vhost    => '/sensu',
   subscriptions     => ['all','sensu-test'],
   client_name       => $::hostname,
   client_address    => $::ipaddress_eth1,
   plugins           => [
   #   'puppet:///mysensu/plugins/ntp.rb',
   #   'puppet:///mysensu/plugins/postfix.rb'
   'puppet:///modules/mysensu/check-ram.rb'
   ]
 }

  include mysensu::checks

  package { 'nagios-plugins-procs': ensure => installed; }

  # package { 'redphone':
  #   ensure   => 'installed',
  #   provider => sensu_gem,
  # }


  Class['mysensu::queue'] ->
  Package['nagios-plugins-procs']->
  Class['sensu']
}
