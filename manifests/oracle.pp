# Defined Type java::oracle
#
# Description
# Installs Oracle Java. By using this module you agree to the Oracle licensing
# agreement.
#
# Install one or more versions of Oracle Java.
#
# uses the following to download the package and automatically accept
# the licensing terms.
# wget --no-cookies --no-check-certificate --header \
# "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" \
# "http://download.oracle.com/otn-pub/java/jdk/8u25-b17/jre-8u25-linux-x64.tar.gz"
#
# Parameters
# [*version*]
# Version of Java to install
#
# [*javaSE*]
# Type of Java Standard Edition to install, jdk or jre.
#
# [*ensure*]
# Install or remove the package.
#
# [*baseUrl*]
# Official Oracle URL to download binaries from.
#
# Variables
# [*releaseMajor*]
# Major version release number for JavaSE. Used to construct download URL.
#
# [*releaseMinor*]
# Minor version release number for JavaSE. Used to construct download URL.
#
# [*installPath*]
# Base install path for specified version of JavaSE. Used to determine if JavaSE
# has already been installed.
#
# [*packageType*]
# Type of installation package for specified version of JavaSE. JavaSE 6 comes
# in a few installation package flavors and we need to account for them.
#
# [*os*]
# Oracle JavaSE OS type.
#
# [*destinationDir*]
# Destination directory to save JavaSE installer to.  Usually /tmp on Linux and
# C:\TEMP on Windows.
#
# [*createsPath*]
# Fully qualified path to JavaSE after it is installed. Used to determine if
# JavaSE is already installed.
#
# [*arch*]
# Oracle JavaSE architecture type.
#
# [*packageName*]
# Name of the JavaSE installation package to download from Oracle's website.
#
# [*installCommand*]
# Installation command used to install Oracle JavaSE. Installation commands
# differ by packageType. 'bin' types are installed via shell command. 'rpmbin'
# types have the rpms extracted and then foricibly installed. 'rpm' types are
# foricibly installed.
#
# [*url*]
# Full URL, including baseUrl, releaseMajor, releaseMinor and packageName, to
# download the Oracle JavaSE installer.
#
# ### Author
# mike@marseglia.org
#
define java::oracle (
  $ensure       = 'present',
  $version      = '7',
  $javaSE       = 'jdk',
  $baseUrl      = 'http://download.oracle.com/otn-pub/java/jdk/',
) {

  include ::archive

  ensure_resource('class', 'stdlib')

  # validate java Standard Edition to download
  if $javaSE !~ /(jre|jdk)/ {
    fail('Java SE must be either jre or jdk.')
  }

  # determine oracle Java major and minor version
  case $version {
    '6' : {
      $releaseMajor = '6u45'
      $releaseMinor = 'b06'
      $installPath = "${javaSE}1.6.0_45"
    }
    '7' : {
      $releaseMajor = '7u80'
      $releaseMinor = 'b15'
      $installPath = "${javaSE}1.7.0_80"
    }
    '8' : {
      $releaseMajor = '8u51'
      $releaseMinor = 'b16'
      $installPath = "${javaSE}1.8.0_51"
    }
    default : {
      $releaseMajor = '8u51'
      $releaseMinor = 'b16'
      $installPath = "${javaSE}1.8.0_51"
    }
  }

  # determine package type (exe/tar/rpm), destination directory based on OS
  case downcase($::kernel) {
    'linux' : {
      case downcase($::osfamily) {
        'redhat', 'centos' : {
          if $version == '6' {
            $packageType = 'rpmbin'
          } else {
            $packageType = 'rpm'
          }
        }
        default : {
          fail ("OS ${::osfamily} unsupported platform.") }
      }

      $os = 'linux'
      $destinationDir = '/tmp/'
      $createsPath = "/usr/java/${installPath}"
    }
    default : {
      fail ( "Kernel ${::kernel} unsupported platform." ) }
  }

  # determine java architecture type
  case $::architecture {
    'i386' : { $arch = 'i586' }
    'x86_64' : { $arch = 'x64' }
    default : {
      fail ("Architecture ${::architecture} unsupported platform.")
    }
  }

  # following are based on this example:
  # http://download.oracle.com/otn/java/jdk/7u80-b15/jre-7u80-linux-i586.rpm
  #
  # JaveSE 6 distributed in .bin format
  # http://download.oracle.com/otn/java/jdk/6u45-b06/jdk-6u45-linux-i586-rpm.bin
  # http://download.oracle.com/otn/java/jdk/6u45-b06/jdk-6u45-linux-i586.bin
  # package name to download from Oracle's website
  case $packageType {
    'bin' : {
      $packageName = "${javaSE}-${releaseMajor}-${os}-${arch}.bin"
    }
    'rpmbin' : {
      $packageName = "${javaSE}-${releaseMajor}-${os}-${arch}-rpm.bin"
    }
    'rpm' : {
      $packageName = "${javaSE}-${releaseMajor}-${os}-${arch}.rpm"
    }
    default : {
      $packageName = "${javaSE}-${releaseMajor}-${os}-${arch}.rpm"
    }
  }

  # full path to the installer
  $destination = "${destinationDir}${packageName}"
  notice ("Destination is ${destination}")

  case $packageType {
    'bin' : {
      $installCommand = "sh ${destination}"
    }
    'rpmbin' : {
      $installCommand = "sh ${destination} -x; rpm --force -iv sun*.rpm; rpm --force -iv ${javaSE}*.rpm"
    }
    'rpm' : {
      $installCommand = "rpm --force -iv ${destination}"
    }
    default : {
      $installCommand = "rpm -iv ${destination}"
    }
  }

  # full URL to download
  $url = "${baseUrl}${releaseMajor}-${releaseMinor}/${packageName}"

  case $ensure {
    'present' : {
      archive { $destination :
        ensure  => present,
        source  => $url,
        cleanup => false,
        cookie  => 'gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie',
      }->
      case downcase($::kernel) {
        'linux' : {
          exec { "Install Oracle JavaSE ${javaSE} ${version}" :
            path    => '/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin',
            command => $installCommand,
            creates => $createsPath,
          }
        }
        default : {
          fail ("Install for operating system ${::kernel} unsupported platform")
        }
      }
    }
    default : {
      notice ("Action ${ensure} not supported.")
    }
  }

}
