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
  $version
) {

  # JJM FIXME Validation!
  $version_real = $version

  package { 'jre':
    ensure => $version_real,
    alias  => 'java',
  }

}
