Puppet Module for cron-apt
==========================

Install and configure cron-apt for automatic package updates. Use it in combination with a module to manage APT like: [puppetlabs-apt](https://github.com/puppetlabs/puppet-apt)

Available on PuppetForge as ''mniedzielski-cronapt'.

---------------------

    include apt

    # When APT updates, notify any package set to ensure => latest
    Exec["apt-update"] -> Package <| ensure == latest |>

    # Let cron-apt update packages on demand.
    class { 'cronapt::configure':
        actions     => ['update', 'upgrade', 'notify'],
        mail_on     => 'output',
    }

---------------------

This example provides full hands-off automatic updates of packages.  Don't be scared.
