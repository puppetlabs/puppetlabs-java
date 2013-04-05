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
#  [*package*]
#    The name of the java package. This is configurable in case a non-standard
#    java package is desired.
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
class java(
  $distribution = 'jdk',
  $version      = 'present',
  $package      = undef,
) {
  include java::params

  validate_re($version, 'present|installed|latest|^[._0-9a-zA-Z:-]+$')

  case $distribution {
    default: { fail('distribution must be one of jdk, jre') }
    'jdk': {
      $default_package_name = $java::params::jdk_package
    }
    'jre': {
      $default_package_name = $java::params::jre_package
    }
  }

  $use_java_package_name = $package ? {
    default => $package,
    undef   => $default_package_name,
  }

  package { 'java':
    ensure => $version,
    name   => $use_java_package_name,
  }

}
