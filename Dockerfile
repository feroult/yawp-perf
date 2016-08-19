FROM ubuntu:14.04

ENV MAVEN_VERSION 3.3.9
ENV DEBIAN_FRONTEND noninteractive

# Update packages
RUN apt-get -y update
RUN apt-get -y upgrade

# Commons
RUN apt-get install -y --fix-missing software-properties-common apt-transport-https
RUN apt-get install -y curl wget
RUN apt-get install -y git

# Linux Tools
RUN apt-get install -y linux-tools-common linux-tools-generic linux-tools-lts-trusty

# Install Java
RUN \
  echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
  add-apt-repository -y ppa:webupd8team/java && \
  apt-get update && \
  apt-get install -y oracle-java8-installer && \
  rm -rf /var/lib/apt/lists/* && \
  rm -rf /var/cache/oracle-jdk8-installer

# Define commonly used JAVA_HOME variable
ENV JAVA_HOME /usr/lib/jvm/java-8-oracle

# Install Maven
RUN mkdir -p /usr/share/maven \
  && curl -fsSL http://apache.osuosl.org/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz \
    | tar -xzC /usr/share/maven --strip-components=1 \
  && ln -s /usr/share/maven/bin/mvn /usr/bin/mvn

ENV MAVEN_HOME /usr/share/maven

WORKDIR /perf

# Install Like Demo
RUN \
  git clone https://github.com/feroult/like-demo.git
#  cd like-demo
#  mvn clean install

# Default Command
CMD ["bash"]
