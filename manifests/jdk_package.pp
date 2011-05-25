# Class: java:jdk_package
#
#   This class installs the Java JDK package
#   produced from ./jdk-6u25-linux-x64-rpm.bin -x
#
#   This is the "Official" RPM distributed by Oracle
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
class java::jdk_package (
  $version
) {

  validate_re($version, '^[._0-9a-zA-Z:-]+$')

  $version_real = $version

  package { 'jdk':
    ensure => $version_real,
    alias  => 'java',
  }

}
