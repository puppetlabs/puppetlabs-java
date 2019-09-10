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
      java_version_first_number = java_version.strip.split('.')[0]
      java_patch_level = if java_version_first_number.to_i > 1
                           java_version.strip.split('.')[2]
                         else
                           java_version.strip.split('_')[1]
                         end
    end
  end
  java_patch_level
end
