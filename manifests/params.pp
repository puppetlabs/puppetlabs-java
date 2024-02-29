# @summary
#   This class builds a hash of JDK/JRE packages and (for Debian)
#   alternatives.  For wheezy/precise, we provide Oracle JDK/JRE
#   options, even though those are not in the package repositories.
#
# @api private
class java::params {
  case $facts['os']['family'] {
    'RedHat': {
      case $facts['os']['name'] {
        'AlmaLinux', 'Rocky', 'RedHat', 'CentOS', 'OracleLinux', 'Scientific', 'OEL', 'SLC', 'CloudLinux': {
          # See PR#160 / c8e46b5 for why >= 6.3 < 7.1
          if (versioncmp($facts['os']['release']['full'], '7.1') < 0) {
            $openjdk = '1.7.0'
          } else {
            $openjdk = '1.8.0'
          }
          $jdk_package = "java-${openjdk}-openjdk-devel"
          $jre_package = "java-${openjdk}-openjdk"
          $java_home   = "/usr/lib/jvm/java-${openjdk}/"
        }
        'Fedora': {
          if (versioncmp($facts['os']['release']['full'], '21') < 0) {
            $openjdk = '1.7.0'
          } else {
            $openjdk = '1.8.0'
          }
          $jdk_package = "java-${openjdk}-openjdk-devel"
          $jre_package = "java-${openjdk}-openjdk"
          $java_home   = "/usr/lib/jvm/java-${openjdk}-openjdk-${facts['os']['architecture']}/"
        }
        'Amazon': {
          $jdk_package = 'java-1.7.0-openjdk-devel'
          $jre_package = 'java-1.7.0-openjdk'
          $java_home   = "/usr/lib/jvm/java-1.7.0-openjdk-${facts['os']['architecture']}/"
        }
        default: { fail("unsupported os ${facts['os']['name']}") }
      }
      $java = {
        'jdk' => {
          'package'   => $jdk_package,
          'java_home' => $java_home,
        },
        'jre' => {
          'package'   => $jre_package,
          'java_home' => $java_home,
        },
      }
    }
    'Debian': {
      $oracle_architecture = $facts['os']['architecture'] ? {
        'amd64' => 'x64',
        default => $facts['os']['architecture']
      }
      $openjdk_architecture = $facts['os']['architecture'] ? {
        'aarch64' => 'arm64',
        'armv7l'  => 'armhf',
        default   => $facts['os']['architecture']
      }
      case $facts['os']['release']['major'] {
        '10', '11', '18.04', '18.10', '19.04', '19.10', '20.04', '22.04': {
          $openjdk = 11
        }
        default: { fail("unsupported release ${facts['os']['release']['major']}") }
      }
      $java = {
        'jdk' => {
          'package'          => "openjdk-${openjdk}-jdk",
          'alternative'      => "java-1.${openjdk}.0-openjdk-${openjdk_architecture}",
          'alternative_path' => "/usr/lib/jvm/java-1.${openjdk}.0-openjdk-${openjdk_architecture}/bin/java",
          'java_home'        => "/usr/lib/jvm/java-1.${openjdk}.0-openjdk-${openjdk_architecture}/",
        },
        'jre' => {
          'package'          => "openjdk-${openjdk}-jre-headless",
          'alternative'      => "java-1.${openjdk}.0-openjdk-${openjdk_architecture}",
          'alternative_path' => "/usr/lib/jvm/java-1.${openjdk}.0-openjdk-${openjdk_architecture}/bin/java",
          'java_home'        => "/usr/lib/jvm/java-1.${openjdk}.0-openjdk-${openjdk_architecture}/",
        },
      }
    }
    'OpenBSD': {
      $java = {
        'jdk' => {
          'package'   => 'jdk',
          'java_home' => '/usr/local/jdk/',
        },
        'jre' => {
          'package'   => 'jre',
          'java_home' => '/usr/local/jdk/',
        },
      }
    }
    'FreeBSD': {
      $java = {
        'jdk' => {
          'package'   => 'openjdk',
          'java_home' => '/usr/local/openjdk7/',
        },
        'jre' => {
          'package'   => 'openjdk-jre',
          'java_home' => '/usr/local/openjdk7/',
        },
      }
    }
    'Solaris': {
      $java = {
        'jdk' => {
          'package'   => 'developer/java/jdk-7',
          'java_home' => '/usr/jdk/instances/jdk1.7.0/',
        },
        'jre' => {
          'package'   => 'runtime/java/jre-7',
          'java_home' => '/usr/jdk/instances/jdk1.7.0/',
        },
      }
    }
    'Suse': {
      case $facts['os']['name'] {
        'SLES': {
          if (versioncmp($facts['os']['release']['full'], '12.1') >= 0) {
            $jdk_package = 'java-1_8_0-openjdk-devel'
            $jre_package = 'java-1_8_0-openjdk'
            $java_home   = '/usr/lib64/jvm/java-1.8.0-openjdk-1.8.0/'
          } elsif (versioncmp($facts['os']['release']['full'], '12') >= 0) {
            $jdk_package = 'java-1_7_0-openjdk-devel'
            $jre_package = 'java-1_7_0-openjdk'
            $java_home   = '/usr/lib64/jvm/java-1.7.0-openjdk-1.7.0/'
          } elsif (versioncmp($facts['os']['release']['full'], '11.4') >= 0) {
            $jdk_package = 'java-1_7_1-ibm-devel'
            $jre_package = 'java-1_7_1-ibm'
            $java_home   = '/usr/lib64/jvm/java-1.7.1-ibm-1.7.1/'
          } else {
            $jdk_package = 'java-1_6_0-ibm-devel'
            $jre_package = 'java-1_6_0-ibm'
            $java_home   = '/usr/lib64/jvm/java-1.6.0-ibm-1.6.0/'
          }
        }
        'OpenSuSE': {
          $jdk_package = 'java-1_7_0-openjdk-devel'
          $jre_package = 'java-1_7_0-openjdk'
          $java_home   = '/usr/lib64/jvm/java-1.7.0-openjdk-1.7.0/'
        }
        default: {
          $jdk_package = 'java-1_6_0-ibm-devel'
          $jre_package = 'java-1_6_0-ibm'
          $java_home   = '/usr/lib64/jvm/java-1.6.0-ibd-1.6.0/'
        }
      }
      $java = {
        'jdk' => {
          'package'   => $jdk_package,
          'java_home' => $java_home,
        },
        'jre' => {
          'package'   => $jre_package,
          'java_home' => $java_home,
        },
      }
    }
    'Archlinux': {
      $jdk_package = 'jdk8-openjdk'
      $jre_package = 'jre8-openjdk'
      $java_home   = '/usr/lib/jvm/java-8-openjdk/jre/'
      $java = {
        'jdk' => {
          'package'   => $jdk_package,
          'java_home' => $java_home,
        },
        'jre' => {
          'package'   => $jre_package,
          'java_home' => $java_home,
        },
      }
    }
    default: { fail("unsupported platform ${facts['os']['family']}") }
  }
}
