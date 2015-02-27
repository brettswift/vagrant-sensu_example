Exec { path => [ "/bin", "/sbin" , "/usr/bin", "/usr/sbin" ] }

#deprecation warning avoidance for allow_virtual
if versioncmp($::puppetversion, '3.6.0') >= 0 {
    Package {
        allow_virtual => false,
    }
}

node /^sensuserver/, /us-west-2/{

	include roles::monitoring_server

}

node /^agent.+/ {
  include roles::agent
}


node /^reports.+/ {
  include roles::reports
}
