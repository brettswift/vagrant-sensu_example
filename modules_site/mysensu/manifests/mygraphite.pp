class mysensu::mygraphite {

  include epel

  class { 'graphite':
    # gr_web_server               => 'none',
    gr_web_cors_allow_from_all	=> true, #graphite needs this
  }
}
