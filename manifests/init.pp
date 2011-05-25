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

  # Cannot pass anonymous arrays to functions in 2.6.8
  $v_true_false = [ '^true$', '^false$' ]
  # Must compare string values, not booleans.
  validate_re("$jre", $v_true_false)
  validate_re("$jdk", $v_true_false)
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
