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
      if Facter::Core::Execution.execute('/usr/libexec/java_home --failfast', { on_fail: false })
        version = Facter::Core::Execution.execute('java -Xmx12m -version 2>&1').lines.find { |line| line.include?('version') }
      end
    elsif Facter::Core::Execution.which('java')
      version = Facter::Core::Execution.execute('java -Xmx12m -version 2>&1').lines.find { |line| line.include?('version') }
    end
    version[%r{"(.*?)"}, 1] if version
  end
end
