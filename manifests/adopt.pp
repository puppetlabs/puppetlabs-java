# Defined Type java::adopt
#
# Description
# Installs OpenJDK Java built with AdoptOpenJDK with the Hotspot JVM.
#
# Install one or more versions of AdoptOpenJDK Java.
#
# Parameters
# [*version*]
# Version of Java to install, e.g. '7' or '8'. Default values for major and minor
# versions will be used.
#
# [*version_major*]
# Major version which should be installed, e.g. '8u101'. Must be used together with
# version_minor.
#
# [*version_minor*]
# Minor version which should be installed, e.g. 'b12'. Must be used together with
# version_major.
#
# [*java_edition*]
# Type of Java Edition to install, jdk or jre.
#
# [*ensure*]
# Install or remove the package.
#
# [*proxy_server*]
# Specify a proxy server, with port number if needed. ie: https://example.com:8080. (passed to archive)
#
# [*proxy_type*]
# Proxy server type (none|http|https|ftp). (passed to archive)
#
# Variables
# [*release_major*]
# Major version release number for java_se. Used to construct download URL.
#
# [*release_minor*]
# Minor version release number for java_se. Used to construct download URL.
#
# [*install_path*]
# Base install path for specified version of java_se. Used to determine if java_se
# has already been installed.
#
# [*package_type*]
# Type of installation package for specified version of java_se. java_se 6 comes
# in a few installation package flavors and we need to account for them.
# Optional forced package types: rpm, rpmbin, tar.gz
#
# [*os*]
# Oracle java_se OS type.
#
# [*destination*]
# Destination directory to save java_se installer to.  Usually /tmp on Linux and
# C:\TEMP on Windows.
#
# [*creates_path*]
# Fully qualified path to java_se after it is installed. Used to determine if
# java_se is already installed.
#
# [*arch*]
# Oracle java_se architecture type.
#
# [*package_name*]
# Name of the java_se installation package to download from Oracle's website.
#
# [*install_command*]
# Installation command used to install Oracle java_se. Installation commands
# differ by package_type. 'bin' types are installed via shell command. 'rpmbin'
# types have the rpms extracted and then forcibly installed. 'rpm' types are
# forcibly installed.
#
# [*basedir*]
# Directory under which the installation will occur. If not set, defaults to
# /usr/lib/jvm for Debian and /usr/java for RedHat.
#
# [*manage_basedir*]
# Whether to manage the basedir directory.  Defaults to false.
# Note: /usr/lib/jvm is managed for Debian by default, separate from this parameter.
#
define java::adopt (
  $ensure         = 'present',
  $version        = '8',
  $version_major  = undef,
  $version_minor  = undef,
  $java        = 'jdk',
  $proxy_server   = undef,
  $proxy_type     = undef,
  $basedir        = undef,
  $manage_basedir = false,
  $package_type   = undef,
) {

  # archive module is used to download the java package
  include ::archive

  # validate java Standard Edition to download
  if $java !~ /(jre|jdk)/ {
    fail('java must be either jre or jdk.')
  }

  # determine AdoptOpenJDK Java major and minor version, and installation path
  if $version_major and $version_minor {

    $label         = $version_major
    $release_major = $version_major
    $release_minor = $version_minor

    $install_path = "${java}${release_major}${release_minor}"

  } else {
    # use default versions if no specific major and minor version parameters are provided
    $label = $version
    case $version {
      '8' : {
        $release_major = '8u202'
        $release_minor = 'b08'
        $install_path = "${java}1.8.0_202"
      }
      '9' : {
        $release_major = '9.0.4'
        $release_minor = '_11'
        $install_path = "${java}9.0.4_11"
      }
      '10' : {
        $release_major = '10.0.2'
        $release_minor = '+13'
        $install_path = "${java}10.0.2_13"
      }
      '11' : {
        $release_major = '11.0.2'
        $release_minor = '_9'
        $install_path = "${java}11.0.2_9"
      }
      default : {
        $release_major = '8u202'
        $release_minor = 'b08'
        $install_path = "${java}1.8.0_192"
      }
    }
  }

  # determine package type (exe/tar/rpm), destination directory based on OS
  case $facts['kernel'] {
    'Linux' : {
      case $facts['os']['family'] {
        'RedHat', 'Amazon' : {
          if $package_type {
            $_package_type = $package_type
          } else {
            $_package_type = 'tar.gz'
          }
          if $basedir {
            $_basedir = $basedir
          } else {
            $_basedir = '/usr/java'
          }
        }
        'Debian' : {
          if $package_type {
            $_package_type = $package_type
          } else {
            $_package_type = 'tar.gz'
          }
          if $basedir {
            $_basedir = $basedir
          } else {
            $_basedir = '/usr/lib/jvm'
          }
        }
        default : {
          fail ("unsupported platform ${$facts['os']['name']}") }
      }

      $creates_path = "${_basedir}/${install_path}"
      $os = 'linux'
      $destination_dir = '/tmp/'
    }
    default : {
      fail ( "unsupported platform ${$facts['kernel']}" ) }
  }

  # set java architecture nomenclature
  $os_architecture = $facts['os']['architecture'] ? {
    undef => $facts['architecture'],
    default => $facts['os']['architecture']
  }

  case $os_architecture {
    'i386' : { $arch = 'x86-32' }
    'x86_64' : { $arch = 'x64' }
    'amd64' : { $arch = 'x64' }
    default : {
      fail ("unsupported platform ${$os_architecture}")
    }
  }

  # following are based on this example:
  # https://github.com/AdoptOpenJDK/openjdk8-binaries/releases/download/jdk8u202-b08/OpenJDK8U-jdk_x64_linux_hotspot_8u202b08.tar.gz
  #
  # or
  #
  # https://github.com/AdoptOpenJDK/openjdk9-binaries/releases/download/jdk-9.0.4%2B11/OpenJDK9U-jdk_x64_linux_hotspot_9.0.4_11.tar.gz
  # https://github.com/AdoptOpenJDK/openjdk11-binaries/releases/download/jdk-11.0.2%2B9/OpenJDK11U-jdk_x64_linux_hotspot_11.0.2_9.tar.gz
  #
  # package name to download from github
  case $_package_type {
    'tar.gz' : {
      $package_name = "OpenJDK${version}U-${java}_${arch}_${os}_hotspot_${release_major}${release_minor}.tar.gz"
    }
    default : {
      $package_name = "OpenJDK${version}U-${java}_${arch}_${os}_hotspot_${release_major}${release_minor}.tar.gz"
    }
  }

  if ( $version == '8' ) {
    $spacer = '-'
    $download_folder_prefix = 'jdk'
    $release_minor_url = $release_minor
  } else {
    $spacer = '%2B'
    $download_folder_prefix = 'jdk-'
    $release_minor_url = $release_minor[1,-1]
  }
  $source = "https://github.com/AdoptOpenJDK/openjdk${version}-binaries/releases/download/${download_folder_prefix}${release_major}${spacer}${release_minor_url}/${package_name}"

  # full path to the installer
  $destination = "${destination_dir}${package_name}"
  notice ("Destination is ${destination}")

  case $_package_type {
    'tar.gz' : {
      $install_command = "tar -zxf ${destination} -C ${_basedir}"
    }
    default : {
      $install_command = "tar -zxf ${destination} -C ${_basedir}"
    }
  }

  case $ensure {
    'present' : {
      archive { $destination :
        ensure       => present,
        source       => $source,
        extract_path => '/tmp',
        cleanup      => false,
        creates      => $creates_path,
        proxy_server => $proxy_server,
        proxy_type   => $proxy_type,
      }
      case $facts['kernel'] {
        'Linux' : {
          case $facts['os']['family'] {
            'Debian' : {
              ensure_resource('file', $_basedir, {
                ensure => directory,
              })
              $install_requires = [Archive[$destination], File[$_basedir]]
            }
            default : {
              $install_requires = [Archive[$destination]]
            }
          }

          if $manage_basedir {
            ensure_resource('file', $_basedir, {'ensure' => 'directory', 'before' => Exec["Install AdoptOpenJDK java ${java} ${version} ${release_major} ${release_minor}"]})
          }

          exec { "Install AdoptOpenJDK java ${java} ${version} ${release_major} ${release_minor}" :
            path    => '/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin',
            command => $install_command,
            creates => $creates_path,
            require => $install_requires
          }

        }
        default : {
          fail ("unsupported platform ${$facts['kernel']}")
        }
      }
    }
    default : {
      notice ("Action ${ensure} not supported.")
    }
  }

}
