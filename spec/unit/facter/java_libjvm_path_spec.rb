require 'spec_helper'

describe 'java_libjvm_path' do
  before(:each) do
    Facter.clear
    allow(Facter.fact(:kernel)).to receive(:value).once.and_return('Linux')
    java_default_home = '/usr/lib/jvm/java-8-openjdk-amd64'
    allow(Facter.fact(:java_default_home)).to receive(:value).once.and_return(java_default_home)
    allow(Dir).to receive(:glob).with("#{java_default_home}/jre/lib/**/libjvm.so").and_return(['/usr/lib/jvm/java-8-openjdk-amd64/jre/lib/amd64/server/libjvm.so'])
  end

  context 'when on Linux, return libjvm path' do
    it do
      expect(Facter.value(:java_libjvm_path)).to eql '/usr/lib/jvm/java-8-openjdk-amd64/jre/lib/amd64/server'
    end
  end
end
