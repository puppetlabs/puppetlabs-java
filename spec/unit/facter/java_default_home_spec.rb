require "spec_helper"

def unlink_and_delete(filename)
    if File.symlink?(filename)
      File.unlink(filename)
    end
    if File.exist?(filename)
      File.delete(filename)
    end
end

describe Facter::Util::Fact do

  describe "java_default_home" do
    before(:each) {
      Facter.clear
      Facter.fact(:kernel).stubs(:value).returns('Linux')
    }

    context 'returns java home path when java found in PATH' do
      context "when java is in /usr/lib/jvm/java-7-openjdk-amd64/jre/bin/java" do
        it do
          unlink_and_delete('./java_test')
          File.symlink('/usr/lib/jvm/java-7-openjdk-amd64/jre/bin/java', './java_test')
          Facter::Util::Resolution.expects(:which).with("java").returns("./java_test")
          File.expects(:realpath).with('./java_test').returns('/usr/lib/jvm/java-7-openjdk-amd64/jre/bin/java')
          expect(Facter.value(:java_default_home)).to eql '/usr/lib/jvm/java-7-openjdk-amd64'
          unlink_and_delete('./java_test')
        end
      end

      context "when java is in /usr/lib/jvm/oracle-java8-jre-amd64/bin/java" do
        it do
          unlink_and_delete('./java_test')
          File.symlink('/usr/lib/jvm/oracle-java8-jre-amd64/bin/java', './java_test')
          Facter::Util::Resolution.expects(:which).with("java").returns("./java_test")
          File.expects(:realpath).with('./java_test').returns('/usr/lib/jvm/oracle-java8-jre-amd64/bin/java')
          expect(Facter.value(:java_default_home)).to eql '/usr/lib/jvm/oracle-java8-jre-amd64'
          unlink_and_delete('./java_test')
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
