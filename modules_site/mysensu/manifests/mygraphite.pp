class mysensu::mygraphite {

  class { 'graphite':
    # gr_web_server               => 'none',
    # gr_web_cors_allow_from_all	=> true, #do we need this?
  }
}
