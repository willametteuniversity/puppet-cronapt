#
# Class: apt::cron
#
# Configure the actions of cron-apt.
#
# Parameters:
#   [*actions*] - list of cron-apt actions to enable.
#
# Sample Usage:
#
#   class { 'apt::cron' :
#       actions => ['update', 'notify']
#   }
#
class apt::cron (
	$actions = $apt::params::cron_actions
) inherits apt::params {

	#
	# Install
	#
	package { "cron-apt" :
		ensure => installed
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
