class { 'java::oracle' :
  ensure      => 'present',
  javaVersion => '6',
  javaSE      => 'jdk',
}
