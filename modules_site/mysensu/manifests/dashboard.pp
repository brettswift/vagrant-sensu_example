class mysensu::dashboard {


    class {  'uchiwa':
      install_repo => false,
      host    =>     '33.33.33.10',
      # user    =>     'guest',
      # pass    =>     'guest',
      refresh    =>     5,
      require   =>  Yumrepo['sensu'],
    }

    uchiwa::api { 'vagrant_datacenter':
      host    => '127.0.0.1',
    }
  #
  # uchiwa::api { 'API 2':
  #   host     => '10.16.1.25',
  #   ssl      => true,
  #   insecure => true,
  #   port     => 7654,
  #   user     => 'sensu',
  #   pass     => 'saBEnX8PQoyz2LG',
  #   path     => '/sensu',
  #   timeout  => 5000
  # }
}
