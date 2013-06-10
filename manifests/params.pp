# Class: java::params
#
# This class sets the value of two variables, jdk_package and jre_package,
# appropriate for the client system in question.
#
class java::params {

  case $::osfamily {
    default: { fail("unsupported platform ${::osfamily}") }
    'RedHat': {
      case $::operatingsystem {
        default: { fail("unsupported os ${::operatingsystem}") }
        'RedHat', 'CentOS': {
          if (versioncmp($::operatingsystemrelease, '6.3') < 0) {
            $jdk_package = 'java-1.6.0-openjdk-devel'
            $jre_package = 'java-1.6.0-openjdk'
          }
          else {
            $jdk_package = 'java-1.7.0-openjdk-devel'
            $jre_package = 'java-1.7.0-openjdk'
          }
        }
        'Fedora': {
          $jdk_package = 'java'
          $jre_package = 'java'
        }
      }
    }
    'Debian': {
      case $::lsbdistcodename {
        default: { fail("unsupported release ${::lsbdistcodename}") }
        'squeeze', 'lucid': {
          $jdk_package = 'openjdk-6-jdk'
          $jre_package = 'openjdk-6-jre-headless'
        }
        'wheezy', 'precise','quantal','raring': {
          $jdk_package = 'openjdk-7-jdk'
          $jre_package = 'openjdk-7-jre-headless'
        }
      }
    }
    'Solaris': {
      $jdk_package = 'developer/java/jdk-7'
      $jre_package = 'runtime/java/jre-7'
    }
    'Suse': {
      case $::operatingsystem {
        default: {
          $jdk_package = 'java-1_6_0-ibm-devel'
          $jre_package = 'java-1_6_0-ibm'
        }

        'OpenSuSE': {
          $jdk_package = 'java-1_7_0-openjdk-devel'
          $jre_package = 'java-1_7_0-openjdk'
        }
      }
    }
  }

}
