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

  validate_re($distribution, '^jdk$|^jre$')
  validate_re($version, 'installed|^[._0-9a-zA-Z:-]+$')

  anchor { 'java::begin': }
  anchor { 'java::end': }

  case $operatingsystem {

    centos, redhat, oel: {

      class { 'java::package_redhat':
        version      => $version,
        distribution => $distribution,
        require      => Anchor['java::begin'],
        before       => Anchor['java::end'],
      }

    }

    debian, ubuntu: {

      $distribution_debian = $distribution ? {
        jdk => 'sun-java6-jdk',
        jre => 'sun-java6-jre',
      }
      class { 'java::package_debian':
        version      => $version,
        distribution => $distribution_debian,
        require      => Anchor['java::begin'],
        before       => Anchor['java::end'],
      }

    }

    default: {
      fail("operatingsystem $operatingsystem is not supported")
    }

  }

}
