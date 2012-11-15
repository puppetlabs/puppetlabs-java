# Class: java::package_solaris
#
#   Implementation class of the Java package
#   for Solaris based systems.
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
class java::package_solaris(
  $version,
  $distribution
) {

  package { 'java':
    ensure => $version,
    name   => $distribution,
  }
}
