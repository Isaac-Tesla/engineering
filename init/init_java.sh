#!/bin/bash

<<COMMENT

  Summary:
  The following code will install Java and the build tools
    Gradle and Maven. The versions are output at the end of
    the install as confirmation.

  Note: Gradle is installed with snap and assumes that snap
    is already installed.

COMMENT


apt install -y \
    openjdk-11-jdk \
    openjdk-11-jre \
    openjdk-8-jdk \
    maven

sudo snap install gradle --classic

java --version
mvn -version
gradle -v