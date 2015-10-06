require 'puppetlabs_spec_helper/module_spec_helper'

RSpec.configure do |c|
  # declare an exclusion filter for the tests using with_env on facter 1.6, as the function is not available on 1.6
  c.filter_run_excluding :with_env => true if Facter.version =~ /^1\.6\./
end
