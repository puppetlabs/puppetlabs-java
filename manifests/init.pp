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
#    If you specify a particular package, you will also want to
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
  $java_alternative_path = undef
) {
  include java::params

  validate_re($version, 'present|installed|latest|^[._0-9a-zA-Z:-]+$')

  if has_key($java::params::java, $distribution) {
    $default_package_name     = $java::params::java[$distribution]['package']
    $default_alternative      = has_key($java::params::java[$distribution], 'alternative') ? {
      true    => $java::params::java[$distribution]['alternative'],
      default => undef,
    }
    $default_alternative_path = has_key($java::params::java[$distribution], 'alternative_path') ? {
      true => $java::params::java[$distribution]['alternative_path'],
      default => undef,
    }
  } else {
    fail("Java distribution ${distribution} is not supported.")
  }

  $use_java_package_name = $package ? {
    default => $package,
    undef   => $default_package_name,
  }

  $use_java_alternative = $java_alternative ? {
    default => $java_alternative,
    undef   => $default_alternative,
  }

  $use_java_alternative_path = $java_alternative_path ? {
    default => $java_alternative_path,
    undef   => $default_alternative_path,
  }

  anchor { 'java::begin:': }
  ->
  package { 'java':
    ensure => $version,
    name   => $use_java_package_name,
  }
  ->
  class { 'java::config': }
  -> anchor { 'java::end': }

}
