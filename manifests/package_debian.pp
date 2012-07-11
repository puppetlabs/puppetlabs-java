# Class: java::package_debian
#
#   Implementation class of the Java package
#   for debian based systems.
#
#   This class is not meant to be used by the end user
#   of the module.  It is an implementation class
#   of the composite Class[java]
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
class java::package_debian(
  $version,
  $distribution
) {

  package { 'java':
    ensure => $version,
    name   => $distribution,
  }
}
