# Class: java
#
# This module manages the Java runtime package
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
# [Remember: No empty lines between comments and class definition]
class java(
  $version='1.6.0_25-fcs'
) {

  $version_real = $version

  class { 'java::jre_package':
    version => $version_real,
    stage   => 'runtime',
  }

}
