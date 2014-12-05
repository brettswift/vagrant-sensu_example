class mysensu::queue {


  class { 'erlang':
    epel_enable => true,
  }

  class { 'rabbitmq':
    delete_guest_user => true,
  }

  rabbitmq_vhost { '/sensu':
    ensure => present,
  }

  rabbitmq_user { 'sensu':
    admin    => true,
    password => 'password',
  }

  #user@vhost
  rabbitmq_user_permissions { 'sensu@/sensu':
    configure_permission => '.*',
    read_permission      => '.*',
    write_permission     => '.*',
}

  Class['erlang'] ->
  Class['rabbitmq']
}
