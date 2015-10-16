# Class: java::params
#
# This class builds a hash of JDK/JRE packages and (for Debian)
# alternatives.  For wheezy/precise, we provide Oracle JDK/JRE
# options, even though those are not in the package repositories.
#
# For more info on how to package Oracle JDK/JRE, see the Debian wiki:
# http://wiki.debian.org/JavaPackage
#
# Because the alternatives system makes it very difficult to tell
# which Java alternative is enabled, we hard code the path to bin/java
# for the config class to test if it is enabled.
class java::params {

  case $::osfamily {
    'RedHat': {
      case $::operatingsystem {
        'RedHat', 'CentOS', 'OracleLinux', 'Scientific', 'OEL': {
          if (versioncmp($::operatingsystemrelease, '5.0') < 0) {
            $jdk_package = 'java-1.6.0-sun-devel'
            $jre_package = 'java-1.6.0-sun'
          }
          elsif (versioncmp($::operatingsystemrelease, '6.3') < 0) {
            $jdk_package = 'java-1.6.0-openjdk-devel'
            $jre_package = 'java-1.6.0-openjdk'
          }
          else {
            $jdk_package = 'java-1.7.0-openjdk-devel'
            $jre_package = 'java-1.7.0-openjdk'
          }
        }
        'Fedora': {
          if (versioncmp($::operatingsystemrelease, '21') < 0) {
            $jdk_package = 'java-1.7.0-openjdk-devel'
            $jre_package = 'java-1.7.0-openjdk'
          }
          else {
            $jdk_package = 'java-1.8.0-openjdk-devel'
            $jre_package = 'java-1.8.0-openjdk'
          }
        }
        'Amazon': {
          $jdk_package = 'java-1.7.0-openjdk-devel'
          $jre_package = 'java-1.7.0-openjdk'
        }
        default: { fail("unsupported os ${::operatingsystem}") }
      }
      $java = {
        'jdk' => { 'package' => $jdk_package, },
        'jre' => { 'package' => $jre_package, },
      }
    }
    'Debian': {

      $debian_oracle_java_architecture = $::architecture ? {
        'i386'  => 'i586', # 32 bit
        default => 'x64',  # 64 bit
      }

      $debian_jdk6 = {
        'package'          => 'openjdk-6-jdk',
        'alternative'      => "java-6-openjdk-${::architecture}",
        'alternative_path' => '/usr/lib/jvm/java-6-openjdk/jre/bin/java',
        'java_home'        => '/usr/lib/jvm/java-6-openjdk/jre/',
      }
      $debian_jre6 = {
        'package'          => 'openjdk-6-jre-headless',
        'alternative'      => "java-6-openjdk-${::architecture}",
        'alternative_path' => '/usr/lib/jvm/java-6-openjdk/jre/bin/java',
        'java_home'        => '/usr/lib/jvm/java-6-openjdk/jre/',
      }
      $debian_jdk7 = {
        'package'          => 'openjdk-7-jdk',
        'alternative'      => "java-1.7.0-openjdk-${::architecture}",
        'alternative_path' => "/usr/lib/jvm/java-1.7.0-openjdk-${::architecture}/bin/java",
        'java_home'        => "/usr/lib/jvm/java-1.7.0-openjdk-${::architecture}/",
      }
      $debian_jre7 = {
        'package'          => 'openjdk-7-jre-headless',
        'alternative'      => "java-1.7.0-openjdk-${::architecture}",
        'alternative_path' => "/usr/lib/jvm/java-1.7.0-openjdk-${::architecture}/bin/java",
        'java_home'        => "/usr/lib/jvm/java-1.7.0-openjdk-${::architecture}/",
      }
      $debian_jdk8 = {
        'package'          => 'openjdk-8-jdk',
        'alternative'      => "java-1.8.0-openjdk-${::architecture}",
        'alternative_path' => "/usr/lib/jvm/java-1.8.0-openjdk-${::architecture}/bin/java",
        'java_home'        => "/usr/lib/jvm/java-1.8.0-openjdk-${::architecture}/",
      }
      $debian_jre8 = {
        'package'          => 'openjdk-8-jre-headless',
        'alternative'      => "java-1.8.0-openjdk-${::architecture}",
        'alternative_path' => "/usr/lib/jvm/java-1.8.0-openjdk-${::architecture}/bin/java",
        'java_home'        => "/usr/lib/jvm/java-1.8.0-openjdk-${::architecture}/",
      }
      $debian_sun_jdk6 = {
        'package'          => 'sun-java6-jdk',
        'alternative'      => 'java-6-sun',
        'alternative_path' => '/usr/lib/jvm/java-6-sun/jre/bin/java',
        'java_home'        => '/usr/lib/jvm/java-6-sun/jre/',
      }
      $debian_sun_jre6 = {
        'package'          => 'sun-java6-jre',
        'alternative'      => 'java-6-sun',
        'alternative_path' => '/usr/lib/jvm/java-6-sun/jre/bin/java',
        'java_home'        => '/usr/lib/jvm/java-6-sun/jre/',
      }
      $debian_oracle_jdk7 = {
        'package'          => 'oracle-j2sdk1.7',
        'alternative'      => 'j2sdk1.7-oracle',
        'alternative_path' => '/usr/lib/jvm/j2sdk1.7-oracle/jre/bin/java',
        'java_home'        => '/usr/lib/jvm/j2sdk1.7-oracle/jre/',
      }
      $debian_oracle_jre7 = {
        'package'          => 'oracle-j2re1.7',
        'alternative'      => 'j2re1.7-oracle',
        'alternative_path' => '/usr/lib/jvm/j2re1.7-oracle/bin/java',
        'java_home'        => '/usr/lib/jvm/j2re1.7-oracle/',
      }
      $debian_oracle_jdk8 = {
        'package'          => 'oracle-java8-jdk',
        'alternative'      => "jdk-8-oracle-${debian_oracle_java_architecture}",
        'alternative_path' => "/usr/lib/jvm/jdk-8-oracle-${debian_oracle_java_architecture}/jre/bin/java",
        'java_home'        => "/usr/lib/jvm/jdk-8-oracle-${debian_oracle_java_architecture}/",
      }
      $debian_oracle_jre8 = {
        'package'          => 'oracle-java8-jre',
        'alternative'      => "jre-8-oracle-${debian_oracle_java_architecture}",
        'alternative_path' => "/usr/lib/jvm/jre-8-oracle-${debian_oracle_java_architecture}/bin/java",
        'java_home'        => "/usr/lib/jvm/jre-8-oracle-${debian_oracle_java_architecture}/",
      }

      case $::lsbdistcodename {
        'lenny', 'squeeze', 'lucid', 'natty': {
          $java  = {
            'jdk'     => $debian_jdk6,
            'jre'     => $debian_jre6,
            'sun-jre' => $debian_sun_jre6,
            'sun-jdk' => $debian_sun_jdk6,
          }
        }
        'wheezy', 'jessie', 'precise','quantal','raring','saucy', 'trusty', 'utopic': {
          $java =  {
            'jdk'         => $debian_jdk7,
            'jre'         => $debian_jre7,
            'jdk7'        => $debian_jdk7,
            'jre7'        => $debian_jre7,
            'jdk8'        => $debian_jdk8,
            'jre8'        => $debian_jre8,
            'oracle-jdk'  => $debian_oracle_jdk7,
            'oracle-jre'  => $debian_oracle_jre7,
            'oracle-jdk7' => $debian_oracle_jdk7,
            'oracle-jre7' => $debian_oracle_jre7,
            'oracle-jdk8' => $debian_oracle_jdk8,
            'oracle-jre8' => $debian_oracle_jre8,
          }
        }
        'vivid': {
          $java =  {
            'jdk'  => $debian_jdk8,
            'jre'  => $debian_jre8,
            'jdk8' => $debian_jdk8,
            'jre8' => $debian_jre8,
          }
        }
        default: { fail("unsupported release ${::lsbdistcodename}") }
      }
    }
    'OpenBSD': {
      $java = {
        'jdk' => { 'package' => 'jdk', },
        'jre' => { 'package' => 'jre', },
      }
    }
    'Solaris': {
      $java = {
        'jdk' => { 'package' => 'developer/java/jdk-7', },
        'jre' => { 'package' => 'runtime/java/jre-7', },
      }
    }
    'Suse': {
      case $::operatingsystem {
        'SLES': {
          case $::operatingsystemmajrelease{
            default: {
              $jdk_package = 'java-1_6_0-ibm-devel'
              $jre_package = 'java-1_6_0-ibm'
            }
            '12': {
              $jdk_package = 'java-1_7_0-openjdk-devel'
              $jre_package = 'java-1_7_0-openjdk'
            }
          }
        }
        'OpenSuSE': {
          $jdk_package = 'java-1_7_0-openjdk-devel'
          $jre_package = 'java-1_7_0-openjdk'
        }
        default: {
          $jdk_package = 'java-1_6_0-ibm-devel'
          $jre_package = 'java-1_6_0-ibm'
        }
      }
      $java = {
        'jdk' => { 'package' => $jdk_package, },
        'jre' => { 'package' => $jre_package, },
      }
    }
    default: { fail("unsupported platform ${::osfamily}") }
  }
}
