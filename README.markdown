# Java #

Manage the Java runtime for use with other application software.

Currently this simply deploys the package on Enterprise Linux based systems and Debian based systems.

Tested on:

 * Centos 5.6
 * Ubuntu 10.04 Lucid

# RedHat Support #

The Java runtime this module is designed to configure are the RPM's provided by Oracle and obtained by extracting them from the "bin" installers.

For example:

    ./jdk-6u25-linux-x64-rpm.bin -x

Please download the installer from:

 * [Java Downloads](http://www.oracle.com/technetwork/java/javase/downloads/jdk-6u25-download-346242.html)

# Ubuntu Support #

## Lucid ##

You need to have the partner repository enabled in order to install the Sun JDK or JRE.

    aptitude install python-software-properties
    sudo add-apt-repository "deb http://archive.canonical.com/ lucid partner"
    aptitude update

