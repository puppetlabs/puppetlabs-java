require 'spec_helper_acceptance'

include Unix::File

# RedHat, CentOS, Scientific, Oracle prior to 5.0  : Sun Java JDK/JRE 1.6
# RedHat, CentOS, Scientific, Oracle 5.0 < x < 6.3 : OpenJDK Java JDK/JRE 1.6
# RedHat, CentOS, Scientific, Oracle after 6.3     : OpenJDK Java JDK/JRE 1.7
# Debian Jesse & Ubuntu 14.04                      : OpenJDK Java JDK/JRE 1.7 or Oracle Java JDK/JRE 1.6
# Solaris (what versions?)                         : Java JDK/JRE 1.7
# OpenSuSE                                         : OpenJDK Java JDK/JRE 1.7
# SLES                                             : IBM Java JDK/JRE 1.6

# C14677
# C14678
# C14679
# C14680
# C14681
# C14682
# C14684
# C14687
# C14692
# C14696
# C14697
# C14700 check on solaris 11
# C14701 check on sles 11
# C14703
# C14723 Where is oracle linux 5?
# C14724 Where is oracle linux 5?
# C14771 Where is redhat 7? Centos 7?

java_class_jre = "class { 'java':\n"\
                 "  distribution => 'jre',\n"\
                 '}'

java_class = "class { 'java': }"

_sources = "file_line { 'non-free source':\n"\
          "  path  => '/etc/apt/sources.list',\n"\
          "  match => \"deb http://osmirror.delivery.puppetlabs.net/debian/ ${::lsbdistcodename} main\",\n"\
          "  line  => \"deb http://osmirror.delivery.puppetlabs.net/debian/ ${::lsbdistcodename} main non-free\",\n"\
          '}'

_sun_jre = "class { 'java':\n"\
          "  distribution => 'sun-jre',\n"\
          '}'

_sun_jdk = "class { 'java':\n"\
          "  distribution => 'sun-jdk',\n"\
          '}'

oracle_jre = "class { 'java':\n"\
             "  distribution => 'oracle-jre',\n"\
             '}'

oracle_jdk = "class { 'java':\n"\
             "  distribution => 'oracle-jdk',\n"\
             '}'

incorrect_version = "class { 'java':\n"\
                    " version => '14.5',\n"\
                    '}'

blank_version = "class { 'java':\n"\
                "  version => '',\n"\
                '}'

incorrect_distro = "class { 'java':\n"\
                   "  distribution => 'xyz',\n"\
                   '}'

blank_distro = "class { 'java':\n"\
               "  distribution => '',\n"\
               '}'

incorrect_package = "class { 'java':\n"\
                    "  package => 'xyz',\n"\
                    '}'

bogus_alternative = "class { 'java':\n"\
                    "  java_alternative      => 'whatever',\n"\
                    "  java_alternative_path => '/whatever',\n"\
                    '}'

# Oracle installs are disabled by default, because the links to valid oracle installations
# change often. Look the parameters up from the Oracle download URLs at https://java.oracle.com and
# enable the tests:

oracle_enabled = false
oracle_version_major = '8'
oracle_version_minor = '192'
oracle_version_build = '12'
oracle_hash = '750e1c8617c5452694857ad95c3ee230'

install_oracle_jre = <<EOL
  java::oracle {
    'test_oracle_jre':
      version       => '#{oracle_version_major}',
      version_major => '#{oracle_version_major}u#{oracle_version_minor}',
      version_minor => 'b#{oracle_version_build}',
      url_hash      => '#{oracle_hash}',
      java_se       => 'jre',
  }
EOL

install_oracle_jdk = <<EOL
  java::oracle {
    'test_oracle_jdk':
      version       => '#{oracle_version_major}',
      version_major => '#{oracle_version_major}u#{oracle_version_minor}',
      version_minor => 'b#{oracle_version_build}',
      url_hash      => '#{oracle_hash}',
      java_se       => 'jdk',
  }
EOL

install_oracle_jre_jce = <<EOL
  java::oracle {
    'test_oracle_jre':
      version       => '#{oracle_version_major}',
      version_major => '#{oracle_version_major}u#{oracle_version_minor}',
      version_minor => 'b#{oracle_version_build}',
      url_hash      => '#{oracle_hash}',
      java_se       => 'jre',
      jce           => true,
  }
EOL

install_oracle_jdk_jce = <<EOL
  java::oracle {
    'test_oracle_jdk':
      version       => '#{oracle_version_major}',
      version_major => '#{oracle_version_major}u#{oracle_version_minor}',
      version_minor => 'b#{oracle_version_build}',
      url_hash      => '#{oracle_hash}',
      java_se       => 'jdk',
      jce           => true,
  }
EOL

context 'installing java jre', unless: UNSUPPORTED_PLATFORMS.include?(fact('osfamily')) do
  it 'installs jre' do
    apply_manifest(java_class_jre, catch_failures: true)
    apply_manifest(java_class_jre, catch_changes: true)
  end
end

context 'installing java jdk', unless: UNSUPPORTED_PLATFORMS.include?(fact('osfamily')) do
  it 'installs jdk' do
    apply_manifest(java_class, catch_failures: true)
    apply_manifest(java_class, catch_changes: true)
  end
end

# C14704
# C14705
# C15006
context 'oracle', if: (
  (fact('operatingsystem') == 'Ubuntu') && fact('operatingsystemrelease').match(%r{^14\.04})
) do
  # not supported
  # The package is not available from any sources, but if a customer
  # custom-builds the package using java-package and adds it to a local
  # repository, that is the intention of this version ability
  describe 'jre' do
    it 'installs oracle-jre' do
      apply_manifest(oracle_jre, expect_failures: true)
    end
  end
  describe 'jdk' do
    it 'installs oracle-jdk' do
      apply_manifest(oracle_jdk, expect_failures: true)
    end
  end
end

context 'with failure cases' do
  # C14711
  # SLES 10 returns an exit code of 0 on zypper failure
  unless fact('operatingsystem') == 'SLES' && fact('operatingsystemrelease') < '11'
    it 'fails to install java with an incorrect version' do
      apply_manifest(incorrect_version, expect_failures: true)
    end
  end

  # C14712
  it 'fails to install java with a blank version' do
    apply_manifest(blank_version, expect_failures: true)
  end

  # C14713
  it 'fails to install java with an incorrect distribution' do
    apply_manifest(incorrect_distro, expect_failures: true)
  end

  # C14714
  it 'fails to install java with a blank distribution' do
    apply_manifest(blank_distro, expect_failures: true)
  end

  # C14715
  it 'fails to install java with an incorrect package' do
    apply_manifest(incorrect_package, expect_failures: true)
  end

  # C14717
  # C14719
  # C14725
  it 'fails on debian or RHEL when passed fake java_alternative and path' do
    if fact('osfamily') == 'Debian' || fact('osfamily') == 'RedHat'
      apply_manifest(bogus_alternative, expect_failures: true)
    else
      apply_manifest(bogus_alternative, catch_failures: true)
    end
  end
end

# Test oracle java installs
context 'java::oracle', if: oracle_enabled, unless: UNSUPPORTED_PLATFORMS.include?(fact('osfamily')) do
  install_path = '/usr/lib/jvm'
  version_suffix = ''
  if fact('osfamily') == 'RedHat' || fact('osfamily') == 'Amazon'
    install_path = '/usr/java'
    version_suffix = '-amd64'
  end
  it 'installs oracle jdk' do
    apply_manifest(install_oracle_jdk, catch_failures: true)
    apply_manifest(install_oracle_jdk, catch_changes: true)
    result = shell("test ! -e #{install_path}/jdk1.#{oracle_version_major}.0_#{oracle_version_minor}#{version_suffix}/jre/lib/security/local_policy.jar")
    expect(result.exit_code).to eq(0)
  end
  it 'installs oracle jre' do
    apply_manifest(install_oracle_jre, catch_failures: true)
    apply_manifest(install_oracle_jre, catch_changes: true)
    result = shell("test ! -e #{install_path}/jre1.#{oracle_version_major}.0_#{oracle_version_minor}#{version_suffix}/lib/security/local_policy.jar")
    expect(result.exit_code).to eq(0)
  end
  it 'installs oracle jdk with jce' do
    apply_manifest(install_oracle_jdk_jce, catch_failures: true)
    apply_manifest(install_oracle_jdk_jce, catch_changes: true)
    result = shell("test -e #{install_path}/jdk1.#{oracle_version_major}.0_#{oracle_version_minor}#{version_suffix}/jre/lib/security/local_policy.jar")
    expect(result.exit_code).to eq(0)
  end
  it 'installs oracle jre with jce' do
    apply_manifest(install_oracle_jre_jce, catch_failures: true)
    apply_manifest(install_oracle_jre_jce, catch_changes: true)
    result = shell("test -e #{install_path}/jre1.#{oracle_version_major}.0_#{oracle_version_minor}#{version_suffix}/lib/security/local_policy.jar")
    expect(result.exit_code).to eq(0)
  end
end
