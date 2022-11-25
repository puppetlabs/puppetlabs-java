# frozen_string_literal: true

# Fact: java_version
#
# Purpose: get full java version string
#
# Resolution:
#   Tests for presence of java, returns nil if not present
#   returns output of "java -version" and splits on '"'
#
# Caveats:
#   none
#
# Notes:
#   None
Facter.add(:java_version) do
  setcode do
    if ['darwin'].include? Facter.value(:kernel).downcase
      return nil unless Facter::Core::Execution.execute('/usr/libexec/java_home --failfast', { on_fail: false })
    else
      return nil unless Facter::Core::Execution.which('java')
    end
    version = Facter::Core::Execution.execute('java -Xmx12m -version 2>&1').lines.find { |line| line.include?('version') }
    version[%r{\"(.*?)\"}, 1] if version
  end
end
