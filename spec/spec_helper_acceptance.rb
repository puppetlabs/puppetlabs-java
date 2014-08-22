require 'beaker-rspec'

UNSUPPORTED_PLATFORMS = [ "Darwin", "windows" ]

unless ENV["RS_PROVISION"] == "no" or ENV["BEAKER_provision"] == "no"
  if hosts.first.is_pe?
    install_pe
  else
    install_puppet({ :version        => "3.6.2",
                     :facter_version => "2.1.0",
                     :hiera_version  => "1.3.4",
                     :default_action => "gem_install" })
    hosts.each do |h|
      on h, "/bin/mkdir -p #{h["puppetpath"]}"
      on h, "/bin/echo '' > #{h["hieraconf"]}"
    end
  end
  hosts.each do |host|
    if host["platform"] =~ /solaris/
      on host, "echo 'export PATH=/opt/puppet/bin:/var/ruby/1.8/gem_home/bin:${PATH}' >> ~/.bashrc"
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
