#
# Class: cronapt::install
#
class cronapt::install {
    package { $cronapt::packages :
        ensure => $cronapt::absent ? {
            default     => 'installed',
            true        => 'absent',
        }
    }
}
