# Class: java
#
# This module manages the Java runtime package
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
# [Remember: No empty lines between comments and class definition]
class java(
  $jre = false,
  $jdk = true,
  $version='1.6.0_25-fcs'
) {

  validate_re($jre, [ '^true$', '^false$' ])
  validate_re($jdk, [ '^true$', '^false$' ])
  validate_re($version, '^[._0-9a-zA-Z:-]+$')

  $jre_real     = $jre
  $jdk_real     = $jdk
  $version_real = $version

  if $jre_real {
    class { 'java::jre_package':
      version => $version_real,
      stage   => 'runtime',
    }
  }

  if $jdk_real {
    class { 'java::jdk_package':
      version => $version_real,
      stage   => 'runtime',
    }
  }

}
