# Fact: java_patch_level
#
# Purpose: get Java's patch level
#
# Resolution:
#   Uses java_version fact splits on the patch number (after _)
#
# Caveats:
#   none
#
# Notes:
#   None
Facter.add(:java_patch_level) do
  setcode do
    java_version = Facter.value(:java_version)
    if java_version.nil?
      "JAVA_NOT_INSTALLED"
    else
      java_patch_level = java_version.strip.split('_')[1]
    end
  end
end