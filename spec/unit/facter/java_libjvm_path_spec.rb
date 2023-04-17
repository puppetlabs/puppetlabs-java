# frozen_string_literal: true

require 'spec_helper'

describe 'java_libjvm_path' do
  let(:java_default_home) { '/usr/lib/jvm/java-8-openjdk-amd64' }

  before(:each) do
    Facter.clear
    allow(Facter.fact(:kernel)).to receive(:value).and_return('Linux')
    allow(Facter.fact(:java_default_home)).to receive(:value).and_return(java_default_home)
  end

  context 'when libjvm exists' do
    it do
      allow(Facter.fact(:java_major_version)).to receive(:value).and_return(8)
      allow(Dir).to receive(:glob).with("#{java_default_home}/jre/lib/**/libjvm.so").and_return(['/usr/lib/jvm/java-8-openjdk-amd64/jre/lib/amd64/server/libjvm.so'])
      expect(Facter.value(:java_libjvm_path)).to eql '/usr/lib/jvm/java-8-openjdk-amd64/jre/lib/amd64/server'
    end
  end

  context 'when libjvm does not exist' do
    it do
      allow(Dir).to receive(:glob).with("#{java_default_home}/lib/**/libjvm.so").and_return([])
      expect(Facter.value(:java_libjvm_path)).to be_nil
    end
  end
end
