Puppet Module for cron-apt
==========================

Install and configure cron-apt for automatic package updates. Use it in combination with a module to manage APT itself like: [puppetlabs-apt](https://github.com/puppetlabs/puppet-apt)

For Example:

    include apt

    # When APT updates, notify any package set to ensure => latest
         Exec["apt-update"] -> Package <| ensure == latest |>

    # Let cron-apt update packages on demand.
    class { 'cronapt::configure':
        actions     => ['update', 'upgrade', 'notify'],
        mail_on     => 'output',
    }
