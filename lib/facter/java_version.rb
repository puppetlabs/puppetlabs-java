# Fact: java_version
#
# Purpose: store java versions in the config DB
#
# Resolution:
#   Tests for presence of java, returns nil if not present
#   returns output of "java -version" and splits on \n + '"'
#
# Caveats:
#   none
#
# Notes:
#   None
Facter.add(:java_version) do
  setcode do
    java_version = Facter::Util::Resolution.exec("java -version 2>&1")
    java_version = java_version.to_s.lines.first.strip.split(/version/)[1].gsub(/"/, "").strip
  end
end