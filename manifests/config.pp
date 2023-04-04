# @api private
class java::config ( ) {
  case $facts['os']['family'] {
    'Debian': {
      if $java::use_java_alternative != undef and $java::use_java_alternative_path != undef {
        $command_debian = ['update-java-alternatives', '--set', $java::use_java_alternative, $java::jre_flag]
        $unless_debian = [['test', '/etc/alternatives/java', '-ef', $java::use_java_alternative_path]]

        exec { 'update-java-alternatives':
          path    => '/usr/bin:/usr/sbin:/bin:/sbin',
          command => $command_debian,
          unless  => $unless_debian,
        }
      }
      if $java::use_java_home != undef {
        file_line { 'java-home-environment':
          path  => '/etc/environment',
          line  => "JAVA_HOME=${$java::use_java_home}",
          match => 'JAVA_HOME=',
        }
      }
    }
    'RedHat': {
      if $java::use_java_alternative != undef and $java::use_java_alternative_path != undef {
        # The standard packages install alternatives, custom packages do not
        # For the stanard packages java::params needs these added.
        if $java::use_java_package_name != $java::default_package_name {
          $command_redhat = ['alternatives', '--install', '/usr/bin/java', 'java', $java::use_java_alternative_path, '20000']
          $unless_redhat = "alternatives --display java | grep -q ${shell_escape($java::use_java_alternative_path)}"

          exec { 'create-java-alternatives':
            path    => '/usr/bin:/usr/sbin:/bin:/sbin',
            command => $command_redhat,
            unless  => $unless_redhat,
            before  => Exec['update-java-alternatives'],
          }
        }
        $command_default = ['alternatives', '--set', 'java', $java::use_java_alternative_path]
        $unless_default = [['test', '/etc/alternatives/java', '-ef', $java::use_java_alternative_path]]

        exec { 'update-java-alternatives':
          path    => '/usr/bin:/usr/sbin',
          command => $command_default,
          unless  => $unless_default,
        }
      }
      if $java::use_java_home != undef {
        file_line { 'java-home-environment':
          path  => '/etc/environment',
          line  => "JAVA_HOME=${$java::use_java_home}",
          match => 'JAVA_HOME=',
        }
      }
    }
    'Suse': {
      if $java::use_java_home != undef {
        file_line { 'java-home-environment':
          path  => '/etc/environment',
          line  => "JAVA_HOME=${$java::use_java_home}",
          match => 'JAVA_HOME=',
        }
      }
    }
    'FreeBSD': {
      if $java::use_java_home != undef {
        file_line { 'java-home-environment-profile':
          path  => '/etc/profile',
          line  => "JAVA_HOME=${$java::use_java_home}; export JAVA_HOME",
          match => 'JAVA_HOME=',
        }
        file_line { 'java-home-environment-cshrc':
          path  => '/etc/csh.login',
          line  => "setenv JAVA_HOME ${$java::use_java_home}",
          match => 'setenv JAVA_HOME',
        }
      }
    }
    'Solaris': {
      if $java::use_java_home != undef {
        file_line { 'java-home-environment':
          path  => '/etc/profile',
          line  => "JAVA_HOME=${$java::use_java_home}",
          match => 'JAVA_HOME=',
        }
      }
    }
    'Archlinux': {
      if $java::use_java_home != undef {
        file_line { 'java-home-environment':
          path  => '/etc/profile',
          line  => "JAVA_HOME=${$java::use_java_home}",
          match => 'JAVA_HOME=',
        }
      }
    }
    default: {
      # Do nothing.
    }
  }
}
