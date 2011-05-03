
class apt::cron {

  include apt::cron::package

  file { "/etc/cron-apt/action.d/0-update" :
    ensure  => absent,
    require => Class["apt::cron::package"],
  }

}

class apt::cron::package {
  
  package { "cron-apt" :
    ensure => installed
  }

}


