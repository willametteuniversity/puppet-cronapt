#
# Class: cronapt::install
#
class cronapt::install (
    $packages  = $cronapt::params::packages
    ) inherits cronapt::params {

    # Install
    package { $packages :
        ensure => $cronapt::params::absent ? {
                    false     => 'installed',
                    default   => 'absent',
                  }
    }
}
