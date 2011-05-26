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
  $distribution = 'jdk',
  $version      = 'installed'
) {

  # Cannot pass anonymous arrays to functions in 2.6.8
  $v_distribution = [ '^jre$', '^jdk$' ]
  # Must compare string values, not booleans.
  validate_re($version, '^[._0-9a-zA-Z:-]+$')
  validate_re($distribution, $v_distribution)

  $version_real      = $version
  $distribution_real = $distribution

  case $distribution_real {
    jre: {
      class { 'java::jre_package':
        version => $version_real,
        stage   => 'runtime',
      }
    }
    jdk: {
      class { 'java::jdk_package':
        version => $version_real,
        stage   => 'runtime',
      }
    }
  }

}
