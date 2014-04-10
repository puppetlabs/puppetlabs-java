class java::oracle(
	$distribution,
	$version,
	$accept_license=true,
	$use_java_url=undef
	) {
	include java::params

	if ! $accept_license {
		fail("You must set the $accept_license parameter to true to use Oracle java")
	}

	if ! defined(Package[curl]) { package { "curl":	ensure => installed, }}
	$java_type = regsubst($distribution, "^oracle-(jdk|jre)$", '\1')

	$java_url = $use_java_url ? {
		undef => $java::params::java[$distribution]['url'],
		default => $use_java_url
	}
	$java_checksum = $java::params::java[$distribution]['checksum']

	$tmp_dir = "/var/cache/puppet"
	if ! defined(File[$tmp_dir]) { file{$tmp_dir: ensure => directory} }

	$filename = regsubst($java_url, '^.*/([^/]+)$', '\1')
	$tmp_file = "$tmp_dir/$filename"
	$java_dir = $java::params::java_dir
	$java_patch_version = inline_template('<%= "%02d" % @filename.scan(/\d+/)[1] %>')
	$java_major_version = inline_template('<%= @filename.scan(/\d/).first %>')
	$java_dirname = "jdk1.${java_major_version}.0_${java_patch_version}"
	$java_link_dirname = "${java_dir}/${java_type}-1.${java_major_version}.0"
	$java_real_home = "${java_dir}/${java_dirname}"
	$oracle_cookies = "gpw_e24=http://edelivery.oracle.com; oraclelicense=accept-securebackup-cookie; oraclelicense${java_type}-${java_patch_version}-oth-JPR=accept-securebackup-cookie"

	file{$java_dir: ensure => directory, mode => 644 }

	if $java_url =~ /puppet:\/\// {
		file{$tmp_file:
			source => $java_url,
			before => Exec["extract $tmp_file"]
		}
	} else {
		exec{"download java from oracle":
			require => Package[curl],
			provider => shell,
			command => "curl -L -s -b '$oracle_cookies' -o $tmp_file $java_url",
			unless => "echo '$java_checksum  $tmp_file' | md5sum -c -w -",
			before => Exec["extract $tmp_file"]
		}
	}
	exec{"extract $tmp_file":
		command => "/bin/tar -xzf $tmp_file -C $java_dir",
		creates => "${java_real_home}/bin/java",
		require => File[$java_dir]
	}
	->
	file{$java_link_dirname:
		ensure => link,
		target => $java_dirname
	}

	define java_alternative ($java_bin=$title, $java_base, $priority) {
		$bin_path = "/usr/bin/${java_bin}"
		$alt_path = "${java_base}/bin/${java_bin}"
		exec{"/usr/sbin/update-alternatives --install ${bin_path} ${java_bin} ${alt_path} $priority":
			unless => "/usr/sbin/update-alternatives --display ${java_bin} | grep -q ${alt_path}"
		}
	}

	java_alternative{$java::params::bins:
		java_base => $java_link_dirname,
		priority => 10
	}
}
