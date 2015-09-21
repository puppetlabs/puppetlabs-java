require 'spec_helper'

describe 'java::oracle', :type => :define do

  context 'select Oracle Java SE 6 JDK on RedHat family, 64-bit' do
    let(:facts) { {:kernel => 'Linux', :osfamily => 'RedHat', :architecture => 'x86_64'} }
    let(:params) { {:ensure => 'present', :version => '6', :javaSE => 'jdk'} }
    let :title do 'jdk6' end
    it { should contain_exec('Install Oracle JavaSE jdk 6').with_command('sh /tmp/jdk-6u45-linux-x64-rpm.bin -x; rpm --force -iv sun*.rpm; rpm --force -iv jdk*.rpm') }
  end

  context 'select Oracle Java SE 7 JDK on RedHat family, 64-bit' do
    let(:facts) { {:kernel => 'Linux', :osfamily => 'RedHat', :architecture => 'x86_64'} }
    let(:params) { {:ensure => 'present', :version => '7', :javaSE => 'jdk'} }
    let :title do 'jdk7' end
    it { should contain_exec('Install Oracle JavaSE jdk 7').with_command('rpm --force -iv /tmp/jdk-7u80-linux-x64.rpm') }
  end

  context 'select Oracle Java SE 8 JDK on RedHat family, 64-bit' do
    let(:facts) { {:kernel => 'Linux', :osfamily => 'RedHat', :architecture => 'x86_64'} }
    let(:params) { {:ensure => 'present', :version => '8', :javaSE => 'jdk'} }
    let :title do 'jdk8' end
    it { should contain_exec('Install Oracle JavaSE jdk 8').with_command('rpm --force -iv /tmp/jdk-8u51-linux-x64.rpm') }
  end

  context 'select Oracle Java SE 6 JRE on RedHat family, 64-bit' do
    let(:facts) { {:kernel => 'Linux', :osfamily => 'RedHat', :architecture => 'x86_64'} }
    let(:params) { {:ensure => 'present', :version => '6', :javaSE => 'jre'} }
    let :title do 'jdk6' end
    it { should contain_exec('Install Oracle JavaSE jre 6').with_command('sh /tmp/jre-6u45-linux-x64-rpm.bin -x; rpm --force -iv sun*.rpm; rpm --force -iv jre*.rpm') }
  end

  context 'select Oracle Java SE 7 JRE on RedHat family, 64-bit' do
    let(:facts) { {:kernel => 'Linux', :osfamily => 'RedHat', :architecture => 'x86_64'} }
    let(:params) { {:ensure => 'present', :version => '7', :javaSE => 'jre'} }
    let :title do 'jdk7' end
    it { should contain_exec('Install Oracle JavaSE jre 7').with_command('rpm --force -iv /tmp/jre-7u80-linux-x64.rpm') }
  end

  context 'select Oracle Java SE 8 JRE on RedHat family, 64-bit' do
    let(:facts) { {:kernel => 'Linux', :osfamily => 'RedHat', :architecture => 'x86_64'} }
    let(:params) { {:ensure => 'present', :version => '8', :javaSE => 'jre'} }
    let :title do 'jdk8' end
    it { should contain_exec('Install Oracle JavaSE jre 8').with_command('rpm --force -iv /tmp/jre-8u51-linux-x64.rpm') }
  end

  # same tests for i386
  context 'select Oracle Java SE 6 JDK on RedHat family, 32-bit' do
    let(:facts) { {:kernel => 'Linux', :osfamily => 'RedHat', :architecture => 'i386'} }
    let(:params) { {:ensure => 'present', :version => '6', :javaSE => 'jdk'} }
    let :title do 'jdk6' end
    it { should contain_exec('Install Oracle JavaSE jdk 6').with_command('sh /tmp/jdk-6u45-linux-i586-rpm.bin -x; rpm --force -iv sun*.rpm; rpm --force -iv jdk*.rpm') }
  end

  context 'select Oracle Java SE 7 JDK on RedHat family, 32-bit' do
    let(:facts) { {:kernel => 'Linux', :osfamily => 'RedHat', :architecture => 'i386'} }
    let(:params) { {:ensure => 'present', :version => '7', :javaSE => 'jdk'} }
    let :title do 'jdk7' end
    it { should contain_exec('Install Oracle JavaSE jdk 7').with_command('rpm --force -iv /tmp/jdk-7u80-linux-i586.rpm') }
  end

  context 'select Oracle Java SE 8 JDK on RedHat family, 32-bit' do
    let(:facts) { {:kernel => 'Linux', :osfamily => 'RedHat', :architecture => 'i386'} }
    let(:params) { {:ensure => 'present', :version => '8', :javaSE => 'jdk'} }
    let :title do 'jdk8' end
    it { should contain_exec('Install Oracle JavaSE jdk 8').with_command('rpm --force -iv /tmp/jdk-8u51-linux-i586.rpm') }
  end

  context 'select Oracle Java SE 6 JRE on RedHat family, 32-bit' do
    let(:facts) { {:kernel => 'Linux', :osfamily => 'RedHat', :architecture => 'i386'} }
    let(:params) { {:ensure => 'present', :version => '6', :javaSE => 'jre'} }
    let :title do 'jdk6' end
    it { should contain_exec('Install Oracle JavaSE jre 6').with_command('sh /tmp/jre-6u45-linux-i586-rpm.bin -x; rpm --force -iv sun*.rpm; rpm --force -iv jre*.rpm') }
  end

  context 'select Oracle Java SE 7 JRE on RedHat family, 32-bit' do
    let(:facts) { {:kernel => 'Linux', :osfamily => 'RedHat', :architecture => 'i386'} }
    let(:params) { {:ensure => 'present', :version => '7', :javaSE => 'jre'} }
    let :title do 'jdk7' end
    it { should contain_exec('Install Oracle JavaSE jre 7').with_command('rpm --force -iv /tmp/jre-7u80-linux-i586.rpm') }
  end

  context 'select Oracle Java SE 8 JRE on RedHat family, 32-bit' do
    let(:facts) { {:kernel => 'Linux', :osfamily => 'RedHat', :architecture => 'i386'} }
    let(:params) { {:ensure => 'present', :version => '8', :javaSE => 'jre'} }
    let :title do 'jdk8' end
    it { should contain_exec('Install Oracle JavaSE jre 8').with_command('rpm --force -iv /tmp/jre-8u51-linux-i586.rpm') }
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
      let :title do 'jdk' end
      it "should fail on #{facts[:operatingsystem]} #{facts[:operatingsystemrelease]}" do
        expect { catalogue }.to raise_error Puppet::Error, /unsupported platform/
      end
    end
  end
end
