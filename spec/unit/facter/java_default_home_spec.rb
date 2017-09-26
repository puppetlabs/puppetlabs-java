require "spec_helper"

describe Facter::Util::Fact do

  describe "java_default_home" do
    before(:each) {
      Facter.clear
      Facter.fact(:kernel).stubs(:value).returns('Linux')
    }

    context 'returns java home path when java found in PATH' do
      context "when java is in /usr/lib/jvm/java-7-openjdk-amd64/jre/bin/java" do

        it do
          File.delete('./java') if File.exist?('./java')
          File.symlink('/usr/lib/jvm/java-7-openjdk-amd64/jre/bin/java', './java')
          Facter::Util::Resolution.expects(:which).with("java").returns("./java")
          expect(File.readlink('./java')).to eq('/usr/lib/jvm/java-7-openjdk-amd64/jre/bin/java')
          expect(Facter.value(:java_default_home)).to eql '/usr/lib/jvm/java-7-openjdk-amd64'
          File.delete('./java') if File.exist?('./java')
        end
      end

      context "when java is in /usr/lib/jvm/oracle-java8-jre-amd64/bin/java" do

        it do
          File.delete('./java') if File.exist?('./java')
          File.symlink('/usr/lib/jvm/oracle-java8-jre-amd64/bin/java', './java')
          Facter::Util::Resolution.expects(:which).with("java").returns("./java")
          expect(File.readlink('./java')).to eq('/usr/lib/jvm/oracle-java8-jre-amd64/bin/java')
          expect(Facter.value(:java_default_home)).to eql '/usr/lib/jvm/oracle-java8-jre-amd64'
          File.delete('./java') if File.exist?('./java')
        end
      end
    end

    context 'returns nil when java not present' do
      it do
        Facter::Util::Resolution.stubs(:exec)
        Facter::Util::Resolution.expects(:which).with("java").at_least(1).returns(false)
        expect(Facter.value(:java_default_home)).to be_nil
      end
    end
  end
end
