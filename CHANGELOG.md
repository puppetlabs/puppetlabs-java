<!-- markdownlint-disable MD024 -->
# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/) and this project adheres to [Semantic Versioning](http://semver.org).

## [v10.1.2](https://github.com/puppetlabs/puppetlabs-java/tree/v10.1.2) - 2023-07-27

[Full Changelog](https://github.com/puppetlabs/puppetlabs-java/compare/v10.1.1...v10.1.2)

### Fixed

- (CAT-1250)-updating legacy SUSE repo name [#570](https://github.com/puppetlabs/puppetlabs-java/pull/570) ([praj1001](https://github.com/praj1001))

## [v10.1.1](https://github.com/puppetlabs/puppetlabs-java/tree/v10.1.1) - 2023-07-03

[Full Changelog](https://github.com/puppetlabs/puppetlabs-java/compare/v10.1.0...v10.1.1)

## [v10.1.0](https://github.com/puppetlabs/puppetlabs-java/tree/v10.1.0) - 2023-06-20

[Full Changelog](https://github.com/puppetlabs/puppetlabs-java/compare/v10.0.0...v10.1.0)

### Added

- puppet/archive: Allow 7.x [#559](https://github.com/puppetlabs/puppetlabs-java/pull/559) ([bastelfreak](https://github.com/bastelfreak))
- pdksync - (MAINT) - Allow Stdlib 9.x [#557](https://github.com/puppetlabs/puppetlabs-java/pull/557) ([LukasAud](https://github.com/LukasAud))

## [v10.0.0](https://github.com/puppetlabs/puppetlabs-java/tree/v10.0.0) - 2023-04-17

[Full Changelog](https://github.com/puppetlabs/puppetlabs-java/compare/v9.0.1...v10.0.0)

### Added

- (CONT-356) Syntax update [#543](https://github.com/puppetlabs/puppetlabs-java/pull/543) ([LukasAud](https://github.com/LukasAud))

### Changed
- (CONT-784) Add Support for Puppet 8 / Drop Support for Puppet 6 [#548](https://github.com/puppetlabs/puppetlabs-java/pull/548) ([david22swan](https://github.com/david22swan))

### Fixed

- Fix shell_escape of unless command [#550](https://github.com/puppetlabs/puppetlabs-java/pull/550) ([traylenator](https://github.com/traylenator))

## [v9.0.1](https://github.com/puppetlabs/puppetlabs-java/tree/v9.0.1) - 2022-11-29

[Full Changelog](https://github.com/puppetlabs/puppetlabs-java/compare/v9.0.0...v9.0.1)

### Fixed

- 538-unresolved-fact-fix [#540](https://github.com/puppetlabs/puppetlabs-java/pull/540) ([jordanbreen28](https://github.com/jordanbreen28))
- Unresolved fact fix [#539](https://github.com/puppetlabs/puppetlabs-java/pull/539) ([jordanbreen28](https://github.com/jordanbreen28))

## [v9.0.0](https://github.com/puppetlabs/puppetlabs-java/tree/v9.0.0) - 2022-11-23

[Full Changelog](https://github.com/puppetlabs/puppetlabs-java/compare/v8.2.0...v9.0.0)

### Changed
- (CONT-263) Update minimum required puppet version [#535](https://github.com/puppetlabs/puppetlabs-java/pull/535) ([LukasAud](https://github.com/LukasAud))

### Fixed

- Update package naming to differentiate between minor versions [#534](https://github.com/puppetlabs/puppetlabs-java/pull/534) ([sd-z](https://github.com/sd-z))
- (CONT-173) - Updating deprecated facter instances [#531](https://github.com/puppetlabs/puppetlabs-java/pull/531) ([jordanbreen28](https://github.com/jordanbreen28))
- pdksync - (CONT-189) Remove support for RedHat6 / OracleLinux6 / Scientific6 [#530](https://github.com/puppetlabs/puppetlabs-java/pull/530) ([david22swan](https://github.com/david22swan))
- pdksync - (CONT-130) - Dropping Support for Debian 9 [#527](https://github.com/puppetlabs/puppetlabs-java/pull/527) ([jordanbreen28](https://github.com/jordanbreen28))
- Hardening manifests [#525](https://github.com/puppetlabs/puppetlabs-java/pull/525) ([LukasAud](https://github.com/LukasAud))

## [v8.2.0](https://github.com/puppetlabs/puppetlabs-java/tree/v8.2.0) - 2022-08-09

[Full Changelog](https://github.com/puppetlabs/puppetlabs-java/compare/v8.1.0...v8.2.0)

### Added

- pdksync - (GH-cat-11) Certify Support for Ubuntu 22.04 [#522](https://github.com/puppetlabs/puppetlabs-java/pull/522) ([david22swan](https://github.com/david22swan))
- Make ubuntu 22.04 also default to openjdk-11 [#519](https://github.com/puppetlabs/puppetlabs-java/pull/519) ([rswarts](https://github.com/rswarts))
- pdksync - (GH-cat-12) Add Support for Redhat 9 [#518](https://github.com/puppetlabs/puppetlabs-java/pull/518) ([david22swan](https://github.com/david22swan))

## [v8.1.0](https://github.com/puppetlabs/puppetlabs-java/tree/v8.1.0) - 2022-05-30

[Full Changelog](https://github.com/puppetlabs/puppetlabs-java/compare/v8.0.0...v8.1.0)

### Added

- feat: added support for aarch64 architecture download [#516](https://github.com/puppetlabs/puppetlabs-java/pull/516) ([0Rick0](https://github.com/0Rick0))

## [v8.0.0](https://github.com/puppetlabs/puppetlabs-java/tree/v8.0.0) - 2022-04-05

[Full Changelog](https://github.com/puppetlabs/puppetlabs-java/compare/v7.3.0...v8.0.0)

### Added

- (MODULES-11234) Support Adoptium Temurin [#502](https://github.com/puppetlabs/puppetlabs-java/pull/502) ([dploeger](https://github.com/dploeger))

### Changed
- (GH-C&T-7) Remove code specific to unsupported OSs [#507](https://github.com/puppetlabs/puppetlabs-java/pull/507) ([david22swan](https://github.com/david22swan))

### Fixed

- pdksync - (GH-iac-334) Remove Support for Ubuntu 14.04/16.04 [#505](https://github.com/puppetlabs/puppetlabs-java/pull/505) ([david22swan](https://github.com/david22swan))
- pdksync - (IAC-1787) Remove Support for CentOS 6 [#503](https://github.com/puppetlabs/puppetlabs-java/pull/503) ([david22swan](https://github.com/david22swan))

## [v7.3.0](https://github.com/puppetlabs/puppetlabs-java/tree/v7.3.0) - 2021-10-11

[Full Changelog](https://github.com/puppetlabs/puppetlabs-java/compare/v7.2.0...v7.3.0)

### Added

- pdksync - (IAC-1753) - Add Support for AlmaLinux 8 [#500](https://github.com/puppetlabs/puppetlabs-java/pull/500) ([david22swan](https://github.com/david22swan))
- pdksync - (IAC-1751) - Add Support for Rocky 8 [#499](https://github.com/puppetlabs/puppetlabs-java/pull/499) ([david22swan](https://github.com/david22swan))

### Fixed

- pdksync - (IAC-1598) - Remove Support for Debian 8 [#498](https://github.com/puppetlabs/puppetlabs-java/pull/498) ([david22swan](https://github.com/david22swan))

## [v7.2.0](https://github.com/puppetlabs/puppetlabs-java/tree/v7.2.0) - 2021-09-20

[Full Changelog](https://github.com/puppetlabs/puppetlabs-java/compare/v7.1.1...v7.2.0)

### Added

- Enabling Rocky Linux for Install [#488](https://github.com/puppetlabs/puppetlabs-java/pull/488) ([pmjensen](https://github.com/pmjensen))

### Fixed

- Allow archive 6.x [#493](https://github.com/puppetlabs/puppetlabs-java/pull/493) ([smortex](https://github.com/smortex))

## [v7.1.1](https://github.com/puppetlabs/puppetlabs-java/tree/v7.1.1) - 2021-08-26

[Full Changelog](https://github.com/puppetlabs/puppetlabs-java/compare/v7.1.0...v7.1.1)

### Fixed

- (IAC-1741) Allow stdlib v8.0.0 [#491](https://github.com/puppetlabs/puppetlabs-java/pull/491) ([david22swan](https://github.com/david22swan))

## [v7.1.0](https://github.com/puppetlabs/puppetlabs-java/tree/v7.1.0) - 2021-08-12

[Full Changelog](https://github.com/puppetlabs/puppetlabs-java/compare/v7.0.2...v7.1.0)

### Added

- pdksync - (IAC-1709) - Add Support for Debian 11 [#489](https://github.com/puppetlabs/puppetlabs-java/pull/489) ([david22swan](https://github.com/david22swan))

## [v7.0.2](https://github.com/puppetlabs/puppetlabs-java/tree/v7.0.2) - 2021-04-26

[Full Changelog](https://github.com/puppetlabs/puppetlabs-java/compare/v7.0.1...v7.0.2)

### Fixed

- add url parameter for adoptopenjdk [#473](https://github.com/puppetlabs/puppetlabs-java/pull/473) ([cbobinec](https://github.com/cbobinec))

## [v7.0.1](https://github.com/puppetlabs/puppetlabs-java/tree/v7.0.1) - 2021-04-19

[Full Changelog](https://github.com/puppetlabs/puppetlabs-java/compare/v7.0.0...v7.0.1)

### Fixed

- allow v5.x of puppet/archive [#476](https://github.com/puppetlabs/puppetlabs-java/pull/476) ([bastelfreak](https://github.com/bastelfreak))

## [v7.0.0](https://github.com/puppetlabs/puppetlabs-java/tree/v7.0.0) - 2021-03-01

[Full Changelog](https://github.com/puppetlabs/puppetlabs-java/compare/v6.5.0...v7.0.0)

### Changed
- pdksync - Remove Puppet 5 from testing and bump minimal version to 6.0.0 [#463](https://github.com/puppetlabs/puppetlabs-java/pull/463) ([carabasdaniel](https://github.com/carabasdaniel))

### Fixed

- (MODULES-10935) - Switch legacy operatingsystem fact to modern kernel one [#461](https://github.com/puppetlabs/puppetlabs-java/pull/461) ([rjd1](https://github.com/rjd1))

## [v6.5.0](https://github.com/puppetlabs/puppetlabs-java/tree/v6.5.0) - 2020-12-16

[Full Changelog](https://github.com/puppetlabs/puppetlabs-java/compare/v6.4.0...v6.5.0)

### Added

- pdksync - (feat) Add support for Puppet 7 [#454](https://github.com/puppetlabs/puppetlabs-java/pull/454) ([daianamezdrea](https://github.com/daianamezdrea))

## [v6.4.0](https://github.com/puppetlabs/puppetlabs-java/tree/v6.4.0) - 2020-11-09

[Full Changelog](https://github.com/puppetlabs/puppetlabs-java/compare/v6.3.0...v6.4.0)

### Added

- Add support for SAP Java (sapjvm / sapmachine) [#433](https://github.com/puppetlabs/puppetlabs-java/pull/433) ([timdeluxe](https://github.com/timdeluxe))

### Fixed

- [IAC-1208] - Add the good links for solving the 404 error and exclude sles [#443](https://github.com/puppetlabs/puppetlabs-java/pull/443) ([daianamezdrea](https://github.com/daianamezdrea))
- (IAC-993) - Removal of inappropriate terminology [#439](https://github.com/puppetlabs/puppetlabs-java/pull/439) ([david22swan](https://github.com/david22swan))

## [v6.3.0](https://github.com/puppetlabs/puppetlabs-java/tree/v6.3.0) - 2020-05-28

[Full Changelog](https://github.com/puppetlabs/puppetlabs-java/compare/v6.2.0...v6.3.0)

### Added

- (MODULES-10681) Add option to manage symlink to java::adopt [#429](https://github.com/puppetlabs/puppetlabs-java/pull/429) ([fraenki](https://github.com/fraenki))
- (IAC-746) - Add ubuntu 20.04 support [#428](https://github.com/puppetlabs/puppetlabs-java/pull/428) ([david22swan](https://github.com/david22swan))

## [v6.2.0](https://github.com/puppetlabs/puppetlabs-java/tree/v6.2.0) - 2020-02-19

[Full Changelog](https://github.com/puppetlabs/puppetlabs-java/compare/v6.1.0...v6.2.0)

### Added

- Support AdoptOpenJDK [#370](https://github.com/puppetlabs/puppetlabs-java/pull/370) ([timdeluxe](https://github.com/timdeluxe))

### Fixed

- Replace legacy facts by modern facts [#406](https://github.com/puppetlabs/puppetlabs-java/pull/406) ([hdeheer](https://github.com/hdeheer))

## [v6.1.0](https://github.com/puppetlabs/puppetlabs-java/tree/v6.1.0) - 2020-02-03

[Full Changelog](https://github.com/puppetlabs/puppetlabs-java/compare/v6.0.0...v6.1.0)

## [v6.0.0](https://github.com/puppetlabs/puppetlabs-java/tree/v6.0.0) - 2019-11-11

[Full Changelog](https://github.com/puppetlabs/puppetlabs-java/compare/v5.0.1...v6.0.0)

### Added

- (FM-8676) Add CentOS 8 to supported OS list [#399](https://github.com/puppetlabs/puppetlabs-java/pull/399) ([david22swan](https://github.com/david22swan))
- FM-8403 - add support Debain10 [#387](https://github.com/puppetlabs/puppetlabs-java/pull/387) ([lionce](https://github.com/lionce))

### Fixed

- we need to check if java_default_home has a value before we attempt t… [#391](https://github.com/puppetlabs/puppetlabs-java/pull/391) ([robmbrooks](https://github.com/robmbrooks))
- Add support for java 11, the default in debian buster 10 [#386](https://github.com/puppetlabs/puppetlabs-java/pull/386) ([jhooyberghs](https://github.com/jhooyberghs))

## [v5.0.1](https://github.com/puppetlabs/puppetlabs-java/tree/v5.0.1) - 2019-08-05

[Full Changelog](https://github.com/puppetlabs/puppetlabs-java/compare/v5.0.0...v5.0.1)

## [v5.0.0](https://github.com/puppetlabs/puppetlabs-java/tree/v5.0.0) - 2019-08-05

[Full Changelog](https://github.com/puppetlabs/puppetlabs-java/compare/v4.1.0...v5.0.0)

### Added

- (FM-8223) converted to use litmus [#376](https://github.com/puppetlabs/puppetlabs-java/pull/376) ([tphoney](https://github.com/tphoney))
- Add buster support, default to 11 [#369](https://github.com/puppetlabs/puppetlabs-java/pull/369) ([mhjacks](https://github.com/mhjacks))
- Add support for debian buster [#364](https://github.com/puppetlabs/puppetlabs-java/pull/364) ([TomRitserveldt](https://github.com/TomRitserveldt))

### Changed
- [FM-8320] Remove Oracle download [#372](https://github.com/puppetlabs/puppetlabs-java/pull/372) ([carabasdaniel](https://github.com/carabasdaniel))

### Fixed

- (FM-8343) use release numbers not lsbdistcodename [#375](https://github.com/puppetlabs/puppetlabs-java/pull/375) ([tphoney](https://github.com/tphoney))
- Revert "Add support for debian buster" [#374](https://github.com/puppetlabs/puppetlabs-java/pull/374) ([tphoney](https://github.com/tphoney))

## [v4.1.0](https://github.com/puppetlabs/puppetlabs-java/tree/v4.1.0) - 2019-05-29

[Full Changelog](https://github.com/puppetlabs/puppetlabs-java/compare/v4.0.0...v4.1.0)

### Added

- (FM-8028) Add RedHat 8 support [#363](https://github.com/puppetlabs/puppetlabs-java/pull/363) ([eimlav](https://github.com/eimlav))

## [v4.0.0](https://github.com/puppetlabs/puppetlabs-java/tree/v4.0.0) - 2019-05-20

[Full Changelog](https://github.com/puppetlabs/puppetlabs-java/compare/3.3.0...v4.0.0)

### Added

- (FM-7921) - Implement Puppet Strings [#353](https://github.com/puppetlabs/puppetlabs-java/pull/353) ([david22swan](https://github.com/david22swan))
- Update default version & java 8 version from 8u192 to 8u201 [#347](https://github.com/puppetlabs/puppetlabs-java/pull/347) ([valentinsavenko](https://github.com/valentinsavenko))
- Add ability to override basedir and package type for oracle java [#345](https://github.com/puppetlabs/puppetlabs-java/pull/345) ([fraenki](https://github.com/fraenki))
- MODULES-8613: Add option to set a custom JCE download URL [#344](https://github.com/puppetlabs/puppetlabs-java/pull/344) ([HielkeJ](https://github.com/HielkeJ))

### Changed
- pdksync - (MODULES-8444) - Raise lower Puppet bound [#356](https://github.com/puppetlabs/puppetlabs-java/pull/356) ([david22swan](https://github.com/david22swan))

### Fixed

- MODULES-8698: Fix $install_path on CentOS with tar.gz package type [#349](https://github.com/puppetlabs/puppetlabs-java/pull/349) ([fraenki](https://github.com/fraenki))

## [3.3.0](https://github.com/puppetlabs/puppetlabs-java/tree/3.3.0) - 2019-01-18

[Full Changelog](https://github.com/puppetlabs/puppetlabs-java/compare/3.2.0...3.3.0)

### Added

- (MODULES-8234) - Add SLES 15 support [#336](https://github.com/puppetlabs/puppetlabs-java/pull/336) ([eimlav](https://github.com/eimlav))
- (MODULES-8234) - Upgrade Oracle Java version to 8u192 [#334](https://github.com/puppetlabs/puppetlabs-java/pull/334) ([eimlav](https://github.com/eimlav))
- Support for installing JCE. Fixes MODULES-1681 [#326](https://github.com/puppetlabs/puppetlabs-java/pull/326) ([dploeger](https://github.com/dploeger))
- MODULES-8044: upgrade Oracle Java 8 to 181, make it the default release [#314](https://github.com/puppetlabs/puppetlabs-java/pull/314) ([ojongerius](https://github.com/ojongerius))

### Fixed

- pdksync - (FM-7655) Fix rubygems-update for ruby < 2.3 [#338](https://github.com/puppetlabs/puppetlabs-java/pull/338) ([tphoney](https://github.com/tphoney))
- (FM-7520) - Removing Solaris from the support matrix [#335](https://github.com/puppetlabs/puppetlabs-java/pull/335) ([pmcmaw](https://github.com/pmcmaw))
- Optimized code for making java::oracle atomic. Fixes MODULES-8085 [#330](https://github.com/puppetlabs/puppetlabs-java/pull/330) ([dploeger](https://github.com/dploeger))
- Fix OpenJDK paths on Debian based OS with ARM [#329](https://github.com/puppetlabs/puppetlabs-java/pull/329) ([mmoll](https://github.com/mmoll))
- (MODULES-7050) - Fix OracleJDK reinstalling on Puppet runs [#323](https://github.com/puppetlabs/puppetlabs-java/pull/323) ([eimlav](https://github.com/eimlav))
- (MODULES-8025) Switch default for Ubuntu 18.04 to 11 [#322](https://github.com/puppetlabs/puppetlabs-java/pull/322) ([baurmatt](https://github.com/baurmatt))
- MODULES-7819 fix set JAVA_HOME environments on FreeBSD platform [#315](https://github.com/puppetlabs/puppetlabs-java/pull/315) ([olevole](https://github.com/olevole))

## [3.2.0](https://github.com/puppetlabs/puppetlabs-java/tree/3.2.0) - 2018-09-27

[Full Changelog](https://github.com/puppetlabs/puppetlabs-java/compare/3.1.0...3.2.0)

### Added

- pdksync - (MODULES-6805) metadata.json shows support for puppet 6 [#317](https://github.com/puppetlabs/puppetlabs-java/pull/317) ([tphoney](https://github.com/tphoney))

## [3.1.0](https://github.com/puppetlabs/puppetlabs-java/tree/3.1.0) - 2018-09-10

[Full Changelog](https://github.com/puppetlabs/puppetlabs-java/compare/3.0.0...3.1.0)

### Added

- pdksync - (MODULES-7705) - Bumping stdlib dependency from < 5.0.0 to < 6.0.0 [#310](https://github.com/puppetlabs/puppetlabs-java/pull/310) ([pmcmaw](https://github.com/pmcmaw))

## [3.0.0](https://github.com/puppetlabs/puppetlabs-java/tree/3.0.0) - 2018-08-14

[Full Changelog](https://github.com/puppetlabs/puppetlabs-java/compare/2.4.0...3.0.0)

### Added

- (MODULES-7561) - Addition of support for Ubuntu 18.04 to java [#299](https://github.com/puppetlabs/puppetlabs-java/pull/299) ([david22swan](https://github.com/david22swan))

### Changed
- [FM-6963] Removal of unsupported OS from java [#295](https://github.com/puppetlabs/puppetlabs-java/pull/295) ([david22swan](https://github.com/david22swan))

### Fixed

- Remove ensure_resource to avoid potential conflict [#287](https://github.com/puppetlabs/puppetlabs-java/pull/287) ([sevencastles](https://github.com/sevencastles))

## [2.4.0](https://github.com/puppetlabs/puppetlabs-java/tree/2.4.0) - 2018-01-23

[Full Changelog](https://github.com/puppetlabs/puppetlabs-java/compare/2.3.0...2.4.0)

### Fixed

- Fixes java_home for SLES 11.4 and relevant tests [#283](https://github.com/puppetlabs/puppetlabs-java/pull/283) ([HelenCampbell](https://github.com/HelenCampbell))
- FM-6634 rubocop fixes [#279](https://github.com/puppetlabs/puppetlabs-java/pull/279) ([tphoney](https://github.com/tphoney))

## [2.3.0](https://github.com/puppetlabs/puppetlabs-java/tree/2.3.0) - 2017-12-01

[Full Changelog](https://github.com/puppetlabs/puppetlabs-java/compare/2.2.0...2.3.0)

### Added

- Add support for Ubuntu artful (17.10) and bionic (18.04 to be) [#270](https://github.com/puppetlabs/puppetlabs-java/pull/270) ([mhjacks](https://github.com/mhjacks))

## [2.2.0](https://github.com/puppetlabs/puppetlabs-java/tree/2.2.0) - 2017-11-20

[Full Changelog](https://github.com/puppetlabs/puppetlabs-java/compare/2.1.1...2.2.0)

### Added

- Adding support for Ubuntu [#243](https://github.com/puppetlabs/puppetlabs-java/pull/243) ([elmobp](https://github.com/elmobp))

### Fixed

- Realpath test fix [#265](https://github.com/puppetlabs/puppetlabs-java/pull/265) ([willmeek](https://github.com/willmeek))

## [2.1.1](https://github.com/puppetlabs/puppetlabs-java/tree/2.1.1) - 2017-11-09

[Full Changelog](https://github.com/puppetlabs/puppetlabs-java/compare/2.1.0...2.1.1)

### Added

- Add support for CloudLinux [#251](https://github.com/puppetlabs/puppetlabs-java/pull/251) ([shaleenx](https://github.com/shaleenx))

### Fixed

- (FACT-1754) search for matching line with java version [#257](https://github.com/puppetlabs/puppetlabs-java/pull/257) ([shuebnersr](https://github.com/shuebnersr))

## [2.1.0](https://github.com/puppetlabs/puppetlabs-java/tree/2.1.0) - 2017-06-22

[Full Changelog](https://github.com/puppetlabs/puppetlabs-java/compare/2.0.0...2.1.0)

### Added

- Add support for Archlinux [#244](https://github.com/puppetlabs/puppetlabs-java/pull/244) ([kBite](https://github.com/kBite))

### Fixed

- replace validate_* calls with datatypes & minor fixes [#223](https://github.com/puppetlabs/puppetlabs-java/pull/223) ([bastelfreak](https://github.com/bastelfreak))
- Bugfix/modules 4368 java default home invalid fact [#215](https://github.com/puppetlabs/puppetlabs-java/pull/215) ([vStone](https://github.com/vStone))

## [2.0.0](https://github.com/puppetlabs/puppetlabs-java/tree/2.0.0) - 2017-05-30

[Full Changelog](https://github.com/puppetlabs/puppetlabs-java/compare/1.6.0...2.0.0)

### Added

- add 'Amazon Linux AMI' supports [#209](https://github.com/puppetlabs/puppetlabs-java/pull/209) ([hedzr](https://github.com/hedzr))
- Add proxy options for Oracle Java [#188](https://github.com/puppetlabs/puppetlabs-java/pull/188) ([edestecd](https://github.com/edestecd))
- Add support for Oracle Linux [#185](https://github.com/puppetlabs/puppetlabs-java/pull/185) ([LightAxe](https://github.com/LightAxe))
- (MODULES-2971) Add java_home to all operating systems [#184](https://github.com/puppetlabs/puppetlabs-java/pull/184) ([ntpttr](https://github.com/ntpttr))

### Fixed

- (MODULES-4751) Fix Archive Order of Operations [#225](https://github.com/puppetlabs/puppetlabs-java/pull/225) ([bstopp](https://github.com/bstopp))
- Fix naming of version_major and version_minor parameters [#196](https://github.com/puppetlabs/puppetlabs-java/pull/196) ([gzurowski](https://github.com/gzurowski))

## [1.6.0](https://github.com/puppetlabs/puppetlabs-java/tree/1.6.0) - 2016-06-13

[Full Changelog](https://github.com/puppetlabs/puppetlabs-java/compare/1.5.0...1.6.0)

### Fixed

- Fix typo in documentation for class oracle [#170](https://github.com/puppetlabs/puppetlabs-java/pull/170) ([gerhardsam](https://github.com/gerhardsam))
- Fix up rspec deprecation warnings. [#166](https://github.com/puppetlabs/puppetlabs-java/pull/166) ([alexharv074](https://github.com/alexharv074))

## [1.5.0](https://github.com/puppetlabs/puppetlabs-java/tree/1.5.0) - 2016-04-12

[Full Changelog](https://github.com/puppetlabs/puppetlabs-java/compare/1.4.3...1.5.0)

### Added

- Add Ubuntu 16.04 [#164](https://github.com/puppetlabs/puppetlabs-java/pull/164) ([s12v](https://github.com/s12v))
- Add an example for installing java 8 [#162](https://github.com/puppetlabs/puppetlabs-java/pull/162) ([npwalker](https://github.com/npwalker))
- Add support for official Oracle Java SE jdk and jre packages for CentOS [#159](https://github.com/puppetlabs/puppetlabs-java/pull/159) ([mmarseglia](https://github.com/mmarseglia))
- (MODULES-2928) Adds FreeBSD Support [#153](https://github.com/puppetlabs/puppetlabs-java/pull/153) ([petems](https://github.com/petems))
- Added support for oracle-j2re1.8 and oracle-j2sdk1.8 [#152](https://github.com/puppetlabs/puppetlabs-java/pull/152) ([thomasodus](https://github.com/thomasodus))

### Fixed

- Fix typo in README.markdown [#165](https://github.com/puppetlabs/puppetlabs-java/pull/165) ([alexharv074](https://github.com/alexharv074))

## [1.4.3](https://github.com/puppetlabs/puppetlabs-java/tree/1.4.3) - 2015-12-07

[Full Changelog](https://github.com/puppetlabs/puppetlabs-java/compare/1.4.2...1.4.3)

### Added

- Add support for Ubuntu 15.10 [#147](https://github.com/puppetlabs/puppetlabs-java/pull/147) ([oc243](https://github.com/oc243))
- add two facts: libjvm and java executable paths [#117](https://github.com/puppetlabs/puppetlabs-java/pull/117) ([faxm0dem](https://github.com/faxm0dem))

## [1.4.2](https://github.com/puppetlabs/puppetlabs-java/tree/1.4.2) - 2015-10-07

[Full Changelog](https://github.com/puppetlabs/puppetlabs-java/compare/1.4.1...1.4.2)

### Fixed

- Fix rspec deprecation warnings. .should -> expect().to [#141](https://github.com/puppetlabs/puppetlabs-java/pull/141) ([vStone](https://github.com/vStone))

## [1.4.1](https://github.com/puppetlabs/puppetlabs-java/tree/1.4.1) - 2015-07-15

[Full Changelog](https://github.com/puppetlabs/puppetlabs-java/compare/1.4.0...1.4.1)

### Added

- Add OEL operatingsystem to java::params [#135](https://github.com/puppetlabs/puppetlabs-java/pull/135) ([zreichert](https://github.com/zreichert))

## [1.4.0](https://github.com/puppetlabs/puppetlabs-java/tree/1.4.0) - 2015-07-08

[Full Changelog](https://github.com/puppetlabs/puppetlabs-java/compare/1.3.0...1.4.0)

### Added

- (MODULES-2068) add fedora to metadata.json operatingsystem_support list [#129](https://github.com/puppetlabs/puppetlabs-java/pull/129) ([bmjen](https://github.com/bmjen))
- Add helper to install puppet/pe/puppet-agent [#123](https://github.com/puppetlabs/puppetlabs-java/pull/123) ([hunner](https://github.com/hunner))
- (BKR-147) add Gemfile setting for BEAKER_VERSION for puppet... [#115](https://github.com/puppetlabs/puppetlabs-java/pull/115) ([anodelman](https://github.com/anodelman))

### Fixed

- Fix incorrect metadata [#133](https://github.com/puppetlabs/puppetlabs-java/pull/133) ([hunner](https://github.com/hunner))
- (MODULES-2095) fixes create-java-alternatives command [#128](https://github.com/puppetlabs/puppetlabs-java/pull/128) ([bmjen](https://github.com/bmjen))
- Fix Fedora 21+ package name [#104](https://github.com/puppetlabs/puppetlabs-java/pull/104) ([cottsay](https://github.com/cottsay))

## [1.3.0](https://github.com/puppetlabs/puppetlabs-java/tree/1.3.0) - 2015-01-20

[Full Changelog](https://github.com/puppetlabs/puppetlabs-java/compare/1.2.0...1.3.0)

### Added

- FM-1523: Added module summary to metadata.json [#90](https://github.com/puppetlabs/puppetlabs-java/pull/90) ([jbondpdx](https://github.com/jbondpdx))
- Add Java alternatives for RHEL based distros. [#89](https://github.com/puppetlabs/puppetlabs-java/pull/89) ([rdrgmnzs](https://github.com/rdrgmnzs))
- add utopic support [#88](https://github.com/puppetlabs/puppetlabs-java/pull/88) ([pherjung](https://github.com/pherjung))
- Revert "Add alternative support for RedHat" [#87](https://github.com/puppetlabs/puppetlabs-java/pull/87) ([underscorgan](https://github.com/underscorgan))
- cosmetic change to add missing space to bullet point in markdown so it r... [#80](https://github.com/puppetlabs/puppetlabs-java/pull/80) ([stevenalexander](https://github.com/stevenalexander))
- Add alternative support for RedHat [#61](https://github.com/puppetlabs/puppetlabs-java/pull/61) ([rdrgmnzs](https://github.com/rdrgmnzs))

### Fixed

- Acceptance test fix for wheezy [#96](https://github.com/puppetlabs/puppetlabs-java/pull/96) ([underscorgan](https://github.com/underscorgan))
- Test fix for RHEL with alternatives [#94](https://github.com/puppetlabs/puppetlabs-java/pull/94) ([underscorgan](https://github.com/underscorgan))

## [1.2.0](https://github.com/puppetlabs/puppetlabs-java/tree/1.2.0) - 2014-11-10

[Full Changelog](https://github.com/puppetlabs/puppetlabs-java/compare/1.1.2...1.2.0)

### Fixed

- Fix syntax [#77](https://github.com/puppetlabs/puppetlabs-java/pull/77) ([PierreR](https://github.com/PierreR))

## [1.1.2](https://github.com/puppetlabs/puppetlabs-java/tree/1.1.2) - 2014-09-03

[Full Changelog](https://github.com/puppetlabs/puppetlabs-java/compare/1.1.1...1.1.2)

### Added

- Add metadata.json and remove Modulefile [#65](https://github.com/puppetlabs/puppetlabs-java/pull/65) ([hunner](https://github.com/hunner))

## [1.1.1](https://github.com/puppetlabs/puppetlabs-java/tree/1.1.1) - 2014-05-02

[Full Changelog](https://github.com/puppetlabs/puppetlabs-java/compare/1.1.0...1.1.1)

### Added

- Added jessie as a supported realese [#56](https://github.com/puppetlabs/puppetlabs-java/pull/56) ([3h4x](https://github.com/3h4x))
- add support for ubuntu 14.04 trusty [#55](https://github.com/puppetlabs/puppetlabs-java/pull/55) ([atta](https://github.com/atta))

## [1.1.0](https://github.com/puppetlabs/puppetlabs-java/tree/1.1.0) - 2014-01-06

[Full Changelog](https://github.com/puppetlabs/puppetlabs-java/compare/1.0.1...1.1.0)

### Added

- Add $java_home variable [#47](https://github.com/puppetlabs/puppetlabs-java/pull/47) ([liwo](https://github.com/liwo))
- adding support for ubuntu saucy [#46](https://github.com/puppetlabs/puppetlabs-java/pull/46) ([ppouliot](https://github.com/ppouliot))

### Fixed

- Fix travis script. [#36](https://github.com/puppetlabs/puppetlabs-java/pull/36) ([apenney](https://github.com/apenney))

## [1.0.1](https://github.com/puppetlabs/puppetlabs-java/tree/1.0.1) - 2013-08-01

[Full Changelog](https://github.com/puppetlabs/puppetlabs-java/compare/0.3.0...1.0.1)

### Added

- Add a .travis.yml file. [#32](https://github.com/puppetlabs/puppetlabs-java/pull/32) ([apenney](https://github.com/apenney))
- Added support for Amazon linux [#29](https://github.com/puppetlabs/puppetlabs-java/pull/29) ([actionjack](https://github.com/actionjack))
- Add support for OpenSUSE [#27](https://github.com/puppetlabs/puppetlabs-java/pull/27) ([rombert](https://github.com/rombert))
- add support for Ubuntu quantal and raring [#26](https://github.com/puppetlabs/puppetlabs-java/pull/26) ([nrvale0](https://github.com/nrvale0))

### Fixed

- Fixes for centos versions [#24](https://github.com/puppetlabs/puppetlabs-java/pull/24) ([garethr](https://github.com/garethr))

## [0.3.0](https://github.com/puppetlabs/puppetlabs-java/tree/0.3.0) - 2013-05-08

[Full Changelog](https://github.com/puppetlabs/puppetlabs-java/compare/0.2.0...0.3.0)

### Added

- Add special case for fedora operating systems, where java is installable... [#23](https://github.com/puppetlabs/puppetlabs-java/pull/23) ([haus](https://github.com/haus))
- Adding java::package_suse class [#22](https://github.com/puppetlabs/puppetlabs-java/pull/22) ([sschneid](https://github.com/sschneid))

## [0.2.0](https://github.com/puppetlabs/puppetlabs-java/tree/0.2.0) - 2012-11-15

[Full Changelog](https://github.com/puppetlabs/puppetlabs-java/compare/v0.1.5...0.2.0)

### Added

- Add Solaris support [#18](https://github.com/puppetlabs/puppetlabs-java/pull/18) ([sschneid](https://github.com/sschneid))
- 4 - Add license file. [#8](https://github.com/puppetlabs/puppetlabs-java/pull/8) ([kbarber](https://github.com/kbarber))

## [v0.1.5](https://github.com/puppetlabs/puppetlabs-java/tree/v0.1.5) - 2011-06-16

[Full Changelog](https://github.com/puppetlabs/puppetlabs-java/compare/0.1.4...v0.1.5)

## [0.1.4](https://github.com/puppetlabs/puppetlabs-java/tree/0.1.4) - 2011-06-02

[Full Changelog](https://github.com/puppetlabs/puppetlabs-java/compare/0.1.3...0.1.4)

## [0.1.3](https://github.com/puppetlabs/puppetlabs-java/tree/0.1.3) - 2011-05-28

[Full Changelog](https://github.com/puppetlabs/puppetlabs-java/compare/0.1.2...0.1.3)

## [0.1.2](https://github.com/puppetlabs/puppetlabs-java/tree/0.1.2) - 2011-05-26

[Full Changelog](https://github.com/puppetlabs/puppetlabs-java/compare/0.1.1...0.1.2)

## [0.1.1](https://github.com/puppetlabs/puppetlabs-java/tree/0.1.1) - 2011-05-25

[Full Changelog](https://github.com/puppetlabs/puppetlabs-java/compare/0.0.1...0.1.1)

### Added

- Add basic validation to class parameters [#1](https://github.com/puppetlabs/puppetlabs-java/pull/1) ([jeffmccune](https://github.com/jeffmccune))

## [0.0.1](https://github.com/puppetlabs/puppetlabs-java/tree/0.0.1) - 2011-05-24

[Full Changelog](https://github.com/puppetlabs/puppetlabs-java/compare/55a2ab8b198b806e2e8866fc46165e4a10ebe043...0.0.1)
