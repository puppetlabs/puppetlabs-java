# Class: java
#
# This module manages the Java runtime package
#
# Parameters:
#
#  [*distribution*]
#    The java distribution to install. Can be one of "jdk" or "jre".
#
#  [*version*]
#    The version of java to install. By default, this module simply ensures
#    that java is present, and does not require a specific version.
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
class java(
  $distribution = 'jdk',
  $version      = 'present'
) {
  include java::params

  validate_re($version, 'present|installed|latest|^[._0-9a-zA-Z:-]+$')

  case $distribution {
    default: { fail('distribution must be one of jdk, jre') }
    'jdk': {
      $java_package_name = $java::params::jdk_package
    }
    'jre': {
      $java_package_name = $java::params::jre_package
    }
  }

  package { 'java':
    ensure => $version,
    name   => $java_package_name,
  }

}
