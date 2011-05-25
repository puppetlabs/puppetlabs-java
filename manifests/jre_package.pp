# Class: java:jre_package
#
#   class description goes here.
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
class java::jre_package (
  $version
) {

  validate_re($version, '^[._0-9a-zA-Z:-]+$')

  $version_real = $version

  package { 'jre':
    ensure => $version_real,
    alias  => 'java',
  }

}
