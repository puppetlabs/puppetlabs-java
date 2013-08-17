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

  $bins = ["appletviewer", "apt", "ControlPanel", "extcheck", "HtmlConverter", "idlj", "jar", "jarsigner",
    "java", "javac", "javadoc", "javah", "javap", "javaws", "jconsole", "jcontrol", "jdb", "jhat",
    "jinfo", "jmap", "jps", "jrunscript", "jsadebugd", "jstack", "jstat", "jstatd", "jvisualvm",
    "keytool", "native2ascii", "orbd", "pack200", "policytool", "rmic", "rmid", "rmiregistry",
    "schemagen", "serialver", "servertool", "tnameserv", "unpack200", "wsgen", "wsimport", "xjc" ]
  case $architecture { 
    'x86_64' : { $oracle_urls = {
      'oracle-jdk' => { 'url' => "http://download.oracle.com/otn-pub/java/jdk/7u25-b15/jdk-7u25-linux-x64.tar.gz",
                        'checksum' => "83ba05e260813f7a9140b76e3d37ea33"
                      },
      'oracle-jre' => { 'url' => "http://download.oracle.com/otn-pub/java/jdk/7u25-b15/server-jre-7u25-linux-x64.tar.gz",
                        'checksum' => "7164bd8619d731a2e8c01d0c60110f80"
                      }
      }
    }
    'i386', 'i586' : { $oracle_urls = {
      'oracle-jdk' => { 'url' => "http://download.oracle.com/otn-pub/java/jdk/7u25-b15/jdk-7u25-linux-i586.tar.gz",
                        'checksum' => "23176d0ebf9dedd21e3150b4bb0ee776"
                      }
      }
    }
  }
  case $::osfamily {
    default: { fail("unsupported platform ${::osfamily}") }
    'RedHat': {
      case $::operatingsystem {
        default: { fail("unsupported os ${::operatingsystem}") }
        'RedHat', 'CentOS', 'OracleLinux', 'Scientific': {
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
          $jdk_package = 'java-1.7.0-openjdk-devel'
          $jre_package = 'java-1.7.0-openjdk'
        }
        'Amazon': {
          $jdk_package = 'java-1.7.0-openjdk-devel'
          $jre_package = 'java-1.7.0-openjdk'
        }
      }
      $java = {
        'jdk' => { 
          'package' => $jdk_package, 
          'alternative_path' => '/usr/lib/jvm/jdk-1.7.0-openjdk.${architecture}/bin/java'
        },
        'jre' => {
          'package' => $jre_package,
          'alternative_path' => '/usr/lib/jvm/jre-1.7.0-openjdk.${architecture}/bin/java'
        },
        "oracle-jdk" => merge({
          'alternative_path' => "/usr/lib/jvm/jdk-1.7.0/bin/java",
        }, $oracle_urls["oracle-jdk"]),
        "oracle-jre" => merge({
          'alternative_path' => "/usr/lib/jvm/jre-1.7.0/bin/java"
        }, $oracle_urls["oracle-jre"])
      }
      $java_dir = "/usr/lib/jvm"
      $java_home = "${java_dir}/jre"
    }
    'Debian': {
      $java_dir = "/usr/lib/jvm"
      $java_home = "${java_dir}/default-java"
      case $::lsbdistcodename {
        default: { fail("unsupported release ${::lsbdistcodename}") }
        'lenny', 'squeeze', 'lucid', 'natty': {
          $java  = {
            'jdk' => {
              'package'          => 'openjdk-6-jdk',
              'alternative'      => 'java-6-openjdk',
              'alternative_path' => '/usr/lib/jvm/java-6-openjdk/jre/bin/java',
              'java_home'        => '/usr/lib/jvm/java-6-openjdk/jre/',
            },
            'jre' => {
              'package'          => 'openjdk-6-jre-headless',
              'alternative'      => 'java-6-openjdk',
              'alternative_path' => '/usr/lib/jvm/java-6-openjdk/jre/bin/java',
              'java_home'        => '/usr/lib/jvm/java-6-openjdk/jre/',
            },
            'sun-jre' => {
              'package'          => 'sun-java6-jre',
              'alternative'      => 'java-6-sun',
              'alternative_path' => '/usr/lib/jvm/java-6-sun/jre/bin/java',
              'java_home'        => '/usr/lib/jvm/java-6-sun/jre/',
            },
            'sun-jdk' => {
              'package'          => 'sun-java6-jdk',
              'alternative'      => 'java-6-sun',
              'alternative_path' => '/usr/lib/jvm/java-6-sun/jre/bin/java',
              'java_home'        => '/usr/lib/jvm/java-6-sun/jre/',
            },
          }
        }
        'wheezy', 'precise','quantal','raring','saucy': {
          $java =  {
            'jdk' => {
              'package'          => 'openjdk-7-jdk',
              'alternative'      => "java-1.7.0-openjdk-${::architecture}",
              'alternative_path' => "/usr/lib/jvm/java-1.7.0-openjdk-${::architecture}/bin/java",
              'java_home'        => "/usr/lib/jvm/java-1.7.0-openjdk-${::architecture}/",
            },
            'jre' => {
              'package'          => 'openjdk-7-jre-headless',
              'alternative'      => "java-1.7.0-openjdk-${::architecture}",
              'alternative_path' => "/usr/lib/jvm/java-1.7.0-openjdk-${::architecture}/bin/java",
              'java_home'        => "/usr/lib/jvm/java-1.7.0-openjdk-${::architecture}/",
            },
            'oracle-jre' => {
              'package'          => 'oracle-j2re1.7',
              'alternative'      => 'j2re1.7-oracle',
              'alternative_path' => '/usr/lib/jvm/j2re1.7-oracle/bin/java',
              'java_home'        => '/usr/lib/jvm/j2re1.7-oracle/',
            },
            'oracle-jdk' => {
              'package'          => 'oracle-j2sdk1.7',
              'alternative'      => 'j2sdk1.7-oracle',
              'alternative_path' => '/usr/lib/jvm/j2sdk1.7-oracle/jre/bin/java',
              'java_home'        => '/usr/lib/jvm/j2sdk1.7-oracle/jre/',
            },
          }
        }
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
        default: {
          $jdk_package = 'java-1_6_0-ibm-devel'
          $jre_package = 'java-1_6_0-ibm'
        }

        'OpenSuSE': {
          $jdk_package = 'java-1_7_0-openjdk-devel'
          $jre_package = 'java-1_7_0-openjdk'
        }
      }
      $java = {
        'jdk' => { 'package' => $jdk_package, },
        'jre' => { 'package' => $jre_package, },
      }
      $java_dir = "/usr/java"
    }
  }
}
