require 'beaker-rspec'

UNSUPPORTED_PLATFORMS = [ "Darwin", "windows" ]

unless ENV["RS_PROVISION"] == "no" or ENV["BEAKER_provision"] == "no"
  # This will install the latest available package on el and deb based
  # systems fail on windows and osx, and install via gem on other *nixes
  foss_opts = { :default_action => 'gem_install' }

  if default.is_pe?; then install_pe; else install_puppet( foss_opts ); end

  hosts.each do |host|
    if host["platform"] =~ /solaris/
      on host, "echo 'export PATH=/opt/puppet/bin:/var/ruby/1.8/gem_home/bin:${PATH}' >> ~/.bashrc"
    end
    unless host.is_pe?
      on host, "/bin/mkdir -p #{host["puppetpath"]}"
      on host, "/bin/echo '' > #{host["hieraconf"]}"
    end
    on host, "mkdir -p #{host["distmoduledir"]}"
    on host, "puppet module install puppetlabs-stdlib", :acceptable_exit_codes => [0,1]
    # For test support
    on host, "puppet module install puppetlabs-apt", :acceptable_exit_codes => [0,1]
  end
end

RSpec.configure do |c|
  # Project root
  proj_root = File.expand_path(File.join(File.dirname(__FILE__), ".."))

  # Readable test descriptions
  c.formatter = :documentation

  # Configure all nodes in nodeset
  c.before :suite do
    # Install module
    puppet_module_install(:source => proj_root, :module_name => "java")
  end
end
