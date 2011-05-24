# Class: java:jre_package
#
#   class description goes here.
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
class java::jre_package (
  $version='1.6.0_25-fcs'
) {
  # statements
  package { 'jre':
    ensure => $version_real,
    alias  => 'java',
  }
}
