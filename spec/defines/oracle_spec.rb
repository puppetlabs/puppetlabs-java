require 'spec_helper'

oracle_url = 'http://download.oracle.com/otn-pub/java/jdk/8u192-b12/750e1c8617c5452694857ad95c3ee230/jdk-8u192-linux-x64.tar.gz'

describe 'java::oracle', type: :define do
  context 'with CentOS 64-bit' do
    let(:facts) { { kernel: 'Linux', os: { family: 'RedHat', architecture: 'x86_64', name: 'CentOS', release: { full: '6.0' } } } }

    context 'when Oracle Java SE 6 JDK' do
      let(:params) { { ensure: 'present', version: '6', java_se: 'jdk' } }
      let(:title) { 'jdk6' }

      it { is_expected.to contain_archive('/tmp/jdk-6u45-linux-x64-rpm.bin') }
      it { is_expected.to contain_exec('Install Oracle java_se jdk 6 6u45 b06').with_command('sh /tmp/jdk-6u45-linux-x64-rpm.bin -x; rpm --force -iv sun*.rpm; rpm --force -iv jdk*.rpm') }
      it { is_expected.to contain_exec('Install Oracle java_se jdk 6 6u45 b06').that_requires('Archive[/tmp/jdk-6u45-linux-x64-rpm.bin]') }
    end

    context 'when Oracle Java SE 7 JDK' do
      let(:params) { { ensure: 'present', version: '7', java_se: 'jdk' } }
      let(:title) { 'jdk7' }

      it { is_expected.to contain_archive('/tmp/jdk-7u80-linux-x64.rpm') }
      it { is_expected.to contain_exec('Install Oracle java_se jdk 7 7u80 b15').with_command('rpm --force -iv /tmp/jdk-7u80-linux-x64.rpm') }
      it { is_expected.to contain_exec('Install Oracle java_se jdk 7 7u80 b15').that_requires('Archive[/tmp/jdk-7u80-linux-x64.rpm]') }
    end

    context 'when Oracle Java SE 8 JDK' do
      let(:params) { { ensure: 'present', version: '8', java_se: 'jdk' } }
      let(:title) { 'jdk8' }

      it { is_expected.to contain_archive('/tmp/jdk-8u192-linux-x64.rpm') }
      it { is_expected.to contain_exec('Install Oracle java_se jdk 8 8u192 b12').with_command('rpm --force -iv /tmp/jdk-8u192-linux-x64.rpm') }
      it { is_expected.to contain_exec('Install Oracle java_se jdk 8 8u192 b12').that_requires('Archive[/tmp/jdk-8u192-linux-x64.rpm]') }
    end

    context 'when Oracle Java SE 6 JRE' do
      let(:params) { { ensure: 'present', version: '6', java_se: 'jre' } }
      let(:title) { 'jre6' }

      it { is_expected.to contain_archive('/tmp/jre-6u45-linux-x64-rpm.bin') }
      it { is_expected.to contain_exec('Install Oracle java_se jre 6 6u45 b06').with_command('sh /tmp/jre-6u45-linux-x64-rpm.bin -x; rpm --force -iv sun*.rpm; rpm --force -iv jre*.rpm') }
      it { is_expected.to contain_exec('Install Oracle java_se jre 6 6u45 b06').that_requires('Archive[/tmp/jre-6u45-linux-x64-rpm.bin]') }
    end

    context 'when Oracle Java SE 7 JRE' do
      let(:params) { { ensure: 'present', version: '7', java_se: 'jre' } }
      let(:title) { 'jre7' }

      it { is_expected.to contain_archive('/tmp/jre-7u80-linux-x64.rpm') }
      it { is_expected.to contain_exec('Install Oracle java_se jre 7 7u80 b15').with_command('rpm --force -iv /tmp/jre-7u80-linux-x64.rpm') }
      it { is_expected.to contain_exec('Install Oracle java_se jre 7 7u80 b15').that_requires('Archive[/tmp/jre-7u80-linux-x64.rpm]') }
    end

    context 'when select Oracle Java SE 8 JRE' do
      let(:params) { { ensure: 'present', version: '8', java_se: 'jre' } }
      let(:title) { 'jre8' }

      it { is_expected.to contain_archive('/tmp/jre-8u192-linux-x64.rpm') }
      it { is_expected.to contain_exec('Install Oracle java_se jre 8 8u192 b12').with_command('rpm --force -iv /tmp/jre-8u192-linux-x64.rpm') }
      it { is_expected.to contain_exec('Install Oracle java_se jre 8 8u192 b12').that_requires('Archive[/tmp/jre-8u192-linux-x64.rpm]') }
    end

    context 'when passing URL to url parameter' do
      let(:params) do
        {
          ensure: 'present',
          version_major: '8u192',
          version_minor: 'b12',
          java_se: 'jdk',
          url: 'http://download.oracle.com/otn-pub/java/jdk/8u192-b12/750e1c8617c5452694857ad95c3ee230/jdk-8u192-linux-x64.rpm',
          url_hash: 'ignored',
        }
      end
      let(:title) { 'jdk8' }

      it {
        is_expected.to contain_archive('/tmp/jdk-8u192-linux-x64.rpm')
          .with_source('http://download.oracle.com/otn-pub/java/jdk/8u192-b12/750e1c8617c5452694857ad95c3ee230/jdk-8u192-linux-x64.rpm')
      }
    end

    context 'when passing a hash to url_hash parameter' do
      let(:params) do
        {
          ensure: 'present',
          version_major: '8u192',
          version_minor: 'b12',
          java_se: 'jdk',
          url_hash: '750e1c8617c5452694857ad95c3ee230',
        }
      end
      let(:title) { 'jdk8' }

      it {
        is_expected.to contain_archive('/tmp/jdk-8u192-linux-x64.rpm')
          .with_source('http://download.oracle.com/otn-pub/java/jdk//8u192-b12/750e1c8617c5452694857ad95c3ee230/jdk-8u192-linux-x64.rpm')
      }
    end

    context 'when installing multiple versions' do
      let(:params) do
        {
          ensure: 'present',
          version_major: '8u192',
          version_minor: 'b12',
          java_se: 'jdk',
          url_hash: '750e1c8617c5452694857ad95c3ee230',
        }
      end
      let(:title) { 'jdk8' }

      let(:pre_condition) do
        <<-EOL
        java::oracle {
          'jdk8121':
            ensure        => 'present',
            version_major => '8u121',
            version_minor => 'b13',
            java_se       => 'jdk',
            url_hash      => 'abcdef01234567890',
        }
        EOL
      end

      it { is_expected.to compile }
    end

    context 'when installing Oracle Java SE 6 JRE with JCE' do
      let(:params) { { ensure: 'present', jce: true, version: '6', version_major: '6u99', version_minor: '99', java_se: 'jre' } }
      let(:title) { 'jre6jce' }

      it do
        is_expected.to contain_archive('/tmp/jce-6.zip').with_source('http://download.oracle.com/otn-pub/java/jce_policy/6/jce_policy-6.zip')
        is_expected.to contain_archive('/tmp/jce-6.zip').with_extract_path('/usr/java/jre1.6.0_99-amd64/lib/security')
      end
    end

    context 'when installing Oracle Java SE 6 JDK with JCE' do
      let(:params) { { ensure: 'present', jce: true, version: '6', version_major: '6u99', version_minor: '99', java_se: 'jdk' } }
      let(:title) { 'jre6jce' }

      it do
        is_expected.to contain_archive('/tmp/jce-6.zip').with_source('http://download.oracle.com/otn-pub/java/jce_policy/6/jce_policy-6.zip')
        is_expected.to contain_archive('/tmp/jce-6.zip').with_extract_path('/usr/java/jdk1.6.0_99-amd64/jre/lib/security')
      end
    end
  end

  context 'when on CentOS 32-bit' do
    let(:facts) { { kernel: 'Linux', os: { family: 'RedHat', architecture: 'i386', name: 'CentOS', release: { full: '6.6' } } } }

    context 'when selecting Oracle Java SE 6 JDK on RedHat family, 32-bit' do
      let(:params) { { ensure: 'present', version: '6', java_se: 'jdk' } }
      let(:title) { 'jdk6' }

      it { is_expected.to contain_archive('/tmp/jdk-6u45-linux-i586-rpm.bin') }
      it { is_expected.to contain_exec('Install Oracle java_se jdk 6 6u45 b06').with_command('sh /tmp/jdk-6u45-linux-i586-rpm.bin -x; rpm --force -iv sun*.rpm; rpm --force -iv jdk*.rpm') }
      it { is_expected.to contain_exec('Install Oracle java_se jdk 6 6u45 b06').that_requires('Archive[/tmp/jdk-6u45-linux-i586-rpm.bin]') }
    end

    context 'when selecting Oracle Java SE 7 JDK on RedHat family, 32-bit' do
      let(:params) { { ensure: 'present', version: '7', java_se: 'jdk' } }
      let(:title) { 'jdk7' }

      it { is_expected.to contain_archive('/tmp/jdk-7u80-linux-i586.rpm') }
      it { is_expected.to contain_exec('Install Oracle java_se jdk 7 7u80 b15').with_command('rpm --force -iv /tmp/jdk-7u80-linux-i586.rpm') }
      it { is_expected.to contain_exec('Install Oracle java_se jdk 7 7u80 b15').that_requires('Archive[/tmp/jdk-7u80-linux-i586.rpm]') }
    end

    context 'when selecting Oracle Java SE 8 JDK on RedHat family, 32-bit' do
      let(:params) { { ensure: 'present', version: '8', java_se: 'jdk' } }
      let(:title) { 'jdk8' }

      it { is_expected.to contain_archive('/tmp/jdk-8u192-linux-i586.rpm') }
      it { is_expected.to contain_exec('Install Oracle java_se jdk 8 8u192 b12').with_command('rpm --force -iv /tmp/jdk-8u192-linux-i586.rpm') }
      it { is_expected.to contain_exec('Install Oracle java_se jdk 8 8u192 b12').that_requires('Archive[/tmp/jdk-8u192-linux-i586.rpm]') }
    end

    context 'when selecting Oracle Java SE 6 JRE on RedHat family, 32-bit' do
      let(:params) { { ensure: 'present', version: '6', java_se: 'jre' } }
      let(:title) { 'jdk6' }

      it { is_expected.to contain_archive('/tmp/jre-6u45-linux-i586-rpm.bin') }
      it { is_expected.to contain_exec('Install Oracle java_se jre 6 6u45 b06').with_command('sh /tmp/jre-6u45-linux-i586-rpm.bin -x; rpm --force -iv sun*.rpm; rpm --force -iv jre*.rpm') }
      it { is_expected.to contain_exec('Install Oracle java_se jre 6 6u45 b06').that_requires('Archive[/tmp/jre-6u45-linux-i586-rpm.bin]') }
    end

    context 'when select Oracle Java SE 7 JRE on RedHat family, 32-bit' do
      let(:params) { { ensure: 'present', version: '7', java_se: 'jre' } }
      let(:title) { 'jdk7' }

      it { is_expected.to contain_archive('/tmp/jre-7u80-linux-i586.rpm') }
      it { is_expected.to contain_exec('Install Oracle java_se jre 7 7u80 b15').with_command('rpm --force -iv /tmp/jre-7u80-linux-i586.rpm') }
      it { is_expected.to contain_exec('Install Oracle java_se jre 7 7u80 b15').that_requires('Archive[/tmp/jre-7u80-linux-i586.rpm]') }
    end

    context 'when select Oracle Java SE 8 JRE on RedHat family, 32-bit' do
      let(:params) { { ensure: 'present', version: '8', java_se: 'jre' } }
      let(:title) { 'jdk8' }

      it { is_expected.to contain_archive('/tmp/jre-8u192-linux-i586.rpm') }
      it { is_expected.to contain_exec('Install Oracle java_se jre 8 8u192 b12').with_command('rpm --force -iv /tmp/jre-8u192-linux-i586.rpm') }
      it { is_expected.to contain_exec('Install Oracle java_se jre 8 8u192 b12').that_requires('Archive[/tmp/jre-8u192-linux-i586.rpm]') }
    end

    context 'when installing multiple versions' do
      let(:params) do
        {
          ensure: 'present',
          version_major: '8u192',
          version_minor: 'b12',
          java_se: 'jdk',
          url_hash: '750e1c8617c5452694857ad95c3ee230',
        }
      end
      let(:title) { 'jdk8' }

      let(:pre_condition) do
        <<-EOL
        java::oracle {
          'jdk8121':
            ensure        => 'present',
            version_major => '8u121',
            version_minor => 'b13',
            java_se       => 'jdk',
            url_hash      => 'abcdef01234567890',
        }
        EOL
      end

      it { is_expected.to compile }
    end

    context 'when installing Oracle Java SE 6 JRE with JCE' do
      let(:params) { { ensure: 'present', jce: true, version: '6', version_major: '6u99', version_minor: '99', java_se: 'jre' } }
      let(:title) { 'jre6jce' }

      it do
        is_expected.to contain_archive('/tmp/jce-6.zip').with_source('http://download.oracle.com/otn-pub/java/jce_policy/6/jce_policy-6.zip')
        is_expected.to contain_archive('/tmp/jce-6.zip').with_extract_path('/usr/java/jre1.6.0_99-amd64/lib/security')
      end
    end

    context 'when installing Oracle Java SE 6 JDK with JCE' do
      let(:params) { { ensure: 'present', jce: true, version: '6', version_major: '6u99', version_minor: '99', java_se: 'jdk' } }
      let(:title) { 'jre6jce' }

      it do
        is_expected.to contain_archive('/tmp/jce-6.zip').with_source('http://download.oracle.com/otn-pub/java/jce_policy/6/jce_policy-6.zip')
        is_expected.to contain_archive('/tmp/jce-6.zip').with_extract_path('/usr/java/jdk1.6.0_99-amd64/jre/lib/security')
      end
    end
  end

  context 'with Ubuntu 64-bit' do
    let(:facts) { { kernel: 'Linux', os: { family: 'Debian', architecture: 'amd64', name: 'Ubuntu', release: { full: '16.04' } } } }

    context 'when Oracle Java SE 6 JDK' do
      let(:params) { { ensure: 'present', version: '6', java_se: 'jdk' } }
      let(:title) { 'jdk6' }

      it { is_expected.to contain_archive('/tmp/jdk-6u45-linux-x64.tar.gz') }
      it { is_expected.to contain_exec('Install Oracle java_se jdk 6 6u45 b06').with_command('tar -zxf /tmp/jdk-6u45-linux-x64.tar.gz -C /usr/lib/jvm') }
      it { is_expected.to contain_exec('Install Oracle java_se jdk 6 6u45 b06').that_requires('Archive[/tmp/jdk-6u45-linux-x64.tar.gz]') }
    end

    context 'with Oracle Java SE 7 JDK' do
      let(:params) { { ensure: 'present', version: '7', java_se: 'jdk' } }
      let(:title) { 'jdk7' }

      it { is_expected.to contain_archive('/tmp/jdk-7u80-linux-x64.tar.gz') }
      it { is_expected.to contain_exec('Install Oracle java_se jdk 7 7u80 b15').with_command('tar -zxf /tmp/jdk-7u80-linux-x64.tar.gz -C /usr/lib/jvm') }
      it { is_expected.to contain_exec('Install Oracle java_se jdk 7 7u80 b15').that_requires('Archive[/tmp/jdk-7u80-linux-x64.tar.gz]') }
    end

    context 'with Oracle Java SE 8 JDK' do
      let(:params) { { ensure: 'present', version: '8', java_se: 'jdk' } }
      let(:title) { 'jdk8' }

      it { is_expected.to contain_archive('/tmp/jdk-8u192-linux-x64.tar.gz') }
      it { is_expected.to contain_exec('Install Oracle java_se jdk 8 8u192 b12').with_command('tar -zxf /tmp/jdk-8u192-linux-x64.tar.gz -C /usr/lib/jvm') }
      it { is_expected.to contain_exec('Install Oracle java_se jdk 8 8u192 b12').that_requires('Archive[/tmp/jdk-8u192-linux-x64.tar.gz]') }
    end

    context 'with Oracle Java SE 6 JRE' do
      let(:params) { { ensure: 'present', version: '6', java_se: 'jre' } }
      let(:title) { 'jre6' }

      it { is_expected.to contain_archive('/tmp/jre-6u45-linux-x64.tar.gz') }
      it { is_expected.to contain_exec('Install Oracle java_se jre 6 6u45 b06').with_command('tar -zxf /tmp/jre-6u45-linux-x64.tar.gz -C /usr/lib/jvm') }
      it { is_expected.to contain_exec('Install Oracle java_se jre 6 6u45 b06').that_requires('Archive[/tmp/jre-6u45-linux-x64.tar.gz]') }
    end

    context 'when Oracle Java SE 7 JRE' do
      let(:params) { { ensure: 'present', version: '7', java_se: 'jre' } }
      let(:title) { 'jre7' }

      it { is_expected.to contain_archive('/tmp/jre-7u80-linux-x64.tar.gz') }
      it { is_expected.to contain_exec('Install Oracle java_se jre 7 7u80 b15').with_command('tar -zxf /tmp/jre-7u80-linux-x64.tar.gz -C /usr/lib/jvm') }
      it { is_expected.to contain_exec('Install Oracle java_se jre 7 7u80 b15').that_requires('Archive[/tmp/jre-7u80-linux-x64.tar.gz]') }
    end

    context 'when Oracle Java SE 8 JRE' do
      let(:params) { { ensure: 'present', version: '8', java_se: 'jre' } }
      let(:title) { 'jre8' }

      it { is_expected.to contain_archive('/tmp/jre-8u192-linux-x64.tar.gz') }
      it { is_expected.to contain_exec('Install Oracle java_se jre 8 8u192 b12').with_command('tar -zxf /tmp/jre-8u192-linux-x64.tar.gz -C /usr/lib/jvm') }
      it { is_expected.to contain_exec('Install Oracle java_se jre 8 8u192 b12').that_requires('Archive[/tmp/jre-8u192-linux-x64.tar.gz]') }
    end

    context 'when passing URL to url parameter' do
      let(:params) { { ensure: 'present', version_major: '8u192', version_minor: 'b12', java_se: 'jdk', url: oracle_url.to_s } }
      let(:title) { 'jdk8' }

      it { is_expected.to contain_archive('/tmp/jdk-8u192-linux-x64.tar.gz') }
    end

    context 'when installing multiple versions' do
      let(:params) do
        {
          ensure: 'present',
          version_major: '8u192',
          version_minor: 'b12',
          java_se: 'jdk',
          url_hash: '750e1c8617c5452694857ad95c3ee230',
        }
      end
      let(:title) { 'jdk8' }

      let(:pre_condition) do
        <<-EOL
        java::oracle {
          'jdk8121':
            ensure        => 'present',
            version_major => '8u121',
            version_minor => 'b13',
            java_se       => 'jdk',
            url_hash      => 'abcdef01234567890',
        }
        EOL
      end

      it { is_expected.to compile }
    end

    context 'when installing Oracle Java SE 6 JRE with JCE' do
      let(:params) { { ensure: 'present', jce: true, version: '6', version_major: '6u99', version_minor: '99', java_se: 'jre' } }
      let(:title) { 'jre6jce' }

      it do
        is_expected.to contain_archive('/tmp/jce-6.zip').with_source('http://download.oracle.com/otn-pub/java/jce_policy/6/jce_policy-6.zip')
        is_expected.to contain_archive('/tmp/jce-6.zip').with_extract_path('/usr/lib/jvm/jre1.6.0_99/lib/security')
      end
    end

    context 'when installing Oracle Java SE 6 JDK with JCE' do
      let(:params) { { ensure: 'present', jce: true, version: '6', version_major: '6u99', version_minor: '99', java_se: 'jdk' } }
      let(:title) { 'jre6jce' }

      it do
        is_expected.to contain_archive('/tmp/jce-6.zip').with_source('http://download.oracle.com/otn-pub/java/jce_policy/6/jce_policy-6.zip')
        is_expected.to contain_archive('/tmp/jce-6.zip').with_extract_path('/usr/lib/jvm/jdk1.6.0_99/jre/lib/security')
      end
    end
  end
  describe 'incompatible OSes' do
    [
      {
        # C14706
        kernel: 'Windows',
        os: {
          family: 'Windows',
          name: 'Windows',
          release: {
            full: '8.1',
          },
        },
      },
      {
        # C14707
        kernel: 'Darwin',
        os: {
          family: 'Darwin',
          name: 'Darwin',
          release: {
            full: '13.3.0',
          },
        },
      },
      {
        # C14708
        kernel: 'AIX',
        os: {
          family: 'AIX',
          name: 'AIX',
          release: {
            full: '7100-02-00-000',
          },
        },
      },
      {
        # C14709
        kernel: 'AIX',
        os: {
          family: 'AIX',
          name: 'AIX',
          release: {
            full: '6100-07-04-1216',
          },
        },
      },
      {
        # C14710
        kernel: 'AIX',
        os: {
          family: 'AIX',
          name: 'AIX',
          release: {
            full: '5300-12-01-1016',
          },
        },
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
