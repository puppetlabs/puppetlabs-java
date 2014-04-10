# On Debian systems, if alternatives are set, manually assign them.
class java::config ( ) {
  case $::osfamily {
    Debian: {
      if $java::use_java_alternative != undef and $java::use_java_alternative_path != undef {
        exec { 'update-java-alternatives':
          path    => '/usr/bin:/usr/sbin:/bin:/sbin',
          command => "update-java-alternatives --set ${java::use_java_alternative} --jre",
          unless  => "test /etc/alternatives/java -ef '${java::use_java_alternative_path}'",
        }
      }
    }
    RedHat: {
      if $operatingsystemmajrelease >= 6 {
        if $java::use_java_alternative_path != undef {
          exec { 'update-java-alternatives':
            path    => '/usr/bin:/usr/sbin:/bin:/sbin',
            command => "update-alternatives --set java ${java::use_java_alternative_path}",
            unless  => "test /etc/alternatives/java -ef '${java::use_java_alternative_path}'",
          }
        }
      } else {
        file{"/usr/bin/java": 
          ensure => link,
          target => "${java::params::java_home}/bin/java"
        }
      }
    }
    default: {
      # Do nothing.
    }
  }
  if $java_home != undef {
    file{'/etc/profile.d/jdk.sh':
      mode => 644,
      content => "export JAVA_HOME=${java::params::java_home}"
    }
  }
}
