# frozen_string_literal: true

require 'spec_helper'

describe 'java::adopt', type: :define do
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

    context 'when AdoptOpenJDK Java 8 JDK' do
      let(:params) { { ensure: 'present', version: '8', java: 'jdk' } }
      let(:title) { 'jdk8' }

      it { is_expected.to contain_archive('/tmp/OpenJDK8U-jdk_x64_linux_hotspot_8u202b08.tar.gz') }
      it { is_expected.to contain_exec('Install AdoptOpenJDK java jdk 8 8u202 b08').with_command(['tar', '-zxf', '/tmp/OpenJDK8U-jdk_x64_linux_hotspot_8u202b08.tar.gz', '-C', '/usr/java']) }
      it { is_expected.to contain_exec('Install AdoptOpenJDK java jdk 8 8u202 b08').that_requires('Archive[/tmp/OpenJDK8U-jdk_x64_linux_hotspot_8u202b08.tar.gz]') }
    end

    context 'when AdoptOpenJDK Java 9 JDK' do
      let(:params) { { ensure: 'present', version: '9', java: 'jdk' } }
      let(:title) { 'jdk9' }

      it { is_expected.to contain_archive('/tmp/OpenJDK9U-jdk_x64_linux_hotspot_9.0.4_11.tar.gz') }
      it { is_expected.to contain_exec('Install AdoptOpenJDK java jdk 9 9.0.4 11').with_command(['tar', '-zxf', '/tmp/OpenJDK9U-jdk_x64_linux_hotspot_9.0.4_11.tar.gz', '-C', '/usr/java']) }
      it { is_expected.to contain_exec('Install AdoptOpenJDK java jdk 9 9.0.4 11').that_requires('Archive[/tmp/OpenJDK9U-jdk_x64_linux_hotspot_9.0.4_11.tar.gz]') }
    end

    context 'when AdoptOpenJDK Java 10 JDK' do
      let(:params) { { ensure: 'present', version: '10', java: 'jdk' } }
      let(:title) { 'jdk10' }

      it { is_expected.to contain_archive('/tmp/OpenJDK10U-jdk_x64_linux_hotspot_10.0.2_13.tar.gz') }
      it { is_expected.to contain_exec('Install AdoptOpenJDK java jdk 10 10.0.2 13').with_command(['tar', '-zxf', '/tmp/OpenJDK10U-jdk_x64_linux_hotspot_10.0.2_13.tar.gz', '-C', '/usr/java']) }
      it { is_expected.to contain_exec('Install AdoptOpenJDK java jdk 10 10.0.2 13').that_requires('Archive[/tmp/OpenJDK10U-jdk_x64_linux_hotspot_10.0.2_13.tar.gz]') }
    end

    context 'when AdoptOpenJDK Java 11 JDK' do
      let(:params) { { ensure: 'present', version: '11', java: 'jdk' } }
      let(:title) { 'jdk11' }

      it { is_expected.to contain_archive('/tmp/OpenJDK11U-jdk_x64_linux_hotspot_11.0.2_9.tar.gz') }
      it { is_expected.to contain_exec('Install AdoptOpenJDK java jdk 11 11.0.2 9').with_command(['tar', '-zxf', '/tmp/OpenJDK11U-jdk_x64_linux_hotspot_11.0.2_9.tar.gz', '-C', '/usr/java']) }
      it { is_expected.to contain_exec('Install AdoptOpenJDK java jdk 11 11.0.2 9').that_requires('Archive[/tmp/OpenJDK11U-jdk_x64_linux_hotspot_11.0.2_9.tar.gz]') }
    end

    context 'when AdoptOpenJDK Java 12 JDK' do
      let(:params) { { ensure: 'present', version: '12', java: 'jdk' } }
      let(:title) { 'jdk12' }

      it { is_expected.to contain_archive('/tmp/OpenJDK12U-jdk_x64_linux_hotspot_12.0.1_12.tar.gz') }
      it { is_expected.to contain_exec('Install AdoptOpenJDK java jdk 12 12.0.1 12').with_command(['tar', '-zxf', '/tmp/OpenJDK12U-jdk_x64_linux_hotspot_12.0.1_12.tar.gz', '-C', '/usr/java']) }
      it { is_expected.to contain_exec('Install AdoptOpenJDK java jdk 12 12.0.1 12').that_requires('Archive[/tmp/OpenJDK12U-jdk_x64_linux_hotspot_12.0.1_12.tar.gz]') }
    end

    context 'when AdoptOpenJDK Java 8 JRE' do
      let(:params) { { ensure: 'present', version: '8', java: 'jre' } }
      let(:title) { 'jre8' }

      it { is_expected.to contain_archive('/tmp/OpenJDK8U-jre_x64_linux_hotspot_8u202b08.tar.gz') }
      it { is_expected.to contain_exec('Install AdoptOpenJDK java jre 8 8u202 b08').with_command(['tar', '-zxf', '/tmp/OpenJDK8U-jre_x64_linux_hotspot_8u202b08.tar.gz', '-C', '/usr/java']) }
      it { is_expected.to contain_exec('Install AdoptOpenJDK java jre 8 8u202 b08').that_requires('Archive[/tmp/OpenJDK8U-jre_x64_linux_hotspot_8u202b08.tar.gz]') }
    end

    context 'when AdoptOpenJDK Java 9 JRE' do
      let(:params) { { ensure: 'present', version: '9', java: 'jre' } }
      let(:title) { 'jre9' }

      it { is_expected.to contain_archive('/tmp/OpenJDK9U-jre_x64_linux_hotspot_9.0.4_11.tar.gz') }
      it { is_expected.to contain_exec('Install AdoptOpenJDK java jre 9 9.0.4 11').with_command(['tar', '-zxf', '/tmp/OpenJDK9U-jre_x64_linux_hotspot_9.0.4_11.tar.gz', '-C', '/usr/java']) }
      it { is_expected.to contain_exec('Install AdoptOpenJDK java jre 9 9.0.4 11').that_requires('Archive[/tmp/OpenJDK9U-jre_x64_linux_hotspot_9.0.4_11.tar.gz]') }
    end

    context 'when AdoptOpenJDK Java 10 JRE' do
      let(:params) { { ensure: 'present', version: '10', java: 'jre' } }
      let(:title) { 'jre11' }

      it { is_expected.to contain_archive('/tmp/OpenJDK10U-jre_x64_linux_hotspot_10.0.2_13.tar.gz') }
      it { is_expected.to contain_exec('Install AdoptOpenJDK java jre 10 10.0.2 13').with_command(['tar', '-zxf', '/tmp/OpenJDK10U-jre_x64_linux_hotspot_10.0.2_13.tar.gz', '-C', '/usr/java']) }
      it { is_expected.to contain_exec('Install AdoptOpenJDK java jre 10 10.0.2 13').that_requires('Archive[/tmp/OpenJDK10U-jre_x64_linux_hotspot_10.0.2_13.tar.gz]') }
    end

    context 'when AdoptOpenJDK Java 11 JRE' do
      let(:params) { { ensure: 'present', version: '11', java: 'jre' } }
      let(:title) { 'jre11' }

      it { is_expected.to contain_archive('/tmp/OpenJDK11U-jre_x64_linux_hotspot_11.0.2_9.tar.gz') }
      it { is_expected.to contain_exec('Install AdoptOpenJDK java jre 11 11.0.2 9').with_command(['tar', '-zxf', '/tmp/OpenJDK11U-jre_x64_linux_hotspot_11.0.2_9.tar.gz', '-C', '/usr/java']) }
      it { is_expected.to contain_exec('Install AdoptOpenJDK java jre 11 11.0.2 9').that_requires('Archive[/tmp/OpenJDK11U-jre_x64_linux_hotspot_11.0.2_9.tar.gz]') }
    end

    context 'when AdoptOpenJDK Java 12 JRE' do
      let(:params) { { ensure: 'present', version: '12', java: 'jre' } }
      let(:title) { 'jre12' }

      it { is_expected.to contain_archive('/tmp/OpenJDK12U-jre_x64_linux_hotspot_12.0.1_12.tar.gz') }
      it { is_expected.to contain_exec('Install AdoptOpenJDK java jre 12 12.0.1 12').with_command(['tar', '-zxf', '/tmp/OpenJDK12U-jre_x64_linux_hotspot_12.0.1_12.tar.gz', '-C', '/usr/java']) }
      it { is_expected.to contain_exec('Install AdoptOpenJDK java jre 12 12.0.1 12').that_requires('Archive[/tmp/OpenJDK12U-jre_x64_linux_hotspot_12.0.1_12.tar.gz]') }
    end

    context 'when installing multiple versions' do
      let(:params) do
        {
          ensure: 'present',
          version_major: '8u202',
          version_minor: 'b08',
          java: 'jdk'
        }
      end
      let(:title) { 'jdk8' }

      let(:pre_condition) do
        <<-MANIFEST
        java::adopt {
          'jdk8172':
            ensure        => 'present',
            version_major => '8u172',
            version_minor => 'b11',
            java          => 'jdk',
        }
        MANIFEST
      end

      it { is_expected.to compile }
    end

    context 'when specifying package_type tar.gz and basedir' do
      let(:params) do
        {
          ensure: 'present',
          version: '8',
          java: 'jdk',
          basedir: '/usr/java',
          package_type: 'tar.gz'
        }
      end
      let(:title) { 'jdk8' }

      it { is_expected.to contain_archive('/tmp/OpenJDK8U-jdk_x64_linux_hotspot_8u202b08.tar.gz') }
      it { is_expected.to contain_exec('Install AdoptOpenJDK java jdk 8 8u202 b08').with_command(['tar', '-zxf', '/tmp/OpenJDK8U-jdk_x64_linux_hotspot_8u202b08.tar.gz', '-C', '/usr/java']) }
      it { is_expected.to contain_exec('Install AdoptOpenJDK java jdk 8 8u202 b08').that_requires('Archive[/tmp/OpenJDK8U-jdk_x64_linux_hotspot_8u202b08.tar.gz]') }
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

    context 'when AdoptOpenJDK Java 8 JDK' do
      let(:params) { { ensure: 'present', version: '8', java: 'jdk' } }
      let(:title) { 'jdk8' }

      it { is_expected.to contain_archive('/tmp/OpenJDK8U-jdk_x64_linux_hotspot_8u202b08.tar.gz') }
      it { is_expected.to contain_exec('Install AdoptOpenJDK java jdk 8 8u202 b08').with_command(['tar', '-zxf', '/tmp/OpenJDK8U-jdk_x64_linux_hotspot_8u202b08.tar.gz', '-C', '/usr/lib/jvm']) }
      it { is_expected.to contain_exec('Install AdoptOpenJDK java jdk 8 8u202 b08').that_requires('Archive[/tmp/OpenJDK8U-jdk_x64_linux_hotspot_8u202b08.tar.gz]') }
    end

    context 'when AdoptOpenJDK Java 9 JDK' do
      let(:params) { { ensure: 'present', version: '9', java: 'jdk' } }
      let(:title) { 'jdk9' }

      it { is_expected.to contain_archive('/tmp/OpenJDK9U-jdk_x64_linux_hotspot_9.0.4_11.tar.gz') }
      it { is_expected.to contain_exec('Install AdoptOpenJDK java jdk 9 9.0.4 11').with_command(['tar', '-zxf', '/tmp/OpenJDK9U-jdk_x64_linux_hotspot_9.0.4_11.tar.gz', '-C', '/usr/lib/jvm']) }
      it { is_expected.to contain_exec('Install AdoptOpenJDK java jdk 9 9.0.4 11').that_requires('Archive[/tmp/OpenJDK9U-jdk_x64_linux_hotspot_9.0.4_11.tar.gz]') }
    end

    context 'when AdoptOpenJDK Java 10 JDK' do
      let(:params) { { ensure: 'present', version: '10', java: 'jdk' } }
      let(:title) { 'jdk10' }

      it { is_expected.to contain_archive('/tmp/OpenJDK10U-jdk_x64_linux_hotspot_10.0.2_13.tar.gz') }
      it { is_expected.to contain_exec('Install AdoptOpenJDK java jdk 10 10.0.2 13').with_command(['tar', '-zxf', '/tmp/OpenJDK10U-jdk_x64_linux_hotspot_10.0.2_13.tar.gz', '-C', '/usr/lib/jvm']) }
      it { is_expected.to contain_exec('Install AdoptOpenJDK java jdk 10 10.0.2 13').that_requires('Archive[/tmp/OpenJDK10U-jdk_x64_linux_hotspot_10.0.2_13.tar.gz]') }
    end

    context 'when AdoptOpenJDK Java 11 JDK' do
      let(:params) { { ensure: 'present', version: '11', java: 'jdk' } }
      let(:title) { 'jdk11' }

      it { is_expected.to contain_archive('/tmp/OpenJDK11U-jdk_x64_linux_hotspot_11.0.2_9.tar.gz') }
      it { is_expected.to contain_exec('Install AdoptOpenJDK java jdk 11 11.0.2 9').with_command(['tar', '-zxf', '/tmp/OpenJDK11U-jdk_x64_linux_hotspot_11.0.2_9.tar.gz', '-C', '/usr/lib/jvm']) }
      it { is_expected.to contain_exec('Install AdoptOpenJDK java jdk 11 11.0.2 9').that_requires('Archive[/tmp/OpenJDK11U-jdk_x64_linux_hotspot_11.0.2_9.tar.gz]') }
    end

    context 'when AdoptOpenJDK Java 12 JDK' do
      let(:params) { { ensure: 'present', version: '12', java: 'jdk' } }
      let(:title) { 'jdk12' }

      it { is_expected.to contain_archive('/tmp/OpenJDK12U-jdk_x64_linux_hotspot_12.0.1_12.tar.gz') }
      it { is_expected.to contain_exec('Install AdoptOpenJDK java jdk 12 12.0.1 12').with_command(['tar', '-zxf', '/tmp/OpenJDK12U-jdk_x64_linux_hotspot_12.0.1_12.tar.gz', '-C', '/usr/lib/jvm']) }
      it { is_expected.to contain_exec('Install AdoptOpenJDK java jdk 12 12.0.1 12').that_requires('Archive[/tmp/OpenJDK12U-jdk_x64_linux_hotspot_12.0.1_12.tar.gz]') }
    end

    context 'when AdoptOpenJDK Java 8 JRE' do
      let(:params) { { ensure: 'present', version: '8', java: 'jre' } }
      let(:title) { 'jre8' }

      it { is_expected.to contain_archive('/tmp/OpenJDK8U-jre_x64_linux_hotspot_8u202b08.tar.gz') }
      it { is_expected.to contain_exec('Install AdoptOpenJDK java jre 8 8u202 b08').with_command(['tar', '-zxf', '/tmp/OpenJDK8U-jre_x64_linux_hotspot_8u202b08.tar.gz', '-C', '/usr/lib/jvm']) }
      it { is_expected.to contain_exec('Install AdoptOpenJDK java jre 8 8u202 b08').that_requires('Archive[/tmp/OpenJDK8U-jre_x64_linux_hotspot_8u202b08.tar.gz]') }
    end

    context 'when AdoptOpenJDK Java 9 JRE' do
      let(:params) { { ensure: 'present', version: '9', java: 'jre' } }
      let(:title) { 'jre9' }

      it { is_expected.to contain_archive('/tmp/OpenJDK9U-jre_x64_linux_hotspot_9.0.4_11.tar.gz') }
      it { is_expected.to contain_exec('Install AdoptOpenJDK java jre 9 9.0.4 11').with_command(['tar', '-zxf', '/tmp/OpenJDK9U-jre_x64_linux_hotspot_9.0.4_11.tar.gz', '-C', '/usr/lib/jvm']) }
      it { is_expected.to contain_exec('Install AdoptOpenJDK java jre 9 9.0.4 11').that_requires('Archive[/tmp/OpenJDK9U-jre_x64_linux_hotspot_9.0.4_11.tar.gz]') }
    end

    context 'when AdoptOpenJDK Java 10 JRE' do
      let(:params) { { ensure: 'present', version: '10', java: 'jre' } }
      let(:title) { 'jre11' }

      it { is_expected.to contain_archive('/tmp/OpenJDK10U-jre_x64_linux_hotspot_10.0.2_13.tar.gz') }
      it { is_expected.to contain_exec('Install AdoptOpenJDK java jre 10 10.0.2 13').with_command(['tar', '-zxf', '/tmp/OpenJDK10U-jre_x64_linux_hotspot_10.0.2_13.tar.gz', '-C', '/usr/lib/jvm']) }
      it { is_expected.to contain_exec('Install AdoptOpenJDK java jre 10 10.0.2 13').that_requires('Archive[/tmp/OpenJDK10U-jre_x64_linux_hotspot_10.0.2_13.tar.gz]') }
    end

    context 'when AdoptOpenJDK Java 11 JRE' do
      let(:params) { { ensure: 'present', version: '11', java: 'jre' } }
      let(:title) { 'jre11' }

      it { is_expected.to contain_archive('/tmp/OpenJDK11U-jre_x64_linux_hotspot_11.0.2_9.tar.gz') }
      it { is_expected.to contain_exec('Install AdoptOpenJDK java jre 11 11.0.2 9').with_command(['tar', '-zxf', '/tmp/OpenJDK11U-jre_x64_linux_hotspot_11.0.2_9.tar.gz', '-C', '/usr/lib/jvm']) }
      it { is_expected.to contain_exec('Install AdoptOpenJDK java jre 11 11.0.2 9').that_requires('Archive[/tmp/OpenJDK11U-jre_x64_linux_hotspot_11.0.2_9.tar.gz]') }
    end

    context 'when AdoptOpenJDK Java 12 JRE' do
      let(:params) { { ensure: 'present', version: '12', java: 'jre' } }
      let(:title) { 'jre12' }

      it { is_expected.to contain_archive('/tmp/OpenJDK12U-jre_x64_linux_hotspot_12.0.1_12.tar.gz') }
      it { is_expected.to contain_exec('Install AdoptOpenJDK java jre 12 12.0.1 12').with_command(['tar', '-zxf', '/tmp/OpenJDK12U-jre_x64_linux_hotspot_12.0.1_12.tar.gz', '-C', '/usr/lib/jvm']) }
      it { is_expected.to contain_exec('Install AdoptOpenJDK java jre 12 12.0.1 12').that_requires('Archive[/tmp/OpenJDK12U-jre_x64_linux_hotspot_12.0.1_12.tar.gz]') }
    end

    context 'when installing multiple versions' do
      let(:params) do
        {
          ensure: 'present',
          version_major: '8u202',
          version_minor: 'b08',
          java: 'jdk'
        }
      end
      let(:title) { 'jdk8' }

      let(:pre_condition) do
        <<-MANIFEST
        java::adopt {
          'jdk8172':
            ensure        => 'present',
            version_major => '8u172',
            version_minor => 'b11',
            java          => 'jdk',
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
