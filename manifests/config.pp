# On Debian systems, if alternatives are set, manually assign them.
class java::config ( ) {
  case $::osfamily {
    'Debian': {
      if $java::use_java_alternative != undef and $java::use_java_alternative_path != undef {
        exec { 'update-java-alternatives':
          path    => '/usr/bin:/usr/sbin:/bin:/sbin',
          command => "update-java-alternatives --set ${java::use_java_alternative} --jre",
          unless  => "test /etc/alternatives/java -ef '${java::use_java_alternative_path}'",
        }
      }
    }
    #On Redhat, verify and set alternatives
    'RedHat': {
      if $java::use_java_alternative_path != undef {
        exec { 'alternatives':
          path    => '/usr/bin:/usr/sbin:/bin:/sbin',
          command => "alternatives --set java ${java::use_java_alternative_path}",
          unless  => "test /etc/alternatives/java -ef '${java::use_java_alternative_path}'",
        }
      }
    }
    default: {
      # Do nothing.
    }
  }
}
