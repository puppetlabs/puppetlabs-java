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
  $version      = 'present'
) {

  validate_re($distribution, '^jdk$|^jre$|^java.*$')
  validate_re($version, 'installed|^[._0-9a-zA-Z:-]+$')

  anchor { 'java::begin': }
  anchor { 'java::end': }

  case $operatingsystem {

    centos, redhat, oel, amazon: {

      class { 'java::package_redhat':
        version      => $version,
        distribution => $distribution,
        require      => Anchor['java::begin'],
        before       => Anchor['java::end'],
      }

    }

    debian, ubuntu: {

      case $lsbdistcodename {
        squeeze, lucid: {
          $distribution_debian = $distribution ? {
            jdk => 'openjdk-6-jdk',
            jre => 'openjdk-6-jre-headless',
          }
        }
        wheezy, precise: {
          $distribution_debian = $distribution ? {
            jdk => 'openjdk-7-jdk',
            jre => 'openjdk-7-jre-headless',
          }
        }
        default: {
          fail("operatingsystem distribution ${lsbdistcodename} is not supported")
        }
      }

      class { 'java::package_debian':
        version      => $version,
        distribution => $distribution_debian,
        require      => Anchor['java::begin'],
        before       => Anchor['java::end'],
      }

    }

    default: {
      fail("operatingsystem ${operatingsystem} is not supported")
    }

  }

}
