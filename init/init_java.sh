#!/bin/bash

<<COMMENT

  Summary:
  The following code will install Java and the build tools
    Gradle and Maven. The versions are output at the end of
    the install as confirmation.

  Note: Gradle is installed with snap and assumes that snap
    is already installed.

  Instructions:
    - https://linuxize.com/post/how-to-install-apache-maven-on-ubuntu-20-04/
    - https://askubuntu.com/questions/1052131/how-to-set-maven-home-path-on-ubuntu-as-user

  Maven example:
    mvn -B archetype:generate   -DarchetypeGroupId=org.apache.maven.archetypes   -DgroupId=com.mycompany.app   -DartifactId=my-app -X

COMMENT


echo "Update for open JDK 18"

# Java install
sudo apt install -y \
    openjdk-18-jdk \
    openjdk-18-jre

# Maven install: For Java 18 Maven must be latest version
export MAVEN_VERSION=3.8.5
sudo wget https://downloads.apache.org/maven/maven-3/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz -P /tmp
sudo tar xf /tmp/apache-maven-*.tar.gz -C /opt
sudo ln -s /opt/apache-maven-${MAVEN_VERSION} /opt/maven

# Gradle install
sudo snap install gradle --classic


# Add JAVA_HOME
echo "export JAVA_HOME=/usr/lib/jvm/java-18-openjdk-amd64" >> ~/.bashrc
source ~/.bashrc
echo 'export PATH=${JAVA_HOME}/bin:${PATH}' >> ~/.bashrc
source ~/.bashrc

# Add Maven Home
echo 'export M2_HOME=/opt/maven' >> ~/.bashrc
echo 'export MAVEN_HOME=/opt/maven' >> ~/.bashrc
source ~/.bashrc
echo 'export PATH=${M2_HOME}/bin:${PATH}' >> ~/.bashrc
source ~/.bashrc


# Check versions
java --version
mvn -version
gradle -v