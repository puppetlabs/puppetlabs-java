# frozen_string_literal: true

require 'spec_helper'

describe 'java::sap', type: :define do
  context 'with CentOS 64-bit' do
    let(:facts) { { kernel: 'Linux', os: { family: 'RedHat', architecture: 'x86_64', name: 'CentOS', release: { full: '6.0' } } } }

    context 'when manage_symlink is set to true' do
      let(:params) do
        {
          ensure: 'present',
          version: '11',
          java: 'jdk',
          basedir: '/usr/java',
          manage_symlink: true,
          symlink_name: 'java_home'
        }
      end
      let(:title) { 'jdk11_symlink' }

      it { is_expected.to contain_file('/usr/java/java_home') }
    end

    context 'when manage_symlink is not set' do
      let(:params) { { ensure: 'present', version: '11', java: 'jdk' } }
      let(:title) { 'jdk11_nosymlink' }

      it { is_expected.not_to contain_file('/usr/java/java_home') }
    end

    context 'when sapjvm 7' do
      let(:params) { { ensure: 'present', version: '7', java: 'jdk' } }
      let(:title) { 'jdk7' }

      it { is_expected.to contain_archive('/tmp/sapjvm-7.1.072-linux-x64.zip') }
    end

    context 'when sapjvm 8' do
      let(:params) { { ensure: 'present', version: '8', java: 'jdk' } }
      let(:title) { 'jdk8' }

      it { is_expected.to contain_archive('/tmp/sapjvm-8.1.065-linux-x64.zip') }
    end

    context 'when sapmachine 11 jdk' do
      let(:params) { { ensure: 'present', version: '11', java: 'jdk' } }
      let(:title) { 'jdk11' }

      it { is_expected.to contain_archive('/tmp/sapmachine-jdk-11.0.7_linux-x64_bin.tar.gz') }
    end

    context 'when sapmachine 11 jre' do
      let(:params) { { ensure: 'present', version: '11', java: 'jre' } }
      let(:title) { 'jre11' }

      it { is_expected.to contain_archive('/tmp/sapmachine-jre-11.0.7_linux-x64_bin.tar.gz') }
    end

    context 'when sapmachine 14 jdk' do
      let(:params) { { ensure: 'present', version: '14', java: 'jdk' } }
      let(:title) { 'jdk14' }

      it { is_expected.to contain_archive('/tmp/sapmachine-jdk-14.0.1_linux-x64_bin.tar.gz') }
    end

    context 'when sapmachine 14 jre' do
      let(:params) { { ensure: 'present', version: '14', java: 'jre' } }
      let(:title) { 'jre14' }

      it { is_expected.to contain_archive('/tmp/sapmachine-jre-14.0.1_linux-x64_bin.tar.gz') }
    end

    context 'when installing multiple versions' do
      let(:params) do
        {
          ensure: 'present',
          version_full: '11.0.7',
          java: 'jdk'
        }
      end
      let(:title) { 'jdk1107' }

      let(:pre_condition) do
        <<-MANIFEST
        java::sap {
          'jdk1106':
            ensure       => 'present',
            version_full => '11.0.6',
            java         => 'jdk',
        }
        MANIFEST
      end

      it { is_expected.to compile }
    end

    context 'when specifying basedir' do
      let(:params) do
        {
          ensure: 'present',
          version: '8',
          java: 'jdk',
          basedir: '/usr/java'
        }
      end
      let(:title) { 'jdk8' }

      it { is_expected.to contain_archive('/tmp/sapjvm-8.1.065-linux-x64.zip') }
    end

    context 'when manage_basedir is set to true' do
      let(:params) do
        {
          ensure: 'present',
          version: '8',
          java: 'jdk',
          basedir: '/usr/java',
          manage_basedir: true
        }
      end
      let(:title) { 'jdk8' }

      it { is_expected.to contain_file('/usr/java') }
    end
  end

  context 'with Ubuntu 64-bit' do
    let(:facts) { { kernel: 'Linux', os: { family: 'Debian', architecture: 'amd64', name: 'Ubuntu', release: { full: '18.04' } } } }

    context 'when sapjvm 7' do
      let(:params) { { ensure: 'present', version: '7', java: 'jdk' } }
      let(:title) { 'jdk7' }

      it { is_expected.to contain_archive('/tmp/sapjvm-7.1.072-linux-x64.zip') }
    end

    context 'when sapjvm 8' do
      let(:params) { { ensure: 'present', version: '8', java: 'jdk' } }
      let(:title) { 'jdk8' }

      it { is_expected.to contain_archive('/tmp/sapjvm-8.1.065-linux-x64.zip') }
    end

    context 'when sapmachine 11 jdk' do
      let(:params) { { ensure: 'present', version: '11', java: 'jdk' } }
      let(:title) { 'jdk11' }

      it { is_expected.to contain_archive('/tmp/sapmachine-jdk-11.0.7_linux-x64_bin.tar.gz') }
    end

    context 'when sapmachine 11 jre' do
      let(:params) { { ensure: 'present', version: '11', java: 'jre' } }
      let(:title) { 'jre11' }

      it { is_expected.to contain_archive('/tmp/sapmachine-jre-11.0.7_linux-x64_bin.tar.gz') }
    end

    context 'when sapmachine 14 jdk' do
      let(:params) { { ensure: 'present', version: '14', java: 'jdk' } }
      let(:title) { 'jdk14' }

      it { is_expected.to contain_archive('/tmp/sapmachine-jdk-14.0.1_linux-x64_bin.tar.gz') }
    end

    context 'when sapmachine 14 jre' do
      let(:params) { { ensure: 'present', version: '14', java: 'jre' } }
      let(:title) { 'jre14' }

      it { is_expected.to contain_archive('/tmp/sapmachine-jre-14.0.1_linux-x64_bin.tar.gz') }
    end

    context 'when installing multiple versions' do
      let(:params) do
        {
          ensure: 'present',
          version_full: '11.0.7',
          java: 'jdk'
        }
      end
      let(:title) { 'jdk1107' }

      let(:pre_condition) do
        <<-MANIFEST
        java::sap {
          'jdk1106':
            ensure       => 'present',
            version_full => '11.0.6',
            java         => 'jdk',
        }
        MANIFEST
      end

      it { is_expected.to compile }
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
