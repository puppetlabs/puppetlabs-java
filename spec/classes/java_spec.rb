require 'spec_helper'

describe 'java', :type => :class do

  context 'select openjdk for Centos 5.8' do
    let(:facts) { {:osfamily => 'RedHat', :operatingsystem => 'Centos', :operatingsystemrelease => '5.8'} }
    it { should contain_package('java').with_name('java-1.6.0-openjdk-devel') }
  end

  context 'select openjdk for Centos 6.3' do
    let(:facts) { {:osfamily => 'RedHat', :operatingsystem => 'Centos', :operatingsystemrelease => '6.3'} }
    it { should contain_package('java').with_name('java-1.7.0-openjdk-devel') }
  end

  context 'select openjdk for Centos 6.2' do
    let(:facts) { {:osfamily => 'RedHat', :operatingsystem => 'Centos', :operatingsystemrelease => '6.2'} }
    it { should contain_package('java').with_name('java-1.6.0-openjdk-devel') }
    it { should_not contain_exec('update-java-alternatives') }
  end

  context 'select Oracle JRE with alternatives for Centos 6.3' do
    let(:facts) { {:osfamily => 'RedHat', :operatingsystem => 'Centos', :operatingsystemrelease => '6.3'} }
    let(:params) { { 'package' => 'jre', 'java_alternative' => '/usr/bin/java', 'java_alternative_path' => '/usr/java/jre1.7.0_67/bin/java'} }
    it { should contain_package('java').with_name('jre') }
    it { should contain_exec('create-java-alternatives').with_command('alternatives --install /usr/bin/java java /usr/java/jre1.7.0_67/bin/java 20000') }
    it { should contain_exec('update-java-alternatives').with_command('alternatives --set java /usr/java/jre1.7.0_67/bin/java') }
  end

  context 'select openjdk for Fedora 20' do
    let(:facts) { {:osfamily => 'RedHat', :operatingsystem => 'Fedora', :operatingsystemrelease => '20'} }
    it { should contain_package('java').with_name('java-1.7.0-openjdk-devel') }
  end

  context 'select openjdk for Fedora 21' do
    let(:facts) { {:osfamily => 'RedHat', :operatingsystem => 'Fedora', :operatingsystemrelease => '21'} }
    it { should contain_package('java').with_name('java-1.8.0-openjdk-devel') }
  end

  context 'select passed value for Fedora 20' do
    let(:facts) { {:osfamily => 'RedHat', :operatingsystem => 'Fedora', :operatingsystemrelease => '20'} }
    let(:params) { { 'distribution' => 'jre' } }
    it { should contain_package('java').with_name('java-1.7.0-openjdk') }
  end

  context 'select passed value for Fedora 21' do
    let(:facts) { {:osfamily => 'RedHat', :operatingsystem => 'Fedora', :operatingsystemrelease => '21'} }
    let(:params) { { 'distribution' => 'jre' } }
    it { should contain_package('java').with_name('java-1.8.0-openjdk') }
  end

  context 'select passed value for Centos 5.3' do
    let(:facts) { {:osfamily => 'RedHat', :operatingsystem => 'Centos', :operatingsystemrelease => '5.3'} }
    let(:params) { { 'package' => 'jdk' } }
    it { should contain_package('java').with_name('jdk') }
    it { should_not contain_exec('update-java-alternatives') }
  end

  context 'select default for Centos 5.3' do
    let(:facts) { {:osfamily => 'RedHat', :operatingsystem => 'Centos', :operatingsystemrelease => '5.3'} }
    it { should contain_package('java').with_name('java-1.6.0-openjdk-devel') }
    it { should_not contain_exec('update-java-alternatives') }
  end

  # =============================================================================================================================================
  # Debian: 'lenny', 'squeeze', Ubuntu: 'lucid', 'natty'
  # =============================================================================================================================================

  context 'select default for Debian Squeeze' do
    let(:facts) { {:osfamily => 'Debian', :operatingsystem => 'Debian', :lsbdistcodename => 'squeeze', :operatingsystemrelease => '6.0.5', :architecture => 'amd64',} }
    it { should contain_package('java').with_name('openjdk-6-jdk') }
    it { should contain_exec('update-java-alternatives').with_command('update-java-alternatives --set java-6-openjdk-amd64 --jre') }
  end

  context 'select jdk for Debian Squeeze' do
    let(:facts) { {:osfamily => 'Debian', :operatingsystem => 'Debian', :lsbdistcodename => 'squeeze', :operatingsystemrelease => '6.0.5', :architecture => 'amd64',} }
    let(:params) { { 'distribution' => 'jdk', } }
    it { should contain_package('java').with_name('openjdk-6-jdk') }
    it { should contain_exec('update-java-alternatives').with_command('update-java-alternatives --set java-6-openjdk-amd64 --jre') }
  end

  context 'select jre for Debian Squeeze' do
    let(:facts) { {:osfamily => 'Debian', :operatingsystem => 'Debian', :lsbdistcodename => 'squeeze', :operatingsystemrelease => '6.0.5', :architecture => 'amd64',} }
    let(:params) { { 'distribution' => 'jre', } }
    it { should contain_package('java').with_name('openjdk-6-jre-headless') }
    it { should contain_exec('update-java-alternatives').with_command('update-java-alternatives --set java-6-openjdk-amd64 --jre-headless') }
  end

  context 'select sun-jdk for Debian Squeeze' do
    let(:facts) { {:osfamily => 'Debian', :operatingsystem => 'Debian', :lsbdistcodename => 'squeeze', :operatingsystemrelease => '6.0.5', :architecture => 'amd64',} }
    let(:params) { { 'distribution' => 'sun-jdk', } }
    it { should contain_package('java').with_name('sun-java6-jdk') }
    it { should contain_exec('update-java-alternatives').with_command('update-java-alternatives --set java-6-sun --jre') }
  end

  context 'select sun-jre for Debian Squeeze' do
    let(:facts) { {:osfamily => 'Debian', :operatingsystem => 'Debian', :lsbdistcodename => 'squeeze', :operatingsystemrelease => '6.0.5', :architecture => 'amd64',} }
    let(:params) { { 'distribution' => 'sun-jre', } }
    it { should contain_package('java').with_name('sun-java6-jre') }
    it { should contain_exec('update-java-alternatives').with_command('update-java-alternatives --set java-6-sun --jre') }
  end

  # =============================================================================================================================================
  # Debian: 'wheezy', 'jessie', Ubuntu: 'precise','quantal','raring','saucy', 'trusty', 'utopic'
  # =============================================================================================================================================

  context 'select default for Debian Wheezy' do
    let(:facts) { {:osfamily => 'Debian', :operatingsystem => 'Debian', :lsbdistcodename => 'wheezy', :operatingsystemrelease => '7.1', :architecture => 'amd64',} }
    it { should contain_package('java').with_name('openjdk-7-jdk') }
    it { should contain_exec('update-java-alternatives').with_command('update-java-alternatives --set java-1.7.0-openjdk-amd64 --jre') }
  end

  context 'select random alternative for Debian Wheezy' do
    let(:facts) { {:osfamily => 'Debian', :operatingsystem => 'Debian', :lsbdistcodename => 'wheezy', :operatingsystemrelease => '7.1', :architecture => 'amd64',} }
    let(:params) { { 'java_alternative' => 'bananafish' } }
    it { should contain_package('java').with_name('openjdk-7-jdk') }
    it { should contain_exec('update-java-alternatives').with_command('update-java-alternatives --set bananafish --jre') }
  end

  context 'select default jdk for Debian Wheezy' do
    let(:facts) { {:osfamily => 'Debian', :operatingsystem => 'Debian', :lsbdistcodename => 'wheezy', :operatingsystemrelease => '7.1', :architecture => 'amd64',} }
    let(:params) { { 'distribution' => 'jdk' } }
    it { should contain_package('java').with_name('openjdk-7-jdk') }
    it { should contain_exec('update-java-alternatives').with_command('update-java-alternatives --set java-1.7.0-openjdk-amd64 --jre') }
  end

  context 'select default jre for Debian Wheezy' do
    let(:facts) { {:osfamily => 'Debian', :operatingsystem => 'Debian', :lsbdistcodename => 'wheezy', :operatingsystemrelease => '7.1', :architecture => 'amd64',} }
    let(:params) { { 'distribution' => 'jre' } }
    it { should contain_package('java').with_name('openjdk-7-jre-headless') }
    it { should contain_exec('update-java-alternatives').with_command('update-java-alternatives --set java-1.7.0-openjdk-amd64 --jre-headless') }
  end

  context 'select jdk7 for Debian Wheezy' do
    let(:facts) { {:osfamily => 'Debian', :operatingsystem => 'Debian', :lsbdistcodename => 'wheezy', :operatingsystemrelease => '7.1', :architecture => 'amd64',} }
    let(:params) { { 'distribution' => 'jdk' } }
    it { should contain_package('java').with_name('openjdk-7-jdk') }
    it { should contain_exec('update-java-alternatives').with_command('update-java-alternatives --set java-1.7.0-openjdk-amd64 --jre') }
  end

  context 'select jre7 for Debian Wheezy' do
    let(:facts) { {:osfamily => 'Debian', :operatingsystem => 'Debian', :lsbdistcodename => 'wheezy', :operatingsystemrelease => '7.1', :architecture => 'amd64',} }
    let(:params) { { 'distribution' => 'jre' } }
    it { should contain_package('java').with_name('openjdk-7-jre-headless') }
    it { should contain_exec('update-java-alternatives').with_command('update-java-alternatives --set java-1.7.0-openjdk-amd64 --jre-headless') }
  end

  context 'select jdk8 for Debian Wheezy' do
    let(:facts) { {:osfamily => 'Debian', :operatingsystem => 'Debian', :lsbdistcodename => 'wheezy', :operatingsystemrelease => '7.1', :architecture => 'amd64',} }
    let(:params) { { 'distribution' => 'jdk8' } }
    it { should contain_package('java').with_name('openjdk-8-jdk') }
    it { should contain_exec('update-java-alternatives').with_command('update-java-alternatives --set java-1.8.0-openjdk-amd64 --jre') }
  end

  context 'select jre8 for Debian Wheezy' do
    let(:facts) { {:osfamily => 'Debian', :operatingsystem => 'Debian', :lsbdistcodename => 'wheezy', :operatingsystemrelease => '7.1', :architecture => 'amd64',} }
    let(:params) { { 'distribution' => 'jre8' } }
    it { should contain_package('java').with_name('openjdk-8-jre-headless') }
    it { should contain_exec('update-java-alternatives').with_command('update-java-alternatives --set java-1.8.0-openjdk-amd64 --jre-headless') }
  end

  context 'select default oracle-jdk for Debian Wheezy' do
    let(:facts) { {:osfamily => 'Debian', :operatingsystem => 'Debian', :lsbdistcodename => 'wheezy', :operatingsystemrelease => '7.1', :architecture => 'amd64',} }
    let(:params) { { 'distribution' => 'oracle-jdk' } }
    it { should contain_package('java').with_name('oracle-j2sdk1.7') }
    it { should contain_exec('update-java-alternatives').with_command('update-java-alternatives --set j2sdk1.7-oracle --jre') }
  end

  context 'select default oracle-jre for Debian Wheezy' do
    let(:facts) { {:osfamily => 'Debian', :operatingsystem => 'Debian', :lsbdistcodename => 'wheezy', :operatingsystemrelease => '7.1', :architecture => 'amd64',} }
    let(:params) { { 'distribution' => 'oracle-jre' } }
    it { should contain_package('java').with_name('oracle-j2re1.7') }
    it { should contain_exec('update-java-alternatives').with_command('update-java-alternatives --set j2re1.7-oracle --jre') }
  end

  context 'select oracle-jdk7 for Debian Wheezy' do
    let(:facts) { {:osfamily => 'Debian', :operatingsystem => 'Debian', :lsbdistcodename => 'wheezy', :operatingsystemrelease => '7.1', :architecture => 'amd64',} }
    let(:params) { { 'distribution' => 'oracle-jdk7' } }
    it { should contain_package('java').with_name('oracle-j2sdk1.7') }
    it { should contain_exec('update-java-alternatives').with_command('update-java-alternatives --set j2sdk1.7-oracle --jre') }
  end

  context 'select oracle-jre7 for Debian Wheezy' do
    let(:facts) { {:osfamily => 'Debian', :operatingsystem => 'Debian', :lsbdistcodename => 'wheezy', :operatingsystemrelease => '7.1', :architecture => 'amd64',} }
    let(:params) { { 'distribution' => 'oracle-jre7' } }
    it { should contain_package('java').with_name('oracle-j2re1.7') }
    it { should contain_exec('update-java-alternatives').with_command('update-java-alternatives --set j2re1.7-oracle --jre') }
  end

  context 'select oracle-jdk8 for Debian Wheezy (i386)' do
    let(:facts) { {:osfamily => 'Debian', :operatingsystem => 'Debian', :lsbdistcodename => 'wheezy', :operatingsystemrelease => '7.1', :architecture => 'i386',} }
    let(:params) { { 'distribution' => 'oracle-jdk8' } }
    it { should contain_package('java').with_name('oracle-java8-jdk') }
    it { should contain_exec('update-java-alternatives').with_command('update-java-alternatives --set jdk-8-oracle-i586 --jre') }
  end

  context 'select oracle-jre8 for Debian Wheezy (i386)' do
    let(:facts) { {:osfamily => 'Debian', :operatingsystem => 'Debian', :lsbdistcodename => 'wheezy', :operatingsystemrelease => '7.1', :architecture => 'i386',} }
    let(:params) { { 'distribution' => 'oracle-jre8' } }
    it { should contain_package('java').with_name('oracle-java8-jre') }
    it { should contain_exec('update-java-alternatives').with_command('update-java-alternatives --set jre-8-oracle-i586 --jre') }
  end

  context 'select oracle-jdk8 for Debian Wheezy (amd64)' do
    let(:facts) { {:osfamily => 'Debian', :operatingsystem => 'Debian', :lsbdistcodename => 'wheezy', :operatingsystemrelease => '7.1', :architecture => 'amd64',} }
    let(:params) { { 'distribution' => 'oracle-jdk8' } }
    it { should contain_package('java').with_name('oracle-java8-jdk') }
    it { should contain_exec('update-java-alternatives').with_command('update-java-alternatives --set jdk-8-oracle-x64 --jre') }
  end

  context 'select oracle-jre8 for Debian Wheezy (amd64)' do
    let(:facts) { {:osfamily => 'Debian', :operatingsystem => 'Debian', :lsbdistcodename => 'wheezy', :operatingsystemrelease => '7.1', :architecture => 'amd64',} }
    let(:params) { { 'distribution' => 'oracle-jre8' } }
    it { should contain_package('java').with_name('oracle-java8-jre') }
    it { should contain_exec('update-java-alternatives').with_command('update-java-alternatives --set jre-8-oracle-x64 --jre') }
  end

  # =============================================================================================================================================
  # Ubuntu: 'vivid'
  # =============================================================================================================================================

  context 'select jdk for Ubuntu Vivid (15.04)' do
    let(:facts) { {:osfamily => 'Debian', :operatingsystem => 'Ubuntu', :lsbdistcodename => 'vivid', :operatingsystemrelease => '15.04', :architecture => 'amd64',} }
    let(:params) { { 'distribution' => 'jdk' } }
    it { should contain_package('java').with_name('openjdk-8-jdk') }
    it { should contain_exec('update-java-alternatives').with_command('update-java-alternatives --set java-1.8.0-openjdk-amd64 --jre') }
  end

  context 'select jre for Ubuntu Vivid (15.04)' do
    let(:facts) { {:osfamily => 'Debian', :operatingsystem => 'Ubuntu', :lsbdistcodename => 'vivid', :operatingsystemrelease => '15.04', :architecture => 'amd64',} }
    let(:params) { { 'distribution' => 'jre' } }
    it { should contain_package('java').with_name('openjdk-8-jre-headless') }
    it { should contain_exec('update-java-alternatives').with_command('update-java-alternatives --set java-1.8.0-openjdk-amd64 --jre-headless') }
  end

  # =============================================================================================================================================

  context 'select openjdk for Amazon Linux' do
    let(:facts) { {:osfamily => 'RedHat', :operatingsystem => 'Amazon', :operatingsystemrelease => '3.4.43-43.43.amzn1.x86_64'} }
    it { should contain_package('java').with_name('java-1.7.0-openjdk-devel') }
  end

  context 'select passed value for Amazon Linux' do
    let(:facts) { {:osfamily => 'RedHat', :operatingsystem => 'Amazon', :operatingsystemrelease => '5.3.4.43-43.43.amzn1.x86_64'} }
    let(:params) { { 'distribution' => 'jre' } }
    it { should contain_package('java').with_name('java-1.7.0-openjdk') }
  end

  context 'select openjdk for Oracle Linux' do
    let(:facts) { {:osfamily => 'RedHat', :operatingsystem => 'OracleLinux', :operatingsystemrelease => '6.4'} }
    it { should contain_package('java').with_name('java-1.7.0-openjdk-devel') }
  end

  context 'select openjdk for Oracle Linux 6.2' do
    let(:facts) { {:osfamily => 'RedHat', :operatingsystem => 'OracleLinux', :operatingsystemrelease => '6.2'} }
    it { should contain_package('java').with_name('java-1.6.0-openjdk-devel') }
  end

  context 'select passed value for Oracle Linux' do
    let(:facts) { {:osfamily => 'RedHat', :operatingsystem => 'OracleLinux', :operatingsystemrelease => '6.3'} }
    let(:params) { { 'distribution' => 'jre' } }
    it { should contain_package('java').with_name('java-1.7.0-openjdk') }
  end

  context 'select passed value for Scientific Linux' do
    let(:facts) { {:osfamily => 'RedHat', :operatingsystem => 'Scientific', :operatingsystemrelease => '6.4'} }
    let(:params) { { 'distribution' => 'jre' } }
    it { should contain_package('java').with_name('java-1.7.0-openjdk') }
  end

  context 'select default for OpenSUSE 12.3' do
    let(:facts) { {:osfamily => 'Suse', :operatingsystem => 'OpenSUSE', :operatingsystemrelease => '12.3'}}
    it { should contain_package('java').with_name('java-1_7_0-openjdk-devel')}
  end

  context 'select jdk for OpenBSD' do
    let(:facts) { {:osfamily => 'OpenBSD'} }
    it { should contain_package('java').with_name('jdk') }
  end

  context 'select jre for OpenBSD' do
    let(:facts) { {:osfamily => 'OpenBSD'} }
    let(:params) { { 'distribution' => 'jre' } }
    it { should contain_package('java').with_name('jre') }
  end

  describe 'incompatible OSs' do
    [
      {
        # C14706
        :osfamily               => 'windows',
        :operatingsystem        => 'windows',
        :operatingsystemrelease => '8.1',
      },
      {
        # C14707
        :osfamily               => 'Darwin',
        :operatingsystem        => 'Darwin',
        :operatingsystemrelease => '13.3.0',
      },
      {
        # C14708
        :osfamily               => 'AIX',
        :operatingsystem        => 'AIX',
        :operatingsystemrelease => '7100-02-00-000',
      },
      {
        # C14708
        :osfamily               => 'AIX',
        :operatingsystem        => 'AIX',
        :operatingsystemrelease => '6100-07-04-1216',
      },
      {
        # C14708
        :osfamily               => 'AIX',
        :operatingsystem        => 'AIX',
        :operatingsystemrelease => '5300-12-01-1016',
      },
    ].each do |facts|
      let(:facts) { facts }
      it "should fail on #{facts[:operatingsystem]} #{facts[:operatingsystemrelease]}" do
        expect { catalogue }.to raise_error Puppet::Error, /unsupported platform/
      end
    end
  end
end
