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

  apt::source { "ubuntu-lucid-partner":
    location => "http://archive.canonical.com/ubuntu/",
    release  => $lsbdistcodename,
    repos    => "partner",
  }

  file { "/var/local/sun-java6.preseed":
    content => template("${module_name}/sun-java6.preseed"),
  }

  package { 'java':
    ensure => $version,
    name   => $distribution,
    responsefile => "/var/local/sun-java6.preseed",
    require => File["/var/local/sun-java6.preseed"],
  }

  exec { "sun-java-alternative":
    path    => "/bin:/usr/bin:/usr/sbin",
    command => "update-java-alternatives -s java-6-sun",
    unless  => "java -version 2>&1 | grep \"Java(TM) SE Runtime Environment\"",
    require => Package["java"],
    returns => [0, 2],
  }

}
