#
# Class: apt::cron
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
#   class { 'apt::cron' :
#       actions => ['update', 'notify'],
#       mail => 'root',
#       mail_on => 'error',
#   }
#
class apt::cron (
	$actions = $apt::params::cron_actions,
	$mail = $apt::params::cron_mail,
	$mail_on = $apt::params::cron_mail_on
) inherits apt::params {

	#
	# Install
	#
	package { "cron-apt" :
		ensure => installed
	}

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
	augeas { "cron_apt-mail_config" :
		context => "/files/etc/cron-apt/config",
		changes => [
			"set MAILON $mail_on_value",
			"set MAILTO $mail",
		],
		require => Package['cron-apt'],
	}

	#
	# Actions
	#
	if ('update' in $actions) {
		file { "/etc/cron-apt/action.d/0-update" :
			ensure  => "file",
			source => "puppet:///modules/apt/update",
			require => Package["cron-apt"],
		}
	}

	if ('download' in $actions) {
		file { "/etc/cron-apt/action.d/3-download" :
			ensure  => "file",
			source => "puppet:///modules/apt/download",
			require => Package["cron-apt"],
		}
	}

	if ('notify' in $actions) {
		file { "/etc/cron-apt/action.d/9-notify" :
			ensure  => "file",
			source => "puppet:///modules/apt/update",
			require => Package["cron-apt"],
		}
	}

}
