require 'spec_helper'

describe 'java', type: :class do
  context 'select openjdk for Centos 5.8' do
    let(:facts) { { osfamily: 'RedHat', operatingsystem: 'Centos', operatingsystemrelease: '5.8', architecture: 'x86_64' } }

    it { is_expected.to contain_package('java').with_name('java-1.6.0-openjdk-devel') }
    it { is_expected.to contain_file_line('java-home-environment').with_line('JAVA_HOME=/usr/lib/jvm/java-1.6.0/') }
  end

  context 'select openjdk for Centos 6.3' do
    let(:facts) { { osfamily: 'RedHat', operatingsystem: 'Centos', operatingsystemrelease: '6.3', architecture: 'x86_64' } }

    it { is_expected.to contain_package('java').with_name('java-1.7.0-openjdk-devel') }
    it { is_expected.to contain_file_line('java-home-environment').with_line('JAVA_HOME=/usr/lib/jvm/java-1.7.0/') }
  end

  context 'select openjdk for Centos 7.1.1503' do
    let(:facts) { { osfamily: 'RedHat', operatingsystem: 'Centos', operatingsystemrelease: '7.1.1503', architecture: 'x86_64' } }

    it { is_expected.to contain_package('java').with_name('java-1.8.0-openjdk-devel') }
    it { is_expected.to contain_file_line('java-home-environment').with_line('JAVA_HOME=/usr/lib/jvm/java-1.8.0/') }
  end

  context 'select openjdk for Centos 6.2' do
    let(:facts) { { osfamily: 'RedHat', operatingsystem: 'Centos', operatingsystemrelease: '6.2', architecture: 'x86_64' } }

    it { is_expected.to contain_package('java').with_name('java-1.6.0-openjdk-devel') }
    it { is_expected.not_to contain_exec('update-java-alternatives') }
  end

  context 'select Oracle JRE with alternatives for Centos 6.3' do
    let(:facts) { { osfamily: 'RedHat', operatingsystem: 'Centos', operatingsystemrelease: '6.3', architecture: 'x86_64' } }
    let(:params) { { 'package' => 'jre', 'java_alternative' => '/usr/bin/java', 'java_alternative_path' => '/usr/java/jre1.7.0_67/bin/java' } }

    it { is_expected.to contain_package('java').with_name('jre') }
    it { is_expected.to contain_exec('create-java-alternatives').with_command('alternatives --install /usr/bin/java java /usr/java/jre1.7.0_67/bin/java 20000') }
    it { is_expected.to contain_exec('update-java-alternatives').with_command('alternatives --set java /usr/java/jre1.7.0_67/bin/java') }
  end

  context 'select openjdk for Fedora 20' do
    let(:facts) { { osfamily: 'RedHat', operatingsystem: 'Fedora', operatingsystemrelease: '20', architecture: 'x86_64' } }

    it { is_expected.to contain_package('java').with_name('java-1.7.0-openjdk-devel') }
    it { is_expected.to contain_file_line('java-home-environment').with_line('JAVA_HOME=/usr/lib/jvm/java-1.7.0-openjdk-x86_64/') }
  end

  context 'select openjdk for Fedora 21' do
    let(:facts) { { osfamily: 'RedHat', operatingsystem: 'Fedora', operatingsystemrelease: '21', architecture: 'x86_64' } }

    it { is_expected.to contain_package('java').with_name('java-1.8.0-openjdk-devel') }
    it { is_expected.to contain_file_line('java-home-environment').with_line('JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-x86_64/') }
  end

  context 'select passed value for Fedora 20' do
    let(:facts) { { osfamily: 'RedHat', operatingsystem: 'Fedora', operatingsystemrelease: '20', architecture: 'x86_64' } }
    let(:params) { { 'distribution' => 'jre', 'java_home' => '/usr/local/lib/jre/' } }

    it { is_expected.to contain_package('java').with_name('java-1.7.0-openjdk') }
    it { is_expected.to contain_file_line('java-home-environment').with_line('JAVA_HOME=/usr/local/lib/jre/') }
  end

  context 'select passed value for Fedora 21' do
    let(:facts) { { osfamily: 'RedHat', operatingsystem: 'Fedora', operatingsystemrelease: '21', architecture: 'x86_64' } }
    let(:params) { { 'distribution' => 'jre', 'java_home' => '/usr/local/lib/jre/' } }

    it { is_expected.to contain_package('java').with_name('java-1.8.0-openjdk') }
    it { is_expected.to contain_file_line('java-home-environment').with_line('JAVA_HOME=/usr/local/lib/jre/') }
  end

  context 'select passed value for Fedora 21 with yum option' do
    let(:facts) { { osfamily: 'RedHat', operatingsystem: 'Fedora', operatingsystemrelease: '21', architecture: 'x86_64' } }
    let(:params) { { 'distribution' => 'jre', 'package_options' => ['--skip-broken'] } }

    it { is_expected.to contain_package('java') }
  end

  context 'select passed value for Centos 5.3' do
    let(:facts) { { osfamily: 'RedHat', operatingsystem: 'Centos', operatingsystemrelease: '5.3', architecture: 'x86_64' } }
    let(:params) { { 'package' => 'jdk', 'java_home' => '/usr/local/lib/jre' } }

    it { is_expected.to contain_package('java').with_name('jdk') }
    it { is_expected.not_to contain_exec('update-java-alternatives') }
  end

  context 'select default for Centos 5.3' do
    let(:facts) { { osfamily: 'RedHat', operatingsystem: 'Centos', operatingsystemrelease: '5.3', architecture: 'x86_64' } }

    it { is_expected.to contain_package('java').with_name('java-1.6.0-openjdk-devel') }
    it { is_expected.not_to contain_exec('update-java-alternatives') }
  end

  context 'select default for Debian Wheezy' do
    let(:facts) { { osfamily: 'Debian', operatingsystem: 'Debian', lsbdistcodename: 'wheezy', operatingsystemrelease: '7.1', architecture: 'amd64' } }

    it { is_expected.to contain_package('java').with_name('openjdk-7-jdk') }
    it { is_expected.to contain_exec('update-java-alternatives').with_command('update-java-alternatives --set java-1.7.0-openjdk-amd64 --jre') }
    it { is_expected.to contain_file_line('java-home-environment').with_line('JAVA_HOME=/usr/lib/jvm/java-1.7.0-openjdk-amd64/') }
  end

  context 'select Oracle JRE for Debian Wheezy' do
    let(:facts) { { osfamily: 'Debian', operatingsystem: 'Debian', lsbdistcodename: 'wheezy', operatingsystemrelease: '7.1', architecture: 'amd64' } }
    let(:params) { { 'distribution' => 'oracle-jre' } }

    it { is_expected.to contain_package('java').with_name('oracle-j2re1.7') }
    it { is_expected.to contain_exec('update-java-alternatives').with_command('update-java-alternatives --set j2re1.7-oracle --jre') }
    it { is_expected.to contain_file_line('java-home-environment').with_line('JAVA_HOME=/usr/lib/jvm/j2re1.7-oracle/') }
  end

  context 'select Oracle Java 8 JRE >=u100 for Debian Wheezy' do
    let(:facts) { { osfamily: 'Debian', operatingsystem: 'Debian', lsbdistcodename: 'wheezy', operatingsystemrelease: '7.1', architecture: 'amd64' } }
    let(:params) { { 'distribution' => 'oracle-java8-jre' } }

    it { is_expected.to contain_package('java').with_name('oracle-java8-jre') }
    it { is_expected.to contain_exec('update-java-alternatives').with_command('update-java-alternatives --set jre-8-oracle-x64 --jre') }
  end

  context 'select Oracle Java 8 JDK >=u100 for Debian Wheezy' do
    let(:facts) { { osfamily: 'Debian', operatingsystem: 'Debian', lsbdistcodename: 'wheezy', operatingsystemrelease: '7.1', architecture: 'amd64' } }
    let(:params) { { 'distribution' => 'oracle-java8-jdk' } }

    it { is_expected.to contain_package('java').with_name('oracle-java8-jdk') }
    it { is_expected.to contain_exec('update-java-alternatives').with_command('update-java-alternatives --set jdk-8-oracle-x64 --jre') }
  end

  context 'select OpenJDK JRE for Debian Wheezy' do
    let(:facts) { { osfamily: 'Debian', operatingsystem: 'Debian', lsbdistcodename: 'wheezy', operatingsystemrelease: '7.1', architecture: 'amd64' } }
    let(:params) { { 'distribution' => 'jre' } }

    it { is_expected.to contain_package('java').with_name('openjdk-7-jre-headless') }
    it { is_expected.to contain_exec('update-java-alternatives').with_command('update-java-alternatives --set java-1.7.0-openjdk-amd64 --jre-headless') }
    it { is_expected.to contain_file_line('java-home-environment').with_line('JAVA_HOME=/usr/lib/jvm/java-1.7.0-openjdk-amd64/') }
  end

  context 'select default for Debian Squeeze' do
    let(:facts) { { osfamily: 'Debian', operatingsystem: 'Debian', lsbdistcodename: 'squeeze', operatingsystemrelease: '6.0.5', architecture: 'amd64' } }

    it { is_expected.to contain_package('java').with_name('openjdk-6-jdk') }
    it { is_expected.to contain_exec('update-java-alternatives').with_command('update-java-alternatives --set java-6-openjdk-amd64 --jre') }
  end

  context 'select Oracle JRE for Debian Squeeze' do
    let(:facts) { { osfamily: 'Debian', operatingsystem: 'Debian', lsbdistcodename: 'squeeze', operatingsystemrelease: '6.0.5', architecture: 'amd64' } }
    let(:params) { { 'distribution' => 'sun-jre' } }

    it { is_expected.to contain_package('java').with_name('sun-java6-jre') }
    it { is_expected.to contain_exec('update-java-alternatives').with_command('update-java-alternatives --set java-6-sun --jre') }
    it { is_expected.to contain_file_line('java-home-environment').with_line('JAVA_HOME=/usr/lib/jvm/java-6-sun/jre/') }
  end

  context 'select OpenJDK JRE for Debian Squeeze' do
    let(:facts) { { osfamily: 'Debian', operatingsystem: 'Debian', lsbdistcodename: 'squeeze', operatingsystemrelease: '6.0.5', architecture: 'amd64' } }
    let(:params) { { 'distribution' => 'jre' } }

    it { is_expected.to contain_package('java').with_name('openjdk-6-jre-headless') }
    it { is_expected.to contain_exec('update-java-alternatives').with_command('update-java-alternatives --set java-6-openjdk-amd64 --jre-headless') }
    it { is_expected.to contain_file_line('java-home-environment').with_line('JAVA_HOME=/usr/lib/jvm/java-6-openjdk/jre/') }
  end

  context 'select random alternative for Debian Wheezy' do
    let(:facts) { { osfamily: 'Debian', operatingsystem: 'Debian', lsbdistcodename: 'wheezy', operatingsystemrelease: '7.1', architecture: 'amd64' } }
    let(:params) { { 'java_alternative' => 'bananafish' } }

    it { is_expected.to contain_package('java').with_name('openjdk-7-jdk') }
    it { is_expected.to contain_exec('update-java-alternatives').with_command('update-java-alternatives --set bananafish --jre') }
  end

  context 'select jdk for Ubuntu Vivid (15.04)' do
    let(:facts) { { osfamily: 'Debian', operatingsystem: 'Ubuntu', lsbdistcodename: 'vivid', operatingsystemrelease: '15.04', architecture: 'amd64' } }
    let(:params) { { 'distribution' => 'jdk' } }

    it { is_expected.to contain_package('java').with_name('openjdk-8-jdk') }
    it { is_expected.to contain_file_line('java-home-environment').with_line('JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-amd64/') }
  end

  context 'select jre for Ubuntu Vivid (15.04)' do
    let(:facts) { { osfamily: 'Debian', operatingsystem: 'Ubuntu', lsbdistcodename: 'vivid', operatingsystemrelease: '15.04', architecture: 'amd64' } }
    let(:params) { { 'distribution' => 'jre' } }

    it { is_expected.to contain_package('java').with_name('openjdk-8-jre-headless') }
    it { is_expected.to contain_file_line('java-home-environment').with_line('JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-amd64/') }
  end

  context 'select openjdk for Amazon Linux' do
    let(:facts) { { osfamily: 'RedHat', operatingsystem: 'Amazon', operatingsystemrelease: '3.4.43-43.43.amzn1.x86_64', architecture: 'x86_64' } }

    it { is_expected.to contain_package('java').with_name('java-1.7.0-openjdk-devel') }
    it { is_expected.to contain_file_line('java-home-environment').with_line('JAVA_HOME=/usr/lib/jvm/java-1.7.0-openjdk-x86_64/') }
  end

  context 'select passed value for Amazon Linux' do
    let(:facts) { { osfamily: 'RedHat', operatingsystem: 'Amazon', operatingsystemrelease: '5.3.4.43-43.43.amzn1.x86_64', architecture: 'x86_64' } }
    let(:params) { { 'distribution' => 'jre' } }

    it { is_expected.to contain_package('java').with_name('java-1.7.0-openjdk') }
  end

  context 'select openjdk for Oracle Linux' do
    let(:facts) { { osfamily: 'RedHat', operatingsystem: 'OracleLinux', operatingsystemrelease: '6.4', architecture: 'x86_64' } }

    it { is_expected.to contain_package('java').with_name('java-1.7.0-openjdk-devel') }
  end

  context 'select openjdk for Oracle Linux 6.2' do
    let(:facts) { { osfamily: 'RedHat', operatingsystem: 'OracleLinux', operatingsystemrelease: '6.2', architecture: 'x86_64' } }

    it { is_expected.to contain_package('java').with_name('java-1.6.0-openjdk-devel') }
  end

  context 'select passed value for Oracle Linux' do
    let(:facts) { { osfamily: 'RedHat', operatingsystem: 'OracleLinux', operatingsystemrelease: '6.3', architecture: 'x86_64' } }
    let(:params) { { 'distribution' => 'jre' } }

    it { is_expected.to contain_package('java').with_name('java-1.7.0-openjdk') }
  end

  context 'select passed value for Scientific Linux' do
    let(:facts) { { osfamily: 'RedHat', operatingsystem: 'Scientific', operatingsystemrelease: '6.4', architecture: 'x86_64' } }
    let(:params) { { 'distribution' => 'jre' } }

    it { is_expected.to contain_package('java').with_name('java-1.7.0-openjdk') }
    it { is_expected.to contain_file_line('java-home-environment').with_line('JAVA_HOME=/usr/lib/jvm/java-1.7.0/') }
  end

  context 'select passed value for Scientific Linux CERN (SLC)' do
    let(:facts) { { osfamily: 'RedHat', operatingsystem: 'SLC', operatingsystemrelease: '6.4', architecture: 'x86_64' } }
    let(:params) { { 'distribution' => 'jre' } }

    it { is_expected.to contain_package('java').with_name('java-1.7.0-openjdk') }
    it { is_expected.to contain_file_line('java-home-environment').with_line('JAVA_HOME=/usr/lib/jvm/java-1.7.0/') }
  end

  context 'select default for OpenSUSE 12.3' do
    let(:facts) { { osfamily: 'Suse', operatingsystem: 'OpenSUSE', operatingsystemrelease: '12.3', architecture: 'x86_64' } }

    it { is_expected.to contain_package('java').with_name('java-1_7_0-openjdk-devel') }
    it { is_expected.to contain_file_line('java-home-environment').with_line('JAVA_HOME=/usr/lib64/jvm/java-1.7.0-openjdk-1.7.0/') }
  end

  context 'select default for SLES 11.3' do
    let(:facts) { { osfamily: 'Suse', operatingsystem: 'SLES', operatingsystemrelease: '11.3', architecture: 'x86_64' } }

    it { is_expected.to contain_package('java').with_name('java-1_6_0-ibm-devel') }
    it { is_expected.to contain_file_line('java-home-environment').with_line('JAVA_HOME=/usr/lib64/jvm/java-1.6.0-ibm-1.6.0/') }
  end

  context 'select default for SLES 11.4' do
    let(:facts) { { osfamily: 'Suse', operatingsystem: 'SLES', operatingsystemrelease: '11.4', architecture: 'x86_64' } }

    it { is_expected.to contain_package('java').with_name('java-1_7_1-ibm-devel') }
    it { is_expected.to contain_file_line('java-home-environment').with_line('JAVA_HOME=/usr/lib64/jvm/java-1.7.0-ibm-1.7.0/') }
  end

  context 'select default for SLES 12.0' do
    let(:facts) { { osfamily: 'Suse', operatingsystem: 'SLES', operatingsystemrelease: '12.0', operatingsystemmajrelease: '12', architecture: 'x86_64' } }

    it { is_expected.to contain_package('java').with_name('java-1_7_0-openjdk-devel') }
    it { is_expected.to contain_file_line('java-home-environment').with_line('JAVA_HOME=/usr/lib64/jvm/java-1.7.0-openjdk-1.7.0/') }
  end

  context 'select default for SLES 12.1' do
    let(:facts) { { osfamily: 'Suse', operatingsystem: 'SLES', operatingsystemrelease: '12.1', operatingsystemmajrelease: '12', architecture: 'x86_64' } }

    it { is_expected.to contain_package('java').with_name('java-1_8_0-openjdk-devel') }
    it { is_expected.to contain_file_line('java-home-environment').with_line('JAVA_HOME=/usr/lib64/jvm/java-1.8.0-openjdk-1.8.0/') }
  end

  context 'select jdk for OpenBSD' do
    let(:facts) { { osfamily: 'OpenBSD', architecture: 'x86_64' } }

    it { is_expected.to contain_package('java').with_name('jdk') }
    it { is_expected.not_to contain_file_line('java-home-environment') }
  end

  context 'select jre for OpenBSD' do
    let(:facts) { { osfamily: 'OpenBSD', architecture: 'x86_64' } }
    let(:params) { { 'distribution' => 'jre' } }

    it { is_expected.to contain_package('java').with_name('jre') }
  end

  describe 'custom java package' do
    let(:facts) { { osfamily: 'Debian', operatingsystem: 'Debian', lsbdistcodename: 'jessie', operatingsystemrelease: '8.6', architecture: 'amd64' } }

    context 'all params provided' do
      let(:params) do
        {
          'distribution' => 'custom',
          'package'               => 'custom_jdk',
          'java_alternative'      => 'java-custom_jdk',
          'java_alternative_path' => '/opt/custom_jdk/bin/java',
          'java_home'             => '/opt/custom_jdk',
        }
      end

      it { is_expected.to contain_package('java').with_name('custom_jdk') }
      it { is_expected.to contain_file_line('java-home-environment').with_line('JAVA_HOME=/opt/custom_jdk') }
      it { is_expected.to contain_exec('update-java-alternatives').with_command('update-java-alternatives --set java-custom_jdk --jre') }
    end
    context 'missing parameters' do
      let(:params) do
        {
          'distribution' => 'custom',
          'package' => 'custom_jdk',
        }
      end

      it do
        expect { catalogue }.to raise_error Puppet::Error, %r{is not supported. Missing default values}
      end
    end
  end

  describe 'incompatible OSs' do
    [
      {
        # C14706
        osfamily: 'windows',
        operatingsystem: 'windows',
        operatingsystemrelease: '8.1',
      },
      {
        # C14707
        osfamily: 'Darwin',
        operatingsystem: 'Darwin',
        operatingsystemrelease: '13.3.0',
      },
      {
        # C14708
        osfamily: 'AIX',
        operatingsystem: 'AIX',
        operatingsystemrelease: '7100-02-00-000',
      },
      {
        # C14708
        osfamily: 'AIX',
        operatingsystem: 'AIX',
        operatingsystemrelease: '6100-07-04-1216',
      },
      {
        # C14708
        osfamily: 'AIX',
        operatingsystem: 'AIX',
        operatingsystemrelease: '5300-12-01-1016',
      },
    ].each do |facts|
      let(:facts) { facts }

      it "is_expected.to fail on #{facts[:operatingsystem]} #{facts[:operatingsystemrelease]}" do
        expect { catalogue }.to raise_error Puppet::Error, %r{unsupported platform}
      end
    end
  end
end
