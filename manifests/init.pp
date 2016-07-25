#
# Class: cronapt
# Manage cronapt package with Puppet
#
# Parameters:
#   [*actions*] - list of cron-apt actions to enable.
#   [*mail*]    - where to send email notifications.
#   [*mail_on*] - when to send email notifications.
#
# Sample Usage:
#
#   class { 'cronapt' :
#       actions => ['update', 'upgrade', 'notify'],
#       mail    => 'root',
#       mail_on => 'error',
#   }
#
class cronapt (
    $absent    = $cronapt::params::cronapt_absent,
    $actions   = $cronapt::params::cron_actions,
    $mail      = $cronapt::params::cron_mail,
    $mail_on   = $cronapt::params::cron_mail_on,
    $packages  = $cronapt::params::packages
    ) inherits cronapt::params {
    include cronapt::install
    include cronapt::configure

    Class['cronapt::install'] -> Class['cronapt::configure']
}
