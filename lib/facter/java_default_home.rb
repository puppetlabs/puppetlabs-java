# Fact: java_default_home
#
# Purpose: get absolute path of java system home
#
# Resolution:
#   Find the real java binary, and return the subsubdir
#
# Caveats:
#   java binary has to be found in $PATH
#
# Notes:
#   None
Facter.add(:java_default_home) do
  confine :kernel => [ 'Linux', 'OpenBSD' ]
  setcode do
    java_bin = Facter::Util::Resolution.which('java').to_s.strip
    if java_bin.empty?
      nil
    else
      # We might have found a symlink instead of the real binary
      java_bin = File.realpath(java_bin)
      if java_bin =~ %r(/jre/)
        java_default_home = File.dirname(File.dirname(File.dirname(java_bin)))
      else
        java_default_home = File.dirname(File.dirname(java_bin))
      end
    end
  end
end
