# Define: java::install::windows
#
# Parameters:
#   [*source*]
#     The url, file share or local file to install from, the file must be in the original file name as we parse
#     for architecture as well as major and minor version that we are installing to determine the install name
#
#   [*ensure*]
#     Whether the package should be present or absent
#
#   [*install_path*]
#     Optional path where to install jdk to
#
#   [*version*]
#
#
#

define java::install::windows ($source, $ensure = 'present', $install_path = undef, $version = undef) {

  validate_re($source, ['^http(s)://','^[a-zA-z]:\\.*','^\\\\\w+'])

  if $version {
    validate_re($version,'^\d+u\d+$', "Version must be in the pattern of \\d+u\\d+ , you provided ${version}")
    $_ver_split = split_major_minor($version)
  } else{
    $_ver_split = split_major_minor($source)
  }

  if $_ver_split and count($_ver_split) == 3 {
    $_major = $_ver_split[1]
    $_minor = $_ver_split[2]
  }

  $_install_name_arch = $source ? {
    /x86_64|x64/ => ' (64-bit)',
    default      => '',
  }

  $_install_name = "Java SE Development Kit ${_major} Update ${_minor}${_install_name_arch}"

  if $install_path {
    $_install_opts = ['/s',{ 'INSTALLDIR' => $install_path }]
  }
  else {
    $_install_opts = ['/s']
  }

  package{ $_install_name:
    ensure          => $ensure,
    source          => $source,
    provider        => windows,
    install_options => $_install_opts,
  }
}