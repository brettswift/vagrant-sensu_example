class mysensu::queue (
    $rabbitmq_host = $mysensu::rabbitmq_host,
    $rabbitmq_password = $mysensu::rabbitmq_password,
    $rabbitmq_port = $mysensu::rabbitmq_port,
    $rabbitmq_vhost = $mysensu::rabbitmq_vhost,
  ){


  class { 'erlang':
    epel_enable => true,
  }

  class { 'rabbitmq':
    delete_guest_user => true,
  }

  rabbitmq_vhost { $rabbitmq_vhost :
    ensure => present,
  }

  rabbitmq_user { 'sensu':
    admin    => true,
    password => $rabbitmq_password,
  }

  #user@vhost
  rabbitmq_user_permissions { "sensu@${rabbitmq_vhost}":
    configure_permission => '.*',
    read_permission      => '.*',
    write_permission     => '.*',
}

  Class['erlang'] ->
  Class['rabbitmq']
}
