# frozen_string_literal: true

require 'spec_helper'

describe 'java::adoptium', type: :define do
  context 'with CentOS 64-bit' do
    let(:facts) { { kernel: 'Linux', os: { family: 'RedHat', architecture: 'x86_64', name: 'CentOS', release: { full: '6.0' } } } }

    context 'when manage_symlink is set to true' do
      let(:params) do
        {
          ensure: 'present',
          version_major: '16',
          version_minor: '0',
          version_patch: '2',
          version_build: '7',
          basedir: '/usr/java',
          manage_symlink: true,
          symlink_name: 'java_home'
        }
      end
      let(:title) { 'jdk16_symlink' }

      it { is_expected.to contain_file('/usr/java/java_home') }
    end

    context 'when manage_symlink is not set' do
      let(:params) do
        {
          ensure: 'present',
          version_major: '16',
          version_minor: '0',
          version_patch: '2',
          version_build: '7',
          basedir: '/usr/java',
          symlink_name: 'java_home'
        }
      end
      let(:title) { 'jdk16_nosymlink' }

      it { is_expected.not_to contain_file('/usr/java/java_home') }
    end

    context 'when Adoptium Temurin Java 16 JDK' do
      let(:params) do
        {
          ensure: 'present',
          version_major: '16',
          version_minor: '0',
          version_patch: '2',
          version_build: '7',
          basedir: '/usr/java',
          symlink_name: 'java_home'
        }
      end
      let(:title) { 'jdk16' }

      it { is_expected.to contain_archive('/tmp/OpenJDK16U-jdk_x64_linux_hotspot_16.0.2_7.tar.gz') }
      it { is_expected.to contain_exec('Install Adoptium Temurin java 16 0 2 7').with_command(['tar', '-zxf', '/tmp/OpenJDK16U-jdk_x64_linux_hotspot_16.0.2_7.tar.gz', '-C', '/usr/java']) }
      it { is_expected.to contain_exec('Install Adoptium Temurin java 16 0 2 7').that_requires('Archive[/tmp/OpenJDK16U-jdk_x64_linux_hotspot_16.0.2_7.tar.gz]') }
    end

    context 'when Adoptium Temurin Java 17 JDK' do
      let(:params) do
        {
          ensure: 'present',
          version_major: '17',
          version_minor: '0',
          version_patch: '1',
          version_build: '12',
          basedir: '/usr/java',
          symlink_name: 'java_home'
        }
      end
      let(:title) { 'jdk17' }

      it { is_expected.to contain_archive('/tmp/OpenJDK17U-jdk_x64_linux_hotspot_17.0.1_12.tar.gz') }
      it { is_expected.to contain_exec('Install Adoptium Temurin java 17 0 1 12').with_command(['tar', '-zxf', '/tmp/OpenJDK17U-jdk_x64_linux_hotspot_17.0.1_12.tar.gz', '-C', '/usr/java']) }
      it { is_expected.to contain_exec('Install Adoptium Temurin java 17 0 1 12').that_requires('Archive[/tmp/OpenJDK17U-jdk_x64_linux_hotspot_17.0.1_12.tar.gz]') }
    end

    context 'when installing multiple versions' do
      let(:params) do
        {
          ensure: 'present',
          version_major: '16',
          version_minor: '0',
          version_patch: '2',
          version_build: '7'
        }
      end
      let(:title) { 'jdk16' }

      let(:pre_condition) do
        <<-MANIFEST
        java::adoptium {
          'jdk17':
            ensure        => 'present',
            version_major => '17',
            version_minor => '0',
            version_patch => '1',
            version_build => '12',
        }
        MANIFEST
      end

      it { is_expected.to compile }
    end

    context 'when specifying package_type tar.gz and basedir' do
      let(:params) do
        {
          ensure: 'present',
          version_major: '16',
          version_minor: '0',
          version_patch: '2',
          version_build: '7',
          basedir: '/usr/java'
        }
      end
      let(:title) { 'jdk16' }

      it { is_expected.to contain_archive('/tmp/OpenJDK16U-jdk_x64_linux_hotspot_16.0.2_7.tar.gz') }
      it { is_expected.to contain_exec('Install Adoptium Temurin java 16 0 2 7').with_command(['tar', '-zxf', '/tmp/OpenJDK16U-jdk_x64_linux_hotspot_16.0.2_7.tar.gz', '-C', '/usr/java']) }
      it { is_expected.to contain_exec('Install Adoptium Temurin java 16 0 2 7').that_requires('Archive[/tmp/OpenJDK16U-jdk_x64_linux_hotspot_16.0.2_7.tar.gz]') }
    end

    context 'when manage_basedir is set to true' do
      let(:params) do
        {
          ensure: 'present',
          version_major: '16',
          version_minor: '0',
          version_patch: '2',
          version_build: '7',
          basedir: '/usr/java',
          manage_basedir: true
        }
      end
      let(:title) { 'jdk16' }

      it { is_expected.to contain_file('/usr/java') }
    end
  end

  context 'with Ubuntu 64-bit' do
    let(:facts) { { kernel: 'Linux', os: { family: 'Debian', architecture: 'amd64', name: 'Ubuntu', release: { full: '18.04' } } } }

    context 'when Adoptium Temurin Java 16 JDK' do
      let(:params) do
        {
          ensure: 'present',
          version_major: '16',
          version_minor: '0',
          version_patch: '2',
          version_build: '7',
          symlink_name: 'java_home'
        }
      end
      let(:title) { 'jdk16' }

      it { is_expected.to contain_archive('/tmp/OpenJDK16U-jdk_x64_linux_hotspot_16.0.2_7.tar.gz') }
      it { is_expected.to contain_exec('Install Adoptium Temurin java 16 0 2 7').with_command(['tar', '-zxf', '/tmp/OpenJDK16U-jdk_x64_linux_hotspot_16.0.2_7.tar.gz', '-C', '/usr/lib/jvm']) }
      it { is_expected.to contain_exec('Install Adoptium Temurin java 16 0 2 7').that_requires('Archive[/tmp/OpenJDK16U-jdk_x64_linux_hotspot_16.0.2_7.tar.gz]') }
    end

    context 'when Adoptium Temurin Java 17 JDK' do
      let(:params) do
        {
          ensure: 'present',
          version_major: '17',
          version_minor: '0',
          version_patch: '1',
          version_build: '12',
          symlink_name: 'java_home'
        }
      end
      let(:title) { 'jdk17' }

      it { is_expected.to contain_archive('/tmp/OpenJDK17U-jdk_x64_linux_hotspot_17.0.1_12.tar.gz') }
      it { is_expected.to contain_exec('Install Adoptium Temurin java 17 0 1 12').with_command(['tar', '-zxf', '/tmp/OpenJDK17U-jdk_x64_linux_hotspot_17.0.1_12.tar.gz', '-C', '/usr/lib/jvm']) }
      it { is_expected.to contain_exec('Install Adoptium Temurin java 17 0 1 12').that_requires('Archive[/tmp/OpenJDK17U-jdk_x64_linux_hotspot_17.0.1_12.tar.gz]') }
    end

    context 'when installing multiple versions' do
      let(:params) do
        {
          ensure: 'present',
          version_major: '16',
          version_minor: '0',
          version_patch: '2',
          version_build: '7'
        }
      end
      let(:title) { 'jdk16' }

      let(:pre_condition) do
        <<-MANIFEST
        java::adoptium {
          'jdk17':
            ensure        => 'present',
            version_major => '17',
            version_minor => '0',
            version_patch => '1',
            version_build => '12',
        }
        MANIFEST
      end

      it { is_expected.to compile }
    end

    context 'when specifying package_type tar.gz and basedir' do
      let(:params) do
        {
          ensure: 'present',
          version_major: '16',
          version_minor: '0',
          version_patch: '2',
          version_build: '7',
          basedir: '/usr/lib/jvm'
        }
      end
      let(:title) { 'jdk16' }

      it { is_expected.to contain_archive('/tmp/OpenJDK16U-jdk_x64_linux_hotspot_16.0.2_7.tar.gz') }
      it { is_expected.to contain_exec('Install Adoptium Temurin java 16 0 2 7').with_command(['tar', '-zxf', '/tmp/OpenJDK16U-jdk_x64_linux_hotspot_16.0.2_7.tar.gz', '-C', '/usr/lib/jvm']) }
      it { is_expected.to contain_exec('Install Adoptium Temurin java 16 0 2 7').that_requires('Archive[/tmp/OpenJDK16U-jdk_x64_linux_hotspot_16.0.2_7.tar.gz]') }
    end

    context 'when manage_basedir is set to true' do
      let(:params) do
        {
          ensure: 'present',
          version_major: '16',
          version_minor: '0',
          version_patch: '2',
          version_build: '7',
          basedir: '/usr/lib/jvm',
          manage_basedir: true
        }
      end
      let(:title) { 'jdk16' }

      it { is_expected.to contain_file('/usr/lib/jvm') }
    end
  end

  describe 'incompatible OSes' do
    [
      {
        kernel: 'Windows',
        os: {
          family: 'Windows',
          name: 'Windows',
          release: {
            full: '8.1'
          }
        }
      },
      {
        kernel: 'Darwin',
        os: {
          family: 'Darwin',
          name: 'Darwin',
          release: {
            full: '13.3.0'
          }
        }
      },
      {
        kernel: 'AIX',
        os: {
          family: 'AIX',
          name: 'AIX',
          release: {
            full: '7100-02-00-000'
          }
        }
      },
      {
        kernel: 'AIX',
        os: {
          family: 'AIX',
          name: 'AIX',
          release: {
            full: '6100-07-04-1216'
          }
        }
      },
      {
        kernel: 'AIX',
        os: {
          family: 'AIX',
          name: 'AIX',
          release: {
            full: '5300-12-01-1016'
          }
        }
      },
    ].each do |facts|
      let(:facts) { facts }
      let(:title) { 'jdk' }

      it "is_expected.to fail on #{facts[:os][:name]} #{facts[:os][:release][:full]}" do
        expect { catalogue }.to raise_error Puppet::Error, %r{unsupported platform}
      end
    end
  end
end
