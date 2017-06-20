# Fact: java_default_home
#
# Purpose: get absolute path of java system home
#
# Resolution:
#   Uses File.realpath to resolve the path of `/usr/bin/java` then returns subsubdir
#
# Notes:
#   None
Facter.add(:java_default_home) do
  confine :kernel => 'Linux'
  setcode do
    if File.exist?('/usr/bin/java')
      java_bin = File.realpath("/usr/bin/java")
      java_default_home = File.dirname(File.dirname(File.dirname(java_bin)))
      if java_bin =~ %r(/jre/)
        java_default_home = File.dirname(File.dirname(File.dirname(java_bin)))
      else
        java_default_home = File.dirname(File.dirname(java_bin))
      end
    else
      java_default_home = ''
    end
  end
end
