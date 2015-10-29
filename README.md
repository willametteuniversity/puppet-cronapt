[![Puppet Forge](http://img.shields.io/puppetforge/v/mniedzielski/cronapt.svg)](https://forge.puppetlabs.com/mniedzielski/cronapt)

# Puppet Module for cron-apt

Install and configure cron-apt for automatic package updates. Use it in combination with
a module to manage APT like: [puppetlabs-apt](https://github.com/puppetlabs/puppet-apt)

Available on PuppetForge as ''mniedzielski-cronapt'.

## Usage

    include apt

    # Let cron-apt update packages on demand.
    class { 'cronapt::configure':
        actions     => ['update', 'upgrade', 'notify'],
        mail_on     => 'output',
    }

## Options

        actions { update, download, upgrade, notify }
        mail_on { error, upgrade, changes, output, always }
        mail    <a valid email address>

## Parting Words

This example provides full hands-off automatic updates of packages.  Don't be scared.
