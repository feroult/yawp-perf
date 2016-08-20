#!/usr/bin/env bash

export MAVEN_VERSION=3.3.9
export HOME=/home/vagrant

# Locale
locale-gen en_US.UTF-8
echo "export LANG=\"en_US\"" >> $HOME/.bash_profile
echo "export LC_ALL=\$LANG.UTF-8" >> $HOME/.bash_profile
source $HOME/.bash_profile

# Update packages
apt-get -y update
apt-get -y upgrade

# Commons
apt-get install -y --fix-missing software-properties-common apt-transport-https
apt-get install -y curl wget
apt-get install -y git

# Linux Tools
apt-get install -y linux-tools-common linux-tools-generic linux-tools-lts-trusty

# Install Java
echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
add-apt-repository -y ppa:webupd8team/java && \
apt-get update && \
apt-get install -y oracle-java8-installer && \
rm -rf /var/lib/apt/lists/* && \
rm -rf /var/cache/oracle-jdk8-installer

# Define commonly used JAVA_HOME variable
echo "export JAVA_HOME=/usr/lib/jvm/java-8-oracle" >> $HOME/.bash_profile

# Install Maven
mkdir -p /usr/share/maven \
  && curl -fsSL http://apache.osuosl.org/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz \
    | tar -xzC /usr/share/maven --strip-components=1 \
  && ln -s /usr/share/maven/bin/mvn /usr/bin/mvn

echo "export MAVEN_HOME=/usr/share/maven" >> $HOME/.bash_profile

# NodeJS
curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
sudo apt-get install -y nodejs

# Build
sudo apt-get update && sudo apt-get install build-essential

# Others
mkdir opt && cd opt

# Perf Map
apt-get install cmake
git clone --depth=1 https://github.com/jrudolph/perf-map-agent
(cd perf-map-agent && cmake . && make)

# Flame Graphs
git clone --depth=1 https://github.com/brendangregg/FlameGraph

# End others
echo "export PATH=\$PATH:$HOME/repo/bin:$HOME/opt/perf-map-agent/bin:$HOME/opt/FlameGraph" >> $HOME/.bash_profile
cd ..

# Install Like Demo
git clone https://github.com/feroult/like-demo.git
(cd like-demo && mvn clean install)

# Adjust permissions
chown -R vagrant:vagrant .bash_profile
chown -R vagrant:vagrant opt
chown -R vagrant:vagrant .bash_profile
