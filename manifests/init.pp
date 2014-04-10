# Class: java
#
# This module manages the Java runtime package
#
# Parameters:
#
#  [*distribution*]
#    The java distribution to install. Can be one of "jdk" or "jre",
#    or other platform-specific options where there are multiple
#    implementations available (eg: OpenJDK vs Oracle JDK).
#
#
#  [*version*]
#    The version of java to install. By default, this module simply ensures
#    that java is present, and does not require a specific version.
#
#  [*package*]
#    The name of the java package. This is configurable in case a non-standard
#    java package is desired.
#
#  [*java_alternative*]
#    The name of the java alternative to use on Debian systems.
#    "update-java-alternatives -l" will show which choices are available.
#    If you specify a particular package, you will almost always also
#    want to specify which java_alternative to choose. If you set
#    this, you also need to set the path below.
#
#  [*java_alternative_path*]
#    The path to the "java" command on Debian systems. Since the
#    alternatives system makes it difficult to verify which
#    alternative is actually enabled, this is required to ensure the
#    correct JVM is enabled.
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
class java(
  $distribution          = 'jdk',
  $version               = 'present',
  $package               = undef,
  $java_alternative      = undef,
  $java_alternative_path = undef,
  $url                   = undef,
) {
  include java::params

  validate_re($version, 'present|installed|latest|^[.+_0-9a-zA-Z:-]+$')

  if has_key($java::params::java, $distribution) {
    $default_package_name     = $java::params::java[$distribution]['package']
    $default_alternative      = $java::params::java[$distribution]['alternative']
    $default_alternative_path = $java::params::java[$distribution]['alternative_path']
    $java_home                = $java::params::java[$distribution]['java_home']
    $default_url              = $java::params::java[$distribution]['url']
  } else {
    fail("Java distribution ${distribution} is not supported.")
  }

  $use_java_package_name = $package ? {
    default => $package,
    undef   => $default_package_name,
  }

  $use_java_url = $url ? {
    default => $url,
    undef   => $default_url
  }
  ## If $java_alternative is set, use that.
  ## Elsif the DEFAULT package is being used, then use $default_alternative.
  ## Else undef
  $use_java_alternative = $java_alternative ? {
    default => $java_alternative,
    undef   => $use_java_package_name ? {
      $default_package_name => $default_alternative,
      default               => undef,
    }
  }

  ## Same logic as $java_alternative above.
  $use_java_alternative_path = $java_alternative_path ? {
    default => $java_alternative_path,
    undef   => $use_java_package_name ? {
      $default_package_name => $default_alternative_path,
      default               => undef,
    }
  }

  anchor { 'java::begin:': }
 
  if $use_java_package_name {
    package { 'java':
      ensure => $version,
      name   => $use_java_package_name,
      require => Anchor['java::begin:'],
      before => Class[java::config]
    }
  } elsif $distribution =~ /^oracle/ and $use_java_url {
    class{java::oracle: 
      version => $version, 
      distribution => $distribution,
      use_java_url => $use_java_url,
      require => Anchor['java::begin:'],
      before => Class[java::config]
    }
  }

  class { 'java::config': }
  -> anchor { 'java::end': }

}
