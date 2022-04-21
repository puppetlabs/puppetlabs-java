# Defined Type java::adoptium
#
# @summary
#   Install one or more versions of Adoptium Temurin OpenJDK (former AdoptOpenJDK).
#
# @param ensure
#   Install or remove the package.
#
# @param version_major
#   Major version which should be installed, e.g. '16' or '17'
#
# @param version_minor
#   Minor version which should be installed, e.g. '0'
#
# @param version_patch
#   Minor version which should be installed, e.g. '2'
#
# @param version_build
#   Build version which should be installed, e.g. '07'
#
# @param proxy_server
#   Specify a proxy server, with port number if needed. ie: https://example.com:8080. (passed to archive)
#
# @param proxy_type
#   Proxy server type (none|http|https|ftp). (passed to archive)
#
# @param url
#   Full URL
#
# @param basedir
#   Directory under which the installation will occur. If not set, defaults to
#   /usr/lib/jvm for Debian and /usr/java for RedHat.
#
# @param manage_basedir
#   Whether to manage the basedir directory.  Defaults to false.
#   Note: /usr/lib/jvm is managed for Debian by default, separate from this parameter.
#
# @param manage_symlink
#   Whether to manage a symlink that points to the installation directory.  Defaults to false.
#
# @param symlink_name
#   The name for the optional symlink in the installation directory.
#
define java::adoptium (
  $ensure         = 'present',
  $version_major  = undef,
  $version_minor  = undef,
  $version_patch  = undef,
  $version_build  = undef,
  $proxy_server   = undef,
  $proxy_type     = undef,
  $url            = undef,
  $basedir        = undef,
  $manage_basedir = true,
  $manage_symlink = false,
  $symlink_name   = undef,
) {
  # archive module is used to download the java package
  include ::archive

  $install_path = "jdk-${version_major}.${version_minor}.${version_patch}+${version_build}"

  # determine package type (exe/tar/rpm), destination directory based on OS
  case $facts['kernel'] {
    'Linux' : {
      case $facts['os']['family'] {
        'RedHat', 'Amazon' : {
          if $basedir {
            $_basedir = $basedir
          } else {
            $_basedir = '/usr/java'
          }
        }
        'Debian' : {
          if $basedir {
            $_basedir = $basedir
          } else {
            $_basedir = '/usr/lib/jvm'
          }
        }
        default : {
          fail ("unsupported platform ${$facts['os']['name']}")
        }
      }

      $creates_path = "${_basedir}/${install_path}"
      $os = 'linux_hotspot'
    }
    default : {
      fail ( "unsupported platform ${$facts['kernel']}" )
    }
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

  # package name and path for download from github
  #
  # following are build based on this real life example full URLs:
  #
  # https://github.com/adoptium/temurin17-binaries/releases/download/jdk-17.0.1%2B12/OpenJDK17U-jdk_x64_linux_hotspot_17.0.1_12.tar.gz
  # https://github.com/adoptium/temurin16-binaries/releases/download/jdk-16.0.2%2B7/OpenJDK16U-jdk_x64_alpine-linux_hotspot_16.0.2_7.tar.gz

  $package_name = "OpenJDK${version_major}U-jdk_${arch}_${os}_${version_major}.${version_minor}.${version_patch}_${version_build}.tar.gz"

  # if complete URL is provided, use this value for source in archive resource
  if $url {
    $source = $url
  }
  else {
    $source = "https://github.com/adoptium/temurin${version_major}-binaries/releases/download/jdk-${version_major}.${version_minor}.${version_patch}%2B${version_build}/${package_name}"
    notice ("Default source url : ${source}")
  }

  # full path to the installer
  $destination = "/tmp/${package_name}"
  notice ("Destination is ${destination}")

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
                }
              )
              $install_requires = [Archive[$destination], File[$_basedir]]
            }
            default : {
              $install_requires = [Archive[$destination]]
            }
          }

          if $manage_basedir {
            if (!defined(File[$_basedir])) {
              file { $_basedir:
                ensure => 'directory',
                before => Exec["Install Adoptium Temurin java ${version_major} ${version_minor} ${version_patch} ${version_build}"],
              }
            }
          }

          exec { "Install Adoptium Temurin java ${version_major} ${version_minor} ${version_patch} ${version_build}" :
            path    => '/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin',
            command => "tar -zxf ${destination} -C ${_basedir}",
            creates => $creates_path,
            require => $install_requires,
          }

          if ($manage_symlink and $symlink_name) {
            file { "${_basedir}/${symlink_name}":
              ensure  => link,
              target  => $creates_path,
              require => Exec["Install Adoptium Temurin java ${version_major} ${version_minor} ${version_patch} ${version_build}"],
            }
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
