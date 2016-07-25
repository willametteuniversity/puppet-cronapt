#
# Class: cronapt::configure
#
# Configure the actions of cron-apt.
#
class cronapt::configure {

    # Configuration
    $mail_on_value = $cronapt::mail_on ? {
        'error'    => 'error',
        'upgrade'  => 'upgrade',
        'changes'  => 'changes',
        'output'   => 'output',
        'always'   => 'always',
        default    => 'always',
    }
    augeas { 'cronapt-mail_config' :
        context => '/files/etc/cron-apt/config',
        changes => [
                      "set MAILON ${mail_on_value}",
                      "set MAILTO ${cronapt::mail}",
                      ],
        require => Class['cronapt::install'],
    }

    # Actions
    if ('update' in $cronapt::actions) {
        file { '/etc/cron-apt/action.d/0-update' :
            ensure  => 'file',
            source  => 'puppet:///modules/cronapt/update',
            require => Class['cronapt::install'],
        }
    }
    
    if ('download' in $cronapt::actions) {
        file { '/etc/cron-apt/action.d/3-download' :
            ensure  => 'file',
            source  => 'puppet:///modules/cronapt/download',
            require => Class['cronapt::install'],
        }
    }
    
    if ('upgrade' in $cronapt::actions) {
        file { '/etc/cron-apt/action.d/5-upgrade' :
            ensure  => 'file',
            source  => 'puppet:///modules/cronapt/upgrade',
            require => Class['cronapt::install'],
        }
    }
    
    if ('notify' in $cronapt::actions) {
        file { '/etc/cron-apt/action.d/9-notify' :
            ensure  => 'file',
            source  => 'puppet:///modules/cronapt/notify',
            require => Class['cronapt::install'],
        }
    }
}
