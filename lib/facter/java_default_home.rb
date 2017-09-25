# Fact: java_default_home
#
# Purpose: get absolute path of java system home
#
# Resolution:
#   Uses `readlink` to resolve the path of `/usr/bin/java` then returns subsubdir
#
# Caveats:
#   Requires readlink
#
# Notes:
#   None
Facter.add(:java_default_home) do
  confine :kernel => [ 'Linux', 'OpenBSD' ]
  setcode do
    if Facter::Util::Resolution.which('readlink')
      java_bin = Facter::Util::Resolution.exec('readlink -e /usr/bin/java').to_s.strip
      if java_bin.empty?
        java_bin = Facter::Util::Resolution.exec('readlink -e /usr/local/bin/java').to_s.strip
        if java_bin.empty?
          java_bin = Facter::Util::Resolution.which('java').to_s.strip
          if java_bin.empty?
            nil
          end
        end
      end
      if java_bin =~ %r(/jre/)
        java_default_home = File.dirname(File.dirname(File.dirname(java_bin)))
      else
        java_default_home = File.dirname(File.dirname(java_bin))
      end
    end
  end
end
