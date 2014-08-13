require 'spec_helper_acceptance'

#RedHat, CentOS, Scientific, Oracle prior to 5.0  : Sun Java JDK/JRE 1.6
#RedHat, CentOS, Scientific, Oracle 5.0 < x < 6.3 : OpenJDK Java JDK/JRE 1.6
#RedHat, CentOS, Scientific, Oracle after 6.3     : OpenJDK Java JDK/JRE 1.7
#Debian 5/6 & Ubuntu 10.04/11.04                  : OpenJDK Java JDK/JRE 1.6 or Sun Java JDK/JRE 1.6
#Debian 7/Jesse & Ubuntu 12.04 - 14.04            : OpenJDK Java JDK/JRE 1.7 or Oracle Java JDK/JRE 1.6
#Solaris (what versions?)                         : Java JDK/JRE 1.7
#OpenSuSE                                         : OpenJDK Java JDK/JRE 1.7
#SLES                                             : IBM Java JDK/JRE 1.6

# C14677
# C14678
# C14679
# C14680
# C14681
# C14682
# C14684
# C14690
# C14692
# C14696
# C14697
# C14703
# C14722
describe "installing java", :unless => UNSUPPORTED_PLATFORMS.include?(fact('osfamily')) do
  describe "jre" do
    it 'should install jre' do
      pp = <<-EOS
        class { 'java':
          distribution => 'jre',
        }
      EOS

      apply_manifest(pp, :expect_changes => true)
      apply_manifest(pp, :catch_changes => true)
    end
  end
  describe "jdk" do
    it 'should install jdk' do
      pp = <<-EOS
        class { 'java': }
      EOS

      apply_manifest(pp, :expect_changes => true)
      apply_manifest(pp, :catch_changes => true)
    end
  end
end
# C14686
describe 'sun', :if => (fact('operatingsystem') == 'Debian' and fact('operatingsystemrelease').match(/(5|6)/)) do
  before :all do
    pp = <<-EOS
      file_line { 'non-free source':
        path  => '/etc/apt/sources.list',
        match => "deb http://osmirror.delivery.puppetlabs.net/debian/ ${::lsbdistcodename} main",
        line  => "deb http://osmirror.delivery.puppetlabs.net/debian/ ${::lsbdistcodename} main non-free",
      }
    EOS
    apply_manifest(pp)
    shell('apt-get update')
    shell('echo "sun-java6-jdk shared/accepted-sun-dlj-v1-1 select true" | debconf-set-selections')
    shell('echo "sun-java6-jre shared/accepted-sun-dlj-v1-1 select true" | debconf-set-selections')
  end
  describe 'jre' do
    it 'should install sun-jre' do
      pp = <<-EOS
        class { 'java':
          distribution => 'sun-jre',
        }
      EOS

      apply_manifest(pp, :expect_changes => true)
      apply_manifest(pp, :catch_changes => true)
    end
  end
  describe 'jdk' do
    it 'should install sun-jdk' do
      pp = <<-EOS
        class { 'java':
          distribution => 'sun-jdk',
        }
      EOS

      apply_manifest(pp, :expect_changes => true)
      apply_manifest(pp, :catch_changes => true)
    end
  end
end

# C14704
describe 'oracle', :if => (fact('operatingsystem') == 'Debian' and fact('operatingsystemrelease').match(/^7/)) do
  # not supported
  # The package is not available from any sources, but if a customer
  # custom-builds the package using java-package and adds it to a local
  # repository, that is the intention of this version ability
  # C14704
  describe 'jre' do
    it 'should install oracle-jre' do
      pp = <<-EOS
        class { 'java':
          distribution => 'oracle-jre',
        }
      EOS

      apply_manifest(pp, :expect_failures => true)
    end
  end
  describe 'jdk' do
    it 'should install oracle-jdk' do
      pp = <<-EOS
        class { 'java':
          distribution => 'oracle-jdk',
        }
      EOS

      apply_manifest(pp, :expect_failures => true)
    end
  end
end

describe 'failure cases' do
  # C14711
  it 'should fail to install java with an incorrect version' do
    pp = <<-EOS
      class { 'java':
        version => '14.5',
      }
    EOS

    apply_manifest(pp, :expect_failures => true)
  end

  # C14712
  it 'should fail to install java with a blank version' do
    pp = <<-EOS
      class { 'java':
        version => '',
      }
    EOS

    apply_manifest(pp, :expect_failures => true)
  end

  # C14713
  it 'should fail to install java with an incorrect distribution' do
    pp = <<-EOS
      class { 'java':
        distribution => 'xyz',
      }
    EOS

    apply_manifest(pp, :expect_failures => true)
  end

  # C14714
  it 'should fail to install java with a blank distribution' do
    pp = <<-EOS
      class { 'java':
        distribution => '',
      }
    EOS

    apply_manifest(pp, :expect_failures => true)
  end

  # C14715
  it 'should fail to install java with an incorrect package' do
    pp = <<-EOS
      class { 'java':
        package => 'xyz',
      }
    EOS

    apply_manifest(pp, :expect_failures => true)
  end

  # C14716
  it 'should fail to install java with a blank package' do
    pp = <<-EOS
      class { 'java':
        package => '',
      }
    EOS

    apply_manifest(pp, :expect_failures => true)
  end

  context 'non-debian systems', :if => fact('osfamily') != 'Debian' do
    # C14717
    it 'should fail to install java with a blank package' do
      pp = <<-EOS
        class { 'java':
          package => '',
        }
      EOS

      apply_manifest(pp, :expect_failures => true)
    end
  end
end
