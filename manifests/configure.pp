#
# Class: cronapt::configure
#
# Configure the actions of cron-apt.
#
# Parameters:
#   [*actions*] - list of cron-apt actions to enable.
#   [*mail*]    - where to send email notifications.
#   [*mail_on*] - when to send email notifications.
#
# Sample Usage:
#
#   class { 'cronapt::configure' :
#       actions => ['update', 'upgrade', 'notify'],
#       mail    => 'root',
#       mail_on => 'error',
#   }
#
class cronapt::configure (
	$actions = $cronapt::params::cron_actions,
	$mail    = $cronapt::params::cron_mail,
	$mail_on = $cronapt::params::cron_mail_on
) inherits cronapt::params {

	#
	# Configure
	#
	$mail_on_value = $mail_on ? {
		'error'   => 'error',
		'upgrade' => 'upgrade',
		'changes' => 'changes',
		'output'  => 'output',
		'always'  => 'always',
		default   => 'always',
	}
	augeas { "cronapt-mail_config" :
		context   => "/files/etc/cron-apt/config",
		changes   => [
			"set MAILON $mail_on_value",
			"set MAILTO $mail",
		],
		require   => Class["cronapt::install"],
	}

	#
	# Actions
	#
	if ('update' in $actions) {
		file { "/etc/cron-apt/action.d/0-update" :
			ensure  => "file",
			source  => "puppet:///modules/cronapt/update",
			require => Class["cronapt::install"],
		}
	}

	if ('upgrade' in $actions) {
		file { "/etc/cron-apt/action.d/5-upgrade" :
			ensure  => "file",
			source  => "puppet:///modules/cronapt/upgrade",
			require => Class["cronapt::install"],
		}
	}

	if ('notify' in $actions) {
		file { "/etc/cron-apt/action.d/9-notify" :
			ensure  => "file",
			source  => "puppet:///modules/cronapt/notify",
			require => Class["cronapt::install"],
		}
	}

	include cronapt::install
	Class['cronapt::install'] -> Class['cronapt::configure']
}
