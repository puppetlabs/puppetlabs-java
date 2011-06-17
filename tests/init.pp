node default {

  notify { "alpha": } ->
  class { 'java':
    distribution => 'jdk',
    version      => 'latest',
  } ->
  notify { "omega": }

}
