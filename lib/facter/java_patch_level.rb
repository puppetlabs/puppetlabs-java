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
  java_patch_level = nil
  setcode do
    java_version = Facter.value(:java_version)
    unless java_version.nil?
      # First part > 1, use . as seperator to get patch level
      java_version_test = java_version.strip.split('.')[0]
      if java_version_test.to_i > 1
        java_patch_level = java_version.strip.split('.')[2]
      else
        java_patch_level = java_version.strip.split('_')[1]
      end
    end

  end
  java_patch_level
end
