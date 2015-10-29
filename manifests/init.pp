#
class cronapt {
    include cronapt::install
    include cronapt::configure

    Class['cronapt::install'] -> Class['cronapt::configure']
}
