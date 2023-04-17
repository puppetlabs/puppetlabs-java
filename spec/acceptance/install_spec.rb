# frozen_string_literal: true

require 'spec_helper_acceptance'
require 'pry'

java_class_jre = "class { 'java':\n  " \
                 "distribution => 'jre',\n" \
                 '}'

java_class = "class { 'java': }"

_sources = "file_line { 'non-free source':\n  " \
           "path  => '/etc/apt/sources.list',\n  " \
           "match => \"deb http://osmirror.delivery.puppetlabs.net/debian/ ${::lsbdistcodename} main\",\n  " \
           "line  => \"deb http://osmirror.delivery.puppetlabs.net/debian/ ${::lsbdistcodename} main non-free\",\n" \
           '}'

_sun_jre = "class { 'java':\n  " \
           "distribution => 'sun-jre',\n" \
           '}'

_sun_jdk = "class { 'java':\n  " \
           "distribution => 'sun-jdk',\n" \
           '}'

blank_version = "class { 'java':\n  " \
                "version => '',\n" \
                '}'

incorrect_distro = "class { 'java':\n  " \
                   "distribution => 'xyz',\n" \
                   '}'

blank_distro = "class { 'java':\n  " \
               "distribution => '',\n" \
               '}'

incorrect_package = "class { 'java':\n  " \
                    "package => 'xyz',\n" \
                    '}'

bogus_alternative = "class { 'java':\n  " \
                    "java_alternative      => 'whatever',\n  " \
                    "java_alternative_path => '/whatever',\n" \
                    '}'

# Oracle installs are disabled by default, because the links to valid oracle installations
# change often. Look the parameters up from the Oracle download URLs at https://java.oracle.com and
# enable the tests:

oracle_enabled = false
oracle_version_major = '8'
oracle_version_minor = '201'
oracle_version_build = '09'
oracle_hash = '42970487e3af4f5aa5bca3f542482c60'

install_oracle_jdk_jre = <<MANIFEST
  java::oracle {
    'test_oracle_jre':
      version       => '#{oracle_version_major}',
      version_major => '#{oracle_version_major}u#{oracle_version_minor}',
      version_minor => 'b#{oracle_version_build}',
      url_hash      => '#{oracle_hash}',
      java_se       => 'jre',
  }
  java::oracle {
    'test_oracle_jdk':
      version       => '#{oracle_version_major}',
      version_major => '#{oracle_version_major}u#{oracle_version_minor}',
      version_minor => 'b#{oracle_version_build}',
      url_hash      => '#{oracle_hash}',
      java_se       => 'jdk',
  }
MANIFEST

install_oracle_jre_jce = <<MANIFEST
  java::oracle {
    'test_oracle_jre':
      version       => '#{oracle_version_major}',
      version_major => '#{oracle_version_major}u#{oracle_version_minor}',
      version_minor => 'b#{oracle_version_build}',
      url_hash      => '#{oracle_hash}',
      java_se       => 'jre',
      jce           => true,
  }

MANIFEST

install_oracle_jdk_jce = <<MANIFEST
  java::oracle {
    'test_oracle_jdk':
      version       => '#{oracle_version_major}',
      version_major => '#{oracle_version_major}u#{oracle_version_minor}',
      version_minor => 'b#{oracle_version_build}',
      url_hash      => '#{oracle_hash}',
      java_se       => 'jdk',
      jce           => true,
  }
MANIFEST

# AdoptOpenJDK URLs are quite generic, so tests are enabled by default
# We need to test version 8 and >8 (here we use 9), because namings are different after version 8

adopt_enabled = true unless os[:family].casecmp('SLES').zero?
adopt_version8_major = '8'
adopt_version8_minor = '202'
adopt_version8_build = '08'
adopt_version9_major = '9'
adopt_version9_full = '9.0.4'
adopt_version9_build = '11'

install_adopt_jdk_jre = <<MANIFEST
  java::adopt {
    'test_adopt_jre_version8':
      version       => '#{adopt_version8_major}',
      version_major => '#{adopt_version8_major}u#{adopt_version8_minor}',
      version_minor => 'b#{adopt_version8_build}',
      java          => 'jre',
  }
  java::adopt {
    'test_adopt_jdk_version8':
      version       => '#{adopt_version8_major}',
      version_major => '#{adopt_version8_major}u#{adopt_version8_minor}',
      version_minor => 'b#{adopt_version8_build}',
      java          => 'jdk',
  }
  java::adopt {
    'test_adopt_jre_version9':
      version       => '#{adopt_version9_major}',
      version_major => '#{adopt_version9_full}',
      version_minor => '#{adopt_version9_build}',
      java          => 'jre',
  }
  java::adopt {
    'test_adopt_jdk_version9':
      version       => '#{adopt_version9_major}',
      version_major => '#{adopt_version9_full}',
      version_minor => '#{adopt_version9_build}',
      java          => 'jdk',
  }
MANIFEST

# Adoptium

adoptium_enabled = true unless os[:family].casecmp('SLES').zero?

install_adoptium_jdk = <<MANIFEST
  java::adoptium {
    'test_adoptium_jdk_version16':
      version_major => '16',
      version_minor => '0',
      version_patch => '2',
      version_build => '7',
  }
  java::adoptium {
    'test_adoptium_jdk_version17':
      version_major => '17',
      version_minor => '0',
      version_patch => '1',
      version_build => '12',
  }
MANIFEST

sap_enabled = true
sap_version7 = '7'
sap_version7_full = '7.1.072'
sap_version8 = '8'
sap_version8_full = '8.1.065'
sap_version11 = '11'
sap_version11_full = '11.0.7'
sap_version14 = '14'
sap_version14_full = '14.0.1'

install_sap_jdk_jre = <<MANIFEST
  java::sap {
    'test_sap_jdk_version7':
      version       => '#{sap_version7}',
      version_full  => '#{sap_version7_full}',
      java          => 'jdk',
  }
  java::sap {
    'test_sap_jdk_version8':
      version       => '#{sap_version8}',
      version_full  => '#{sap_version8_full}',
      java          => 'jdk',
  }
  java::sap {
    'test_sap_jre_version11':
      version       => '#{sap_version11}',
      version_full  => '#{sap_version11_full}',
      java          => 'jre',
  }
  java::sap {
    'test_sap_jdk_version11':
      version       => '#{sap_version11}',
      version_full  => '#{sap_version11_full}',
      java          => 'jdk',
  }
  java::sap {
    'test_sap_jre_version14':
      version       => '#{sap_version14}',
      version_full  => '#{sap_version14_full}',
      java          => 'jre',
  }
  java::sap {
    'test_sap_jdk_version14':
      version       => '#{sap_version14}',
      version_full  => '#{sap_version14_full}',
      java          => 'jdk',
  }
MANIFEST

describe 'installing' do
  context 'when installing java jre' do
    it 'installs jre' do
      idempotent_apply(java_class_jre)
    end
  end

  context 'when installing java jdk' do
    it 'installs jdk' do
      idempotent_apply(java_class)
    end
  end

  context 'when with failure cases' do
    it 'fails to install java with a blank version' do
      apply_manifest(blank_version, expect_failures: true)
    end

    it 'fails to install java with an incorrect distribution' do
      apply_manifest(incorrect_distro, expect_failures: true)
    end

    it 'fails to install java with a blank distribution' do
      apply_manifest(blank_distro, expect_failures: true)
    end

    it 'fails to install java with an incorrect package' do
      apply_manifest(incorrect_package, expect_failures: true)
    end

    it 'fails on debian or RHEL when passed fake java_alternative and path' do
      if os[:family] == 'sles'
        apply_manifest(bogus_alternative, catch_failures: true)
      else
        apply_manifest(bogus_alternative, expect_failures: true)
      end
    end
  end

  context 'when java::oracle', if: oracle_enabled, unless: UNSUPPORTED_PLATFORMS.include?(os[:family]) do
    let(:install_path) do
      (os[:family] == 'redhat') ? '/usr/java' : '/usr/lib/jvm'
    end

    let(:version_suffix) do
      (os[:family] == 'redhat') ? '-amd64' : ''
    end

    it 'installs oracle jdk and jre' do
      idempotent_apply(install_oracle_jdk_jre)
      jdk_result = shell("test ! -e #{install_path}/jdk1.#{oracle_version_major}.0_#{oracle_version_minor}#{version_suffix}/jre/lib/security/local_policy.jar")
      jre_result = shell("test ! -e #{install_path}/jre1.#{oracle_version_major}.0_#{oracle_version_minor}#{version_suffix}/lib/security/local_policy.jar")
      expect(jdk_result.exit_code).to eq(0)
      expect(jre_result.exit_code).to eq(0)
    end

    it 'installs oracle jdk with jce' do
      idempotent_apply(install_oracle_jdk_jce)
      result = shell("test -e #{install_path}/jdk1.#{oracle_version_major}.0_#{oracle_version_minor}#{version_suffix}/jre/lib/security/local_policy.jar")
      expect(result.exit_code).to eq(0)
    end

    it 'installs oracle jre with jce' do
      idempotent_apply(install_oracle_jre_jce)
      result = shell("test -e #{install_path}/jre1.#{oracle_version_major}.0_#{oracle_version_minor}#{version_suffix}/lib/security/local_policy.jar")
      expect(result.exit_code).to eq(0)
    end
  end

  context 'when java::adopt', if: adopt_enabled, unless: UNSUPPORTED_PLATFORMS.include?(os[:family]) do
    let(:install_path) do
      (os[:family] == 'redhat') ? '/usr/java' : '/usr/lib/jvm'
    end

    let(:version_suffix) do
      (os[:family] == 'redhat') ? '-amd64' : ''
    end

    it 'installs adopt jdk and jre' do
      idempotent_apply(install_adopt_jdk_jre)
    end
  end

  context 'when java::adoptium', if: adoptium_enabled, unless: UNSUPPORTED_PLATFORMS.include?(os[:family]) do
    let(:install_path) do
      (os[:family] == 'redhat') ? '/usr/java' : '/usr/lib/jvm'
    end

    let(:version_suffix) do
      (os[:family] == 'redhat') ? '-amd64' : ''
    end

    it 'installs adopt jdk and jre' do
      idempotent_apply(install_adoptium_jdk)
    end
  end

  context 'when java::sap', if: sap_enabled && ['Sles'].include?(os[:family]), unless: UNSUPPORTED_PLATFORMS.include?(os[:family]) do
    let(:install_path) do
      (os[:family] == 'redhat') ? '/usr/java' : '/usr/lib/jvm'
    end

    it 'installs adopt jdk and jre' do
      idempotent_apply(install_sap_jdk_jre)
    end
  end
end
