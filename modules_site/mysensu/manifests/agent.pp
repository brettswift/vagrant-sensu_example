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
   }

    package { 'nagios-plugins-procs': ensure => installed; }

  Class['mysensu::queue'] ->
  Package['nagios-plugins-procs']->
  Class['sensu']
}
